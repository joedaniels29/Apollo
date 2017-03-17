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

import Dispatch
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
open class LocalNode: NSObject, Node {
    class var name: String { return A.wrap("AbstractNode") }
    var bag: DisposeBag = DisposeBag()
    public let scheduler: SerialDispatchQueueScheduler
    public let q: DispatchQueue
    public var started: Bool = false

    let startingSubject = PublishSubject<()>()
    public var starting: Observable<()> { return startingSubject.asObservable() }

    let didFinishLaunchingSubject = PublishSubject<()>()
    public var didFinishLaunching: Observable<()> { return didFinishLaunchingSubject.asObservable() }
    func setDidFinishLaunching() {
        didFinishLaunchingSubject.onNext()
    }
    let willTerminateSubject = PublishSubject<()>()
    public var willTerminate: Observable<()> { return willTerminateSubject.asObservable() }
    public func setWillTerminate() {
        willTerminateSubject.onNext()
    }
    var services = [Service]()
    public subscript(type: Service.Type) -> Service? { return services.first { type(of: $0) == type } }
    public func add(service:Service){
        services.append(service)
    }

    public func start() {
        startServices()
        setDidFinishLaunching()
        updateDescription.map(currentNodeDescription).bindTo(nodeDescription).disposed(by: bag)
    }

    func startServices() {
        for s in self.services {
            s.observable.subscribe {
                switch ($0) {
                case .next(_):() //print(s.name)
                case .error(let error): self.service(s, didError: error)
                case .completed: self.serviceDidComplete(s)
                }
            }.disposed(by: bag)
        }
    }

    public override init() {
        q = DispatchQueue.init(label: ApplicationNode.name)
        scheduler = SerialDispatchQueueScheduler(queue: q,
                                                 internalSerialQueueName: ApplicationNode.name)
        services.append(Welcome())
        super.init()
        updateDescription.onNext()
    }
    var updateDescription = PublishSubject<()>()

    var instantiationDate = Date()
    var startupDate: Date? = nil
    lazy var systemDateFormatter: DateFormatter = {
        let v = DateFormatter()
        v.dateFormat = "M/d/yy H:m:s"
        return v
    }()

    lazy public var nodeDescription: Variable<[String: String]> = Variable(["Status": "Not yet loaded"])

    func currentNodeDescription() -> [String: String] {
        return ["InstantiationDate":systemDateFormatter.string(from: instantiationDate)]
    }
}
public final class ApplicationNode: LocalNode {

    public static let instance = ApplicationNode()
    class override var name: String { return A.wrap("LocalNode") }
    var context: AnyObject?
    var platformHasLifeCycle: Bool = false

    override init() {

        super.init()
    }

    public override func start() {
        platformHasLifeCycle = false
        super.start()
    }

    public func start(context: AnyObject) {
        platformHasLifeCycle = true
        guard !started else {
            fatalError()
        }
        guard !self.started else {
            fatalError()
        }
        self.started = true
        self.context = context



        if platformHasLifeCycle {
#if os(iOS)
            let willFinishLaunching: Selector = #selector(UIApplicationDelegate.application(_:didFinishLaunchingWithOptions:))
            let willTerminate: Selector = #selector(UIApplicationDelegate.application(_:didFinishLaunchingWithOptions:))
#elseif os(macOS)
            let willFinishLaunching: Selector = #selector(NSApplicationDelegate.applicationDidFinishLaunching(_:))
      		let willTerminate: Selector = #selector(NSApplicationDelegate.applicationDidFinishLaunching(_:))

            _ = Reactive(context).sentMessage(willFinishLaunching).map { _ in
                return ()
            }.take(1).multicast(didFinishLaunchingSubject).connect().disposed(by: bag)
            _ = Reactive(context).sentMessage(willTerminate).map { _ in
                  return ()
            }.take(1).multicast(didFinishLaunchingSubject).connect().disposed(by: bag)
#else
	      fatalError("cant get here")
#endif
        } else {
            setDidFinishLaunching()
        }

        self.startServices()
    }


    override func currentNodeDescription() -> [String: String] {
        var d = super.currentNodeDescription()
        let newer = [String: String]()
        for (k, v) in newer {
            d[k] = v
        }
        return d
    }



    //Communication
    //    lazy var activeNeighbors: Variable<[Node]> = Variable([self])
    lazy var nodes: Variable<[Node]> = Variable([self])


    //    Services
}
