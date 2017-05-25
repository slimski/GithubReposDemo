// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "GithubReposDemo",
    dependencies: [
        .Package(url: "https://github.com/Alamofire/Alamofire.git", majorVersion: 4)
    ]
)
