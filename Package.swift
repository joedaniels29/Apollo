import PackageDescription

let package = Package(
    name: "Apollo",
    dependencies: [
        .Package(url: "https://github.com/ReactiveX/RxSwift.git", Version(3, 0, 0, prereleaseIdentifiers: ["rc"]))
    ]
)
