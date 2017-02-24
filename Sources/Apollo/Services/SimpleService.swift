//
//  SimpleService.swift
//  Apollo
//
//  Created by Joseph Daniels on 31/10/2016.
//  Copyright © 2016 Joseph Daniels. All rights reserved.
//

import Foundation
import RxSwift

open class Welcome : Service{
    open var observable: Observable<ServiceStatusable> {
        return .empty()
    }
    open var name: String {
        return "Apollo Launch!"
    }

}
