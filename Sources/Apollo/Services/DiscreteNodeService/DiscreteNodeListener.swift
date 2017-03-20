//
// Created by Joseph Daniels on 3/7/17.
// Copyright (c) 2017 Joseph Daniels. All rights reserved.
//

#if false
import Foundation
import RxSwift
import RxCocoa
import XPC
public enum DiscreteNodeTask{
    case osascript(NSURL)
//    case block(NSURL)

}
//
// Created by Joseph Daniels on 3/19/17.
// Copyright (c) 2017 Joseph Daniels. All rights reserved.
//

import Foundation
import RxSwift
open class DiscreteNodeListenerService: StructuredService {
    init(name: String,node: Node?) {
        super.init(name: name, starting: ServiceObservable? = nil,
                   loading: ServiceObservable? = nil,
                   running: ServiceObservable,
                   stopping: ServiceObservable? = nil,
                   error: ServiceObservable? = nil,
                   strictLaunch: Bool = false,
                   node:Node? = nil)
    }
}

#endif
