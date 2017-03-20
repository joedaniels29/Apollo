//
// Created by Joseph Daniels on 3/3/17.
// Copyright (c) 2017 Joseph Daniels. All rights reserved.
//

import Foundation
import SwiftyBeaver

extension Node {

    func service(_ service: Service, didTransitionTo: ServiceRecord) {
        service.info(message: "\(didTransitionTo)")
    }

    func service(_ service: Service, didError: Any) {
        service.warning(message: "Completed with error: \(didError)")
    }

    func format(_ service: Service, print msg: String) -> String{
        return "[\(service.name)] ::: \(msg)"
    }

    func serviceDidComplete(_ service: Service) {
        service.debug(message: "Completed")
    }
}
