//
// Created by Joseph Daniels on 3/13/17.
// Copyright (c) 2017 Joseph Daniels. All rights reserved.
//

import Foundation
import RxSwift

typedef ServiceObservableBlock =
class StructuredService: Service {
    //    todo: should be tied to Node Lifecycle.
    //    ie providing a starting: block should run on start()
    //    loading: should run on applicationDidFinishLaunching.
    //    running should run after previous, and takeUntil()  application stop is called.
    //    stopping should run after running sends onComplete()
    //    error should run on error. obviously.

    //    strict: if initialization can ONLY happen as part of node lifecycle. (should be a fatal error otherwise.)

    let observable: Observable<ServiceStatusable>
    let name: String
    let bag = DisposeBag()
    convenience init(name: String, starting: ServiceObservableBlock?, loading: ServiceObservableBlock?, running: ServiceObservableBlock, stopping: ServiceObservableBlock?, error: ServiceObservableBlock?, strictLaunch: Bool = false) {

        self.init(name: name, starting: .just(starting), loading: <#T##ServiceObservable?##ServiceObservable?#>, running: <#T##ServiceObservable##ServiceObservable#>, stopping: <#T##ServiceObservable?##ServiceObservable?#>, error: <#T##ServiceObservable?##ServiceObservable?#>, strictLaunch: <#T##Bool##Swift.Bool#>)

    }
    init(name: String, starting: ServiceObservable?, loading: ServiceObservable?, running: ServiceObservable, stopping: ServiceObservable?, error: ServiceObservable?, strictLaunch: Bool = false) {
        self.name = name
        if let localNode = self.node as? LocalNode {
            var collected = ServiceObservable.just(ServiceRecord.starting)

            if let starting = starting?.publish() {
                var disposable: Disposable? = nil
                localNode.starting.subscribe { event in
                    switch (event) {
                    case .completed:
                        if disposable != nil {
                            if strictLaunch { fatalError("Observable subscribed after didFinishLaunching") }
                            return
                        }
                        fallthrough
                    case .next: disposable = starting.connect()
                    }
                    if let disposable = disposable { self.bag.insert(disposable) }
                }.disposed(by: self.bag)
                collected = collected.concat(starting)
            }

            if let loading = loading?.publish() {
                var disposable: Disposable? = nil
                collected = collected.concat(ServiceObservable.just(ServiceRecord.loading))
                localNode.didFinishLaunching.subscribe { event in
                    switch (event) {
                    case .completed:
                        if disposable != nil {
                            if strictLaunch { fatalError("Observable subscribed after didFinishLaunching") }
                            return
                        }
                        fallthrough
                    case .next: disposable = cStarting.connect()
                    }
                    if let disposable = disposable { self.bag.insert(disposable) }
                }.disposed(by: self.bag)
                collected = collected.concat(loading)
            }
            collected = collected.concat(ServiceObservable.just(ServiceRecord.running))
            collected = collected.concat(running).takeUntil(localNode.willTerminate)
            if let stopping = stopping {
                collected = collected.concat(ServiceObservable.just(ServiceRecord.stopping))
                collected = collected.concat(stopping)
            }
            collected = collected.concat(ServiceObservable.just(ServiceRecord.terminated))
            if let error = error {
                collected = collected.catchError { _ in error }
            }
            self.observable = collected
        } else {

            self.observable = [starting, loading, running, stopping].flatMap { $0 }.reduce(ServiceObservable.empty()) { $0.concat($1) }
        }
    }
}

class BlockService: Service {
    let name: String
    init(name: String, block: () -> ()) {
        self.name = name
        observable = .create { ServiceRecord.wrap(observer: $0, block: block) }
    }

    let observable: Observable<ServiceStatusable>


}
