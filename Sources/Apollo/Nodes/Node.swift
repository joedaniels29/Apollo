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
import SwiftyBeaver

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

public let log = SwiftyBeaver.self


public protocol Node {
    var name: String { get }
}

public final class RemoteNode: Node {
    public var name: String { return "RemoteNode" }
    //    subscript(type:Service.Type) -> Service? {
    //        return services.first { type(of: $0) == type}
    //    }
}
open class LocalNode: NSObject, Node {
      public class var name: String { return "LocalNode" }
    public var name: String { return "LocalNode" }
    var bag: DisposeBag = DisposeBag()
    public let scheduler: SerialDispatchQueueScheduler
    public let q: DispatchQueue
    public var started: Bool = false

    let startingSubject = ReplaySubject<()>.create(bufferSize: 1)
    public var starting: Observable<()> { return startingSubject.asObservable().subscribeOn(self.scheduler) }

    let didFinishLaunchingSubject = ReplaySubject<()>.create(bufferSize: 1)
    public var didFinishLaunching: Observable<()> { return didFinishLaunchingSubject.asObservable().subscribeOn(self.scheduler) }
    func setDidFinishLaunching() {
        didFinishLaunchingSubject.onNext()
        //        didFinishLaunchingSubject.onCompleted()
    }
    let willTerminateSubject = ReplaySubject<()>.create(bufferSize: 1)
    public var willTerminate: Observable<()> { return willTerminateSubject.asObservable().subscribeOn(self.scheduler) }
    public func setWillTerminate() {

        willTerminateSubject.onNext()
        //        willTerminateSubject.onCompleted()
    }
    var services = [Service]()
    public subscript(type: Service.Type) -> Service? { return services.first { type(of: $0) == type } }

    public func add(service: Service) {
        q.async {
            self.services.append(service)
            if (self.started) { self.subscribe(to: service) }
        }
    }

    public func start() {
        q.async {
            self.startServices()
            self.startingSubject.onNext()
            //            self.startingSubject.onCompleted()
            self.setDidFinishLaunching()
            self.updateDescription.map(self.currentNodeDescription).bindTo(self.nodeDescription).disposed(by: self.bag)
            self.started = true
        }
    }

    func subscribe(to: Service) {
        q.async {
            to.observable.subscribeOn(self.scheduler).subscribe {
                switch ($0) {
                case .next(let g): self.service(to, didTransitionTo: g.record)
                case .error(let error): self.service(to, didError: error)
                case .completed: self.serviceDidComplete(to)
                }
            }.disposed(by: self.bag)
        }
    }

    func startServices() {
        for s in self.services {
            subscribe(to: s)
        }
    }

    public override init() {
        let c = ConsoleDestination()
        c.minLevel = .verbose;
        c.format = "$DHH:mm:ss.SSS$d $C$L$c - $M"

        log.addDestination(c)

      q = DispatchQueue.init(label: type(of:self).name, qos: .userInitiated)
        scheduler = SerialDispatchQueueScheduler(queue: q,
                                                 internalSerialQueueName:  type(of:self).name)
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
        return ["InstantiationDate": systemDateFormatter.string(from: instantiationDate)]
    }
}
public final class ApplicationNode: LocalNode {

    public static let instance = ApplicationNode()
    public override var name: String { return "ApplicationNode" }
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
            _ = Reactive(context).sentMessage(willFinishLaunching).map { _ in
                return ()
            }.take(1).multicast(didFinishLaunchingSubject).connect().disposed(by: bag)
            _ = Reactive(context).sentMessage(willTerminate).map { _ in
                return ()
            }.take(1).multicast(didFinishLaunchingSubject).connect().disposed(by: bag)
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
