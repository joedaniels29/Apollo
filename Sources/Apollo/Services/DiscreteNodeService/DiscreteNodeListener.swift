//
// Created by Joseph Daniels on 3/7/17.
// Copyright (c) 2017 Joseph Daniels. All rights reserved.
//

#if false
import Foundation
import RxSwift
import RxCocoa

public enum DiscreteNodeTask{
    case osascript(NSURL)
//    case block(NSURL)

}

public class DiscreteNodeService: Service{
    var task:DiscreteNodeTask
    public init(task:DiscreteTask){
        self.task = task
    }
    public var observable: Observable<ServiceStatusable> {
        return .create{ o in
            //S = create service.
//            observe S for exits.
//            s.abnormalExit.subscribe{ o.sendError()}
//            wait / poll for S to become registered with OS via XPC
//            N = register RemoteNode(S) as an xpc node
//             ...toil
//            remote should send closing time.subscribe{
//                  unregister N
//            }
//            o.onCompleted()

            return SingleAssignmentDisposable()

        }
    }

}
#endif
