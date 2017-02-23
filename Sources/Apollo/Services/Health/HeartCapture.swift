//
// Created by Joseph Daniels on 25/12/16.
// Copyright (c) 2016 Joseph Daniels. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
class HeartCapture:Service {
    var observable: Observable<ServiceStatusable> {
        return .empty()
    }
    var name: String {
        return "Heart Capture"
    }

}
