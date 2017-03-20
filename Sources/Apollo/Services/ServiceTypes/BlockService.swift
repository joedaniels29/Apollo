//
// Created by Joseph Daniels on 3/13/17.
// Copyright (c) 2017 Joseph Daniels. All rights reserved.
//

import Foundation
import RxSwift


class BlockService: StructuredService {
    init(name: String, node:Node? = nil, block: @escaping () -> ()) {
        super.init(name: name, running: .create { o in
            block()
            o.onCompleted()
            return BooleanDisposable()
        }, node:node)
    }
}
