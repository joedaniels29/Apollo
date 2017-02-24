//
//  Node.swift
//  Apollo
//
//  Created by Joseph Daniels on 31/10/2016.
//  Copyright © 2016 Joseph Daniels. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

#if os(iOS)

import UIKit

#elseif os(watchOS)

import UIKit
import WatchKit

#elseif os(macOS)

import AppKit

#elseif os(Linux)

import Glibc

//something like that
#endif
class A {
    static let title: String = "Apollo"
    static func wrap(_ string: String) -> String {
        return "\(A.title)::\(string)"
    }

    static func warn(_ string: String) -> String {
        return wrap("WARN::\(string)")
    }

    static func err(_ string: String) -> String {
        return wrap("WARN::\(string)")
    }

    static func info(_ string: String) -> String {
        return wrap("WARN::\(string)")
    }
}
public protocol Node {
//
}

public final class RemoteNode: Node {

//    subscript(type:Service.Type) -> Service? {
//        return services.first { type(of: $0) == type}
//    }
}
public final class LocalNode: Node {

    static let name: String = A.wrap("LocalNode")

    var context: AnyObject!
    public let scheduler: SerialDispatchQueueScheduler
    public let q: DispatchQueue
	
    //    let queue: DispatchQueue = DispatchQueue(label: MainNode.name, qos: .userInitiated, autoreleaseFrequency: .workItem)
    init() {
        q = DispatchQueue.init(label: LocalNode.name)
        scheduler = SerialDispatchQueueScheduler(queue: q,
                                                 internalSerialQueueName: LocalNode.name)
        services.append(Welcome())
    }

    public static let instance = LocalNode()
    public var started: Bool = false
    public func start(context: NSObject) {
        guard !started  else {
            fatalError()
        }
            guard !self.started  else {
                fatalError()
            }
            self.started = true
            self.context = context
                self.startServices()
    }
    var services = [Service]()
    var disposeBag = DisposeBag()
    public subscript(type:Service.Type) -> Service? {
        return services.first { type(of: $0) == type}
    }





    func startServices() {
        for s in self.services {
            s.observable.subscribe {
                        switch ($0) {
                        case .next(_):() //print(s.name)
                        case .error(let error): self.service(s, didError: error)
                        case .completed: self.serviceDidComplete(s)
                        }
                    }.addDisposableTo(self.disposeBag)
        }
    }

    var didFinishLaunching: Observable<()> {
#if os(watchOS)
        return Reactive(self.context).sentMessage(#selector(WKExtensionDelegate.applicationDidFinishLaunching())).map { _ in
            return ()
        }.take(1)
#elseif os(iOS)
        return Reactive(self.context).sentMessage(#selector(UIApplicationDelegate.application(_:didFinishLaunchingWithOptions:))).map { _ in
            return ()
        }.take(1)
#elseif os(macOS)
    return Reactive(self.context).sentMessage(#selector(NSApplicationDelegate.applicationDidFinishLaunching(_:))).map { _ in
        return ()
        }.take(1)
#endif
    }



    var willTerminate: Observable<()> {
#if os(iOS)
        return Reactive(self.context).sentMessage(#selector(UIApplicationDelegate.applicationWillTerminate(_ :))).map { _ in
            return ()
        }.take(1)
#elseif os(macOS)
        return Reactive(self.context).sentMessage(#selector(NSApplicationDelegate.applicationWillTerminate(_:))).map { _ in
            return ()
        }.take(1)
#endif
    }


    fileprivate func service(_ service: Service, didError: Any) {
		    fmt(service, print: "Completed")
    }
    fileprivate func fmt(_ service:Service, print msg:String) {
        print("[\(service.name)] — \(DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .medium)) ::: \(msg)")
    }
    fileprivate func serviceDidComplete(_ service: Service) {
        fmt(service, print: "Completed")
    }
}
