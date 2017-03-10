//: Playground - noun: a place where people can play

import UIKit
import ObjectiveC



var str = "Hello, playground"


objc_begin_catch(UnsafeMutableRawBufferPointer())
get_thread_data
NSException(name: NSExceptionName(rawValue:"Oh Gurl!"), reason: "I said so", userInfo: nil).raise()
objc_end_catch()