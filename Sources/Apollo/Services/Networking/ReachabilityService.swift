//
// Created by Joseph Daniels on 2/25/17.
// Copyright (c) 2017 Joseph Daniels. All rights reserved.
//

import Foundation
import RxSwift



class ReachabilityService:Service {
    #if os(iOS) || os(macOS)
    var observable: Observable<ServiceStatusable> {
        return .create { (observer: AnyObserver<ServiceStatusable>) in

            return SingleAssignmentDisposable()


        }
    }
    #elseif os(watchOS)
    #elseif os(Linux)
    var observable: Observable<ServiceStatusable> {
        return .just(.running)
    }

    #endif


}
