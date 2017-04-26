import PackageDescription

let package = Package(
    name: "swiftlane",
    dependencies: [
	.Package(url: "https://github.com/antitypical/Result.git",
                 majorVersion: 3),
	.Package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", versions: Version(1,0,0)..<Version(3, .max, .max)),
	.Package(url: "https://github.com/vapor/sockets.git", majorVersion: 1),
	
        ]
)
