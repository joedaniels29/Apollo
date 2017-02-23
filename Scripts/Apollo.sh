if [[ $BUILDTYPE == "xcrun" ]]; then
    LC_CTYPE=en_US.UTF-8
    LANG=en_US.UTF-8
    WORKSPACE=Alamofire.xcworkspace
    IOS_FRAMEWORK_SCHEME="Alamofire iOS"
    MACOS_FRAMEWORK_SCHEME="Alamofire macOS"
    TVOS_FRAMEWORK_SCHEME="Alamofire tvOS"
    WATCHOS_FRAMEWORK_SCHEME="Alamofire watchOS"
    IOS_SDK=iphonesimulator10.0
    MACOS_SDK=macosx10.12
    TVOS_SDK=appletvsimulator10.0
    WATCHOS_SDK=watchsimulator3.0
    EXAMPLE_SCHEME="iOS Example"


    gem install carthage
    carthage update -no-use-binaries
    set -o pipefail
    xcodebuild -version
    xcodebuild -showsdks

    xcodebuild -scheme "Apollo"  | xcpretty
    xcodebuild -scheme "ApolloIOS" | xcpretty
    xcodebuild -scheme "ApolloM" | xcpretty
    xcodebuild -scheme "ApolloX" | xcpretty
    xcodebuild -scheme "ApolloService" | xcpretty
    xcodebuild -scheme "ApolloPickaxe" | xcpretty
    xcodebuild -scheme "ApolloMonitor" | xcpretty
    xcodebuild -scheme "ApolloMicro" | xcpretty

elif [[ $BUILDTYPE == "swiftbuild" ]]; then
    eval "$(curl -sL https://gist.githubusercontent.com/kylef/5c0475ff02b7c7671d2a/raw/9f442512a46d7a2af7b850d65a7e9bd31edfb09b/swiftenv-install.sh)"
    swift build
    swift test
fi
