import PackageDescription

let package = Package(
    name: "Apollo",
    
    dependencies: [
        .Package(url:"../Ruby", majorVersion: 0),
        .Package(url: "https://github.com/ReactiveX/RxSwift.git", Version(3, 0, 0, prereleaseIdentifiers: ["rc"])),
         .Package(url: "https://github.com/apple/swift-protobuf.git", Version(0,9,24))
        //.Package(url: "https://github.com/Alamofire/Alamofire", Version(4, 0, 0))
    ]
)
