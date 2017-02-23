//: Playground - noun: a place where people can play

import AppKit

var str = "Hello, playground"
var defaults = UserDefaults.standard
defaults.set(NSKeyedArchiver.archivedData(withRootObject: NSColor.blue), forKey:"blue")

if let data = defaults.data(forKey:"blue"),  let val = NSKeyedUnarchiver.unarchiveObject(with: data) as? NSColor{
    print(val)
}