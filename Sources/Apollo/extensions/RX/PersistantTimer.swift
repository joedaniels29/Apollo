//
// Created by Joseph Daniels on 26/12/16.
// Copyright (c) 2016 Joseph Daniels. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
enum PersistantTimeConfig {
    case atLeast, atMost
}
extension Observable where Element: SignedInteger {

    public static func interval(_ `for`: String,
                                period: RxTimeInterval,
                                scheduler: SchedulerType) -> Observable<Element> {
        return persistentTimer(`for`, dueTime: 0, period: period, scheduler: scheduler)
    }

    public static func persistentTimer(_ `for`: String,
                                       dueTime: RxTimeInterval,
                                       period: RxTimeInterval? = nil,
                                       scheduler: SchedulerType) -> Observable<Element> {
        var dateMap: [String: Date] = UserDefaults.standard.object(forKey: "rx.persistentTimerTimeMap") as? [String: Date] ?? [:]
        //todo: handle inf.
        return Observable.create { observable in
//            var d = BooleanDisposable()
            var io: Observable<Element>
            if let period = period, let date = dateMap[`for`], Date() < Date(timeInterval: period, since: date) {
                io = Observable.empty()
            } else {
                //            otherwise, we need to send now
                io = Observable.just(0).delay(dueTime, scheduler: scheduler)
            }
            if let period = period {
                io = io.concat(Observable.timer(period, period: period, scheduler: scheduler))
            }
            return io.subscribe { event in
                dateMap[`for`] = Date()
                UserDefaults.standard.set(dateMap,  forKey: "rx.persistentTimerTimeMap")
                observable.on(event)
            }
        }
    }
}
