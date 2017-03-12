//
// Created by Joseph Daniels on 31/10/2016.
// Copyright (c) 2016 Joseph Daniels. All rights reserved.
//

import Foundation
import RxSwift


// *start* ----> (.loading) ---> (.starting) ---> (.running) ---> (.stopping) ---> (.terminated) ---|


//service should be
// Observable describing the work. 
//typealias Service = Observable<ServiceRecord>

//ServiceRecord should be the vocabulary for how you describe the work
public  protocol ServiceStatusable {
    var record: ServiceRecord { get }
}

public enum ServiceRecord: ServiceStatusable {
    //    always
    case starting, running, terminated
    //    maybes.
    case loading, stopping, error
    public var record: ServiceRecord {
        return self
    }
}

//Service Scheduler is where the work happens.
//extension SchedulerType

//Itinerary.scheduler(named:.)
public protocol Service:class {
    var observable: Observable<ServiceStatusable> { get }
    var name: String { get }
    var node: Node { get }
//    todo: each service should have a UUID.
//    var uuid: UUID { get }
//    init(serviceRequest:ServiceRequest): UUID { get }
}
extension Service{
    
    public var name: String{
        return String(describing: type(of:self))
    }
    public var node: Node{
        return ApplicationNode.instance
    }
}
//public enum Timelyness{
//    case period(TimeInterval)
//    case dateComponents(DateComponents)
//}
public protocol PeriodicService: Service{
    var observable: Observable<ServiceStatusable> { get }
    var period:TimeInterval { get }
    var name: String { get }
}
// do stuff as least often as possible. will require NSUserDefaults on mac.
public protocol LazyPeriodicService: Service{

}
// plan on doing stuff on a schedule, but its better to do it too often than not enough.
public protocol EagerPeriodicService: Service{

}

open class Itinerary: ImmediateSchedulerType {
    public struct Name {
        public var name: String
        public static let didFinishLaunching = Name(name: "didFinishLaunching")
        public static let willFinishLaunching = Name(name: "willFinishLaunching")
    }


    static var instances: [String: Itinerary] = [:]
    static var tasks: [() -> ()] = []

    var valid: Bool = true

    open func schedule<StateType>(_ state: StateType, action: @escaping (StateType) -> Disposable) -> Disposable {
        guard valid  else {
            print("invalid schedule: \(name.name)")
            return action(state)
        }

        let d = SingleAssignmentDisposable()
        Itinerary.tasks.append {
            guard !d.isDisposed else {
                return
            }
            d.setDisposable(action(state))
        }
        return d
    }
    var name: Name
    init(named: Itinerary.Name) {
        name = named
    }

    open static func scheduler(_ named: Itinerary.Name) -> Itinerary {
        if instances[named.name] == nil {
            instances[named.name] = Itinerary(named: named)
        }

        return instances[named.name]!
    }

    open func flush() {
        while !Itinerary.tasks.isEmpty {
            Itinerary.tasks.removeFirst()()
        }
    }

    func invalidate() {
        valid = false
    }
}


//
protocol ServiceProvider {
    func runnable() -> Observable<ServiceRecord>
}
