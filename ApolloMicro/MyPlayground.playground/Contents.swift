//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


protocol X {
    static var insts:[X]{ get }
    static func create() -> X
    
    
    
}

final class A:X{
     static func create() -> X {
        let it = A()
        insts.append(it)
        return it
    }

    static var insts:[X] = []
    
}
struct B:X{
    static func create() -> X {
        let it = B()
        insts.append(it)
        return it
    }
    
    static var insts:[X] = []
    
}
	

var protocols:[X.Type] = [A.self, B.self]
for p in protocols {
    p.insts.forEach({print($0)})
}
