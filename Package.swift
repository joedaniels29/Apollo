import PackageDescription


var targets = [Target]()

#if os(Linux)
targets.append(Target(name: "Apollo"))
#else
targets.append(Target(name: "ApolloSupport"))
targets.append(Target(name: "Apollo", dependencies: ["ApolloSupport"]))
#endif

#if os(macOS) || os(Linux)
targets.append(Target(name: "ApolloServer", dependencies: ["Apollo"]))
#endif


let package = Package(
        name: "Apollo",
        targets: targets,
        dependencies: [
                .Package(url: "https://github.com/ReactiveX/RxSwift.git", majorVersion: 3),
                .Package(url: "https://github.com/IBM-Swift/BlueSocket.git", Version(0, 12, 3)),
                .Package(url: "https://github.com/apple/swift-protobuf.git", Version(0, 9, 24)),
                .Package(url: "https://github.com/SwiftyBeaver/SwiftyBeaver.git", majorVersion: 1)
                //        .Package(url:"https://github.com/joedaniels29/Ruby.git", majorVersion: 0),
                //        .Package(url: "https://github.com/Alamofire/Alamofire", Version(4, 0, 1))
        ]
)
#if os(Linux)

// Avoid computing the objc target on linux.
package.exclude = [
        "Sources/ApolloSupport",
        "Tests/ApolloSupport"
]
#endif
