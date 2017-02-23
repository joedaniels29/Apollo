//
//  SimpleService.swift
//  Apollo
//
//  Created by Joseph Daniels on 31/10/2016.
//  Copyright © 2016 Joseph Daniels. All rights reserved.
//

import Foundation
import RxSwift

public class Welcome : Service{
    public var observable: Observable<ServiceStatusable> {
        return .empty()
    }
    public var name: String {
        return "Apollo Launch!"
    }

}
