//
//  SimpleService.swift
//  Apollo
//
//  Created by Joseph Daniels on 31/10/2016.
//  Copyright © 2016 Joseph Daniels. All rights reserved.
//

import Foundation
import RxSwift
//import UserNotifications

extension ObservableType where Self.E:ServiceStatusable {
    func  wrapped() -> Observable<ServiceStatusable>{
        return Observable.of(.just(ServiceRecord.starting as ServiceStatusable),
                   self.map{$0 as ServiceStatusable},
                   .just(ServiceRecord.terminated as ServiceStatusable)).concat()
        
    }
    

}
