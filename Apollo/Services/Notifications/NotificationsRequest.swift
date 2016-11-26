//
// Created by Joseph Daniels on 31/10/2016.
// Copyright (c) 2016 Joseph Daniels. All rights reserved.
//

import Foundation
import RxSwift
import UserNotifications

extension UNUserNotificationCenter{
    var authorization:Observable<Bool> {
        return .create{ o in
    		let d = SingleAssignmentDisposable()
    		self.requestAuthorization(options:[]){ authorized, err in
		        guard !d.isDisposed else {return}
		        if let err = err { o.onError(err) }
	    		    o.onNext(authorized)
	        		o.onCompleted()
	    		}
	    		return d
        }
    }
    
}
//open class NotificationsRequest: ServiceProvider{


//    override func prefix(){
//        UNUserNotificationCenter.current().delegate = NotificationCenter.instance
//    }
//    override func innerRunnable(observer:Observable<ServiceRecord>){
//        
//    }
//    

    
//}
