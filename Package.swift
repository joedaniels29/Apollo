import PackageDescription


var targets = [
        Target(
                name: "Apollo"
                )
]

#if os(macOS) || os(Linux)
targets.append(Target(name:"ApolloServer"))
#endif


let package = Package(
        name: "Apollo",
        targets: targets,
        dependencies: [
                .Package(url: "https://github.com/ReactiveX/RxSwift.git", Version(3, 0, 0, prereleaseIdentifiers: ["rc"])),
                .Package(url: "https://github.com/IBM-Swift/BlueSocket.git", Version(0, 12, 3)),
                //        .Package(url: "https://github.com/apple/swift-protobuf.git", Version(0,9,24))
                //        .Package(url:"https://github.com/joedaniels29/Ruby.git", majorVersion: 0),
                //        .Package(url: "https://github.com/Alamofire/Alamofire", Version(4, 0, 1))
        ]
        )
