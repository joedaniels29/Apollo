//
// Created by Joseph Daniels on 2/25/17.
// Copyright (c) 2017 Joseph Daniels. All rights reserved.
//

import Foundation
import RxSwift



class ReachabilityService:Service {
    #if os(iOS) || os(macOS)
    var observable: Observable<Apollo.ServiceStatusable> {
        return .create { (observer: AnyObserver<Apollo.ServiceStatusable>) in




        }
    }
    #elseif os(watchOS)
    #elseif os(linux)
    var observable: Observable<Apollo.ServiceStatusable> {
        return .just(.running)
    }

    #endif


}
