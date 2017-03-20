//
// Created by Joseph Daniels on 3/7/17.
// Copyright (c) 2017 Joseph Daniels. All rights reserved.
//

import Foundation
#if false




class DiscreteNode:LocalNode{
    var service:Service
    init(service:Service){

        self.service = service
        super.init()
    }




}

class BlockDiscreteNode:LocalNode{
    let block:(()->())
    init(block:()->()){
        self.block = block
        super.init()

    }



    static func run(block:()->()){
        let node = self.init(block)
        node.start()
    }
}
#endif
