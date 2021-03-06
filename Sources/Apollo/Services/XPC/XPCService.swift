//
// Created by Joseph Daniels on 2/15/17.
// Copyright (c) 2017 Joseph Daniels. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

#if os(macOS)
      /*
      import AppKit
      
      @objc(DoWrap) open class DoWrap:NSObject{
            @objc public override init(){
                  super.init()
            }
            @objc public func doWithADoWrap(_ doit:((NSString)->())){
                  print("We Gonna do it!")
                  NSBeep()
                  doit("YA")
                  print("We Gonna did it!")
            }
      }
      
      */
@objc protocol ApolloServiceProtocol {
}
class ApolloXPCService: Service {
    var connectionInstance: NSXPCConnection? = nil

    var observable: Observable<ServiceStatusable> = .empty()
    //    var name: String { }
    var dbag = DisposeBag()
    init() {
        observable = .create { observer in
            self.connectionInstance = NSXPCConnection(serviceName: "JD.AppoloService")
            self.connectionInstance?.remoteObjectInterface = NSXPCInterface(with: ApolloServiceProtocol.self);
            self.connectionInstance?.resume()
            return SingleAssignmentDisposable()
        }

        self.observable.subscribe {
            switch ($0) {
            case .completed:
                self.connectionInstance?.invalidate()
                self.connectionInstance = nil
            default: ()
            }
        }.addDisposableTo(dbag)
    }
}


#endif
