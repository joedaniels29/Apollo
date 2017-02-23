//
// Created by Joseph Daniels on 25/12/16.
// Copyright (c) 2016 Joseph Daniels. All rights reserved.
//

#if os(iOS) || os(watchOS)

import Foundation
import RxSwift
import UIKit
import Dispatch
    #if SWIFT_PACKAGE
    import ApolloSupport
    #endif
class MotionRequest: PeriodicService {
    
    var period: TimeInterval {
        return 6 * 60 * 60
    }

    public let backgroundQueue = DispatchQueue()
    public let recordDuration: TimeInterval = 60 * 60 * 9

    fileprivate func updateSensorRecording() -> Bool {
        dispatch_assert_queue(self.backgroundQueue)
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
        }
    }
    var name: String {
        return "Motion Request"
    }
    private let ableToHistoricallyRecord: Bool = false
}

class MotionCapture: Service {
    var observable: Observable<ServiceStatusable> {
        return .create { observer in
            if self.ableToHistoricallyRecord {
                let bootTime = Date(timeIntervalSinceNow: -ProcessInfo.processInfo.systemUptime)
                self.retAcc = []
                self.retDate = start
                do {
                    try ObjC.catchException {
                        if let data = CMSensorRecorder().accelerometerData(from: start, to: end) {
                            let g = NSFastEnumerationIterator(data)
                            self.retAcc.reserveCapacity(Int(Double(abs(end.timeIntervalSince(start)) + 1.0) * 50))
                            while let datum = g.next() {
                                let datum = datum as! CMRecordedAccelerometerData
                                self.retAcc.append(Acceleration(x: datum.acceleration.x, y: datum.acceleration.y, z: datum.acceleration.z, timestamp: datum.timestamp))
                                let eventDate = Date(timeInterval: datum.timestamp, since: bootTime)
                                if eventDate > self.retDate! {
                                    self.retDate = eventDate
                                }
                            }
                        }
                    }
                } catch {
                    ErrorManager.logError(error)
                    self.retDate = end
                }
                let returnable = (self.retAcc, self.retDate!)
                self.retAcc = []
                self.retDate = nil
                return returnable
            }
            return ([], Date())
        }
    }

    private var ableToHistoricallyRecord: Bool{
        guard let mr = Node.current[MotionRequest.self] else {
            return false
        }
        return mr.ableToHistoricallyRecord
    }
}
#endif
