//
// Created by Joseph Daniels on 2/25/17.
// Copyright (c) 2017 Joseph Daniels. All rights reserved.
//

import Foundation

#if os(macOS)

import AppKit
import RxSwift
import RxCocoa
class ActiveApplicationService: Service {
    var observable: Observable<ServiceStatusable> {
        return NSWorkspace.shared().notificationCenter.rx.notification(.NSWorkspaceDidActivateApplication).map{ _ in
            	return ServiceRecord.running
            }
        }
}
#endif
