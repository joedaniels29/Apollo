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
protocol ServiceStatusable{
    var record:ServiceRecord { get }
}
enum ServiceRecord:ServiceStatusable {
    //    always
    case starting, running, terminated
    //    maybes.
    case loading, stopping, error
    var record:ServiceRecord { return self }
}

//Service Scheduler is where the work happens.
//extension SchedulerType

//Itinerary.scheduler(named:.)

class Itinerary: ImmediateSchedulerType {
    struct Name {
        var name:String
        static let didFinishLaunching = Name(name: "didFinishLaunching")
        static let willFinishLaunching = Name(name: "willFinishLaunching")
    }



    static var instances: [String: Itinerary] = [:]
    static var tasks: [() -> ()] = []

    var  valid:Bool = true
    
    func schedule<StateType>(_ state: StateType, action: @escaping (StateType) -> Disposable) -> Disposable {
        guard valid  else {
            print("invalid schedule: \(name.name)")
            return action(state) }
		
        let d = SingleAssignmentDisposable()
        Itinerary.tasks.append {
            guard !d.isDisposed else { return }
            d.setDisposable(action(state))
        }
        return d
    }
    var name:Name
    init(named:Itinerary.Name){
    	name = named
    }
    
    static func scheduler(named: Itinerary.Name) -> ImmediateSchedulerType {
        if instances[named.name] == nil {
            instances[named.name] = Itinerary(named:named)
        }

        return instances[named.name]!
    }

    func flush() {
        while !Itinerary.tasks.isEmpty { Itinerary.tasks.removeFirst()() }
    }
    
    func invalidate() {
        valid = false
    }
}



//
protocol ServiceProvider {
    func runnable() -> Observable<ServiceRecord>
}
