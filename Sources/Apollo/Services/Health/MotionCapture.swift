//
// Created by Joseph Daniels on 25/12/16.
// Copyright (c) 2016 Joseph Daniels. All rights reserved.
//

#if os(iOS) || os(watchOS)

import Foundation
import RxSwift
import UIKit
import Dispatch
import CoreMotion

#if SWIFT_PACKAGE

import ApolloSupport

#endif
class MotionRequest: PeriodicService {

    var period: TimeInterval {
        return 6 * 60 * 60
    }

    public let backgroundQueue = DispatchQueue(label: "MotionRequest")
    public let recordDuration: TimeInterval = 60 * 60 * 9

    fileprivate func updateSensorRecording() -> Bool {
        dispatchPrecondition(condition: .onQueue(self.backgroundQueue))
        let recorder = CMSensorRecorder()
#if TARGET_OS_SIMULATOR
        return false
#else
        recorder.recordAccelerometer(forDuration: self.recordDuration)
#endif
        return CMSensorRecorder.isAccelerometerRecordingAvailable() && CMSensorRecorder.isAuthorizedForRecording()
    }

    var observable: Observable<ServiceStatusable> {
        return .create { observer in

            self.ableToHistoricallyRecord = self.updateSensorRecording()
            return SingleAssignmentDisposable()
        }
    }
    var name: String {
        return "Motion Request"
    }
    private var ableToHistoricallyRecord: Bool = false
}

public struct Acceleration {
    var x: Double
    var y: Double
    var z: Double
    var timestamp: Double
}
public class MotionResult: ServiceStatusable {
    public var result: (Date, [Acceleration])
    public var record: ServiceRecord
    init(result:(Date, [Acceleration]), record:ServiceRecord) {
        self.record = record
        self.result = result
    }
}


public class MotionCapture: Service {
    public var period: TimeInterval {
        return 6 * 60 * 60
    }


    public var observable: Observable<ServiceStatusable> {
        return Observable<Int>.persistentTimer( self.name,
                                                dueTime: 0,
                                                period: period,
                                                scheduler: SerialDispatchQueueScheduler(internalSerialQueueName: self.name)
            ).map { _ in
            let bootTime = Date(timeIntervalSinceNow: -ProcessInfo.processInfo.systemUptime)

            let box: MotionResult = MotionResult(result:(bootTime, [Acceleration]()), record:.running)
            if self.ableToHistoricallyRecord {
                try ObjC.catchException {
                    if let data = CMSensorRecorder().accelerometerData(from: Date().addingTimeInterval(-1 * self.period), to: Date()) {
                        let g = NSFastEnumerationIterator(data)
                        box.result.1.reserveCapacity(Int(Double(abs( self.period ) + 1.0) * 50))
                        while let datum = g.next() {
                            let datum = datum as! CMRecordedAccelerometerData
                            box.result.1.append(Acceleration(x: datum.acceleration.x, y: datum.acceleration.y, z: datum.acceleration.z, timestamp: datum.timestamp))
                            let eventDate = Date(timeInterval: datum.timestamp, since: bootTime)
                            if eventDate > box.result.0 {
                                 box.result.0 = eventDate
                            }
                        }
                    }
                }
                return box
            }
            return box
        }
    }

    private var ableToHistoricallyRecord: Bool {
        guard let mr = LocalNode.instance[MotionRequest.self] as? MotionCapture else {
            return false
        }
        return mr.ableToHistoricallyRecord
    }
}
#endif
