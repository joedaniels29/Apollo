//
// Created by Joseph Daniels on 2/27/17.
// Copyright (c) 2017 Joseph Daniels. All rights reserved.
//

import Foundation

protocol MirrorDescribable {
    var mirrorDescription:[String:Any] { get }
}

extension MirrorDescribable{

    var mirrorDescription: [String: Any]{
        var mirror: Mirror? = Mirror(reflecting: self)
        var objectDictionary = [String : Any]()

        while let currentMirror = mirror {
            for (propertyName, value) in currentMirror.children {
                if let propertyName = propertyName {
                    objectDictionary[propertyName] = value
                }
            }
            mirror = currentMirror.superclassMirror
        }

        return objectDictionary
    }
    var preservingChildren:[String]{
        return ( Mirror(reflecting: self).children.flatMap { $0.0 }) 
    }
}
