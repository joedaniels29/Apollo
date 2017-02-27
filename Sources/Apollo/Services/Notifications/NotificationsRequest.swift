//
// Created by Joseph Daniels on 31/10/2016.
// Copyright (c) 2016 Joseph Daniels. All rights reserved.
//

import Foundation

#if os(iOS) || os(watchOS)
import RxSwift
import UserNotifications

public class UNUserNotificationAuthorization: Service {
    var dbag = DisposeBag()
    public var observable: Observable<ServiceStatusable> {
        return .create { o in
            let d = BooleanDisposable()
            LocalNode
                .instance
                    .didFinishLaunching
                    .subscribe(onNext: { _ in
                        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { authorized, err in
                                    guard !d.isDisposed else {
                                        return
                                    }
                                    if let err = err {
                                        o.onError(err)
                                    }
		                            o.onNext(authorized ? ServiceRecord.running : ServiceRecord.terminated)
                                    o.onCompleted()
                                }
                    }).addDisposableTo(self.dbag)
                return d
        }
    
    }

    public var name: String {
        return "Notifications auth"
    }
}
    
#endif
