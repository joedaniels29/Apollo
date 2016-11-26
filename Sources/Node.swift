//
//  Node.swift
//  Apollo
//
//  Created by Joseph Daniels on 31/10/2016.
//  Copyright © 2016 Joseph Daniels. All rights reserved.
//

import Foundation
import RxSwift



class A{
    static let title:String = "Apollo"
    static func wrap(string: String) -> String{
        return "\(A.title)::\(string)"
    }
    static func warn(_ string: String) -> String{
        return wrap(string:"WARN::\(string)")
    }
    static func err(_ string: String) -> String{
        return wrap(string:"WARN::\(string)")
    }
    static func info(_ string: String) -> String{
        return wrap(string:"WARN::\(string)")
    }
    
    
}
protocol Node{
}

final class LocalNode:Node{
    
    
    
    static let name:String = A.wrap(string:"LocalNode")
    let scheduler : SerialDispatchQueueScheduler
//    let queue: DispatchQueue = DispatchQueue(label: MainNode.name, qos: .userInitiated, autoreleaseFrequency: .workItem)
    init(){
        
        scheduler = SerialDispatchQueueScheduler(queue: DispatchQueue.init(label: LocalNode.name),
                                     internalSerialQueueName: LocalNode.name)
    }
    
    let instance = LocalNode()
    var started:Bool = false
    func start(){
//        queue.sync {
            self.started = true
            //servies start.
//        }
    }
    
    
}
