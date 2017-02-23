//
// Created by Joseph Daniels on 31/10/2016.
// Copyright (c) 2016 Joseph Daniels. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

#if os(iOS) || os(watchOS)

import UserNotifications

//
open class NotificationCenter: NSObject, UNUserNotificationCenterDelegate {
    var sharedCenter = NotificationCenter()


    // The method will be called on the delegate only if the application is in the foreground. If the method is not implemented or the handler is not called in a timely manner then the notification will not be presented. The application can choose to have the notification presented as a sound, badge, alert and/or in the notification list. This decision should be based on whether the information in the notification is otherwise visible to the user.
    @available(iOS 10.0, *)
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Swift.Void) {
        let completion: ConnectableObservable<()> = Observable.empty().publish()
        let d = DisposeBag()
        switch notification.request.identifier {
        case "You're totally Lost": Observable<String>.create {
            $0.onNext("Cool, a notification!")
            $0.onCompleted()
            return BooleanDisposable()
        }.subscribe(onNext: { print($0) }, onCompleted: { completion.connect() }).addDisposableTo(d)
        default: _ = completion.connect()
        }

        completion.subscribe(onCompleted: {
            completionHandler([])
        })
    }


    // The method will be called on the delegate when the user responded to the notification by opening the application, dismissing the notification or choosing a UNNotificationAction. The delegate must be set before the application returns from applicationDidFinishLaunching:.
    @available(iOS 10.0, *)
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Swift.Void) {
        switch response.actionIdentifier {
        default: ()
        }
    }
}
#endif
