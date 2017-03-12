//
// Created by Joseph Daniels on 3/3/17.
// Copyright (c) 2017 Joseph Daniels. All rights reserved.
//
import Foundation
extension Node{




    func service(_ service: Service, didError: Any) {
        fmt(service, print: "Completed")
    }

    func fmt(_ service: Service, print msg: String) {
        print("[\(service.name)] — \(DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .medium)) ::: \(msg)")
    }

    func serviceDidComplete(_ service: Service) {
        fmt(service, print: "Completed")
        fmt(service, print: "Completed")
    }

}
