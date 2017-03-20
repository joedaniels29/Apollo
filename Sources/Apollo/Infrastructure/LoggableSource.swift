//
// Created by Joseph Daniels on 3/19/17.
// Copyright (c) 2017 Joseph Daniels. All rights reserved.
//

import Foundation

public protocol LoggableSource{

      var name:String { get }
}
extension LoggableSource{
    func format(message: String) -> String {
        return "[\(self.name)] ::: \(message)"
    }

    func verbose(message: String) {
        log.verbose(format(message: message))
    }

    func debug(message: String) {
        log.debug(format(message: message))
    }

    func info(message: String) {
        log.info(format(message: message))
    }

    func warning(message: String) {
        log.warning(format(message: message))
    }

    func error(message: String) {
        log.error(format(message: message))
    }

}
