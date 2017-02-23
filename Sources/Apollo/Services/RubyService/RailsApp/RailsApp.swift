//
//  RailsApp.swift
//  Apollo
//
//  Created by Joseph Daniels on 26/12/16.
//  Copyright © 2016 Joseph Daniels. All rights reserved.
//

#if os(macOS) || os(Linux)


import Foundation
import RxSwift
import RxCocoa

class RailsApp:Service{
    var observable:Observable<ServiceStatusable> {
        return Observable.create{ o in
//            let v = Process()
			//fetch Ruby Service. 
            //
            
            return SingleAssignmentDisposable()
        }
    }

}
    
#endif
