//
// Created by Joseph Daniels on 3/19/17.
// Copyright (c) 2017 Joseph Daniels. All rights reserved.
//

import Foundation

open class StructuredService: Service {
    //    todo: should be tied to Node Lifecycle.
    //    ie providing a starting: block should run on start()
    //    loading: should run on applicationDidFinishLaunching.
    //    running should run after previous, and takeUntil()  application stop is called.
    //    stopping should run after running sends onComplete()
    //    error should run on error. obviously.

    //    strict: if initialization can ONLY happen as part of node lifecycle. (should be a fatal error otherwise.)

    public let observable: Observable<ServiceStatusable>
    public let name: String
    let bag:DisposeBag

    public convenience init(name: String, starting: ServiceObservableBlock?, loading: ServiceObservableBlock?, running: @escaping ServiceObservableBlock, stopping: ServiceObservableBlock?, error: ServiceObservableBlock? = nil, strictLaunch: Bool = false, node:Node? = nil) {

        self.init(name: name, starting: ServiceObservable.create <^> starting, loading: ServiceObservable.create <^> loading, running: ServiceObservable.create(running), stopping: ServiceObservable.create <^> stopping, error: ServiceObservable.create <^> error , strictLaunch: strictLaunch, node:node)

    }
    public init(name: String, starting: ServiceObservable? = nil, loading: ServiceObservable? = nil, running: ServiceObservable, stopping: ServiceObservable? = nil, error: ServiceObservable? = nil, strictLaunch: Bool = false, node:Node? = nil) {
        self.name = name
        let bag = DisposeBag()
        self.bag = bag
        let node : Node = node ?? StructuredService.defaultNode

        if let localNode =  node as? LocalNode {
            var observe = Observable<Observable<ServiceStatusable>>.of(
                    ServiceObservable.just(ServiceRecord.starting).sample(localNode.starting),
                    starting ?? .empty(),
                    ServiceObservable.just(ServiceRecord.loading).sample(localNode.didFinishLaunching),
                    loading ?? .empty(),
                    ServiceObservable.just(ServiceRecord.running),
                    running.takeUntil(localNode.willTerminate),
                    ServiceObservable.just(ServiceRecord.stopping),
                    stopping ?? .empty(),
                    ServiceObservable.just(ServiceRecord.terminated)
            ).concat()
            if let error = error {
                observe = observe.catchError { _ in error }
            }
            self.observable = observe


        } else {

            self.observable = [starting, loading, running, stopping].flatMap { $0 }.reduce(ServiceObservable.empty()) { $0.concat($1) }
        }
    }
}
