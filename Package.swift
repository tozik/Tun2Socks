// swift-tools-version: 5.7

import PackageDescription

let package = Package(
  name: "Tun2SocksKit",
  platforms: [.iOS(.v15), .macOS(.v15)],
  products: [
    .library(name: "Tun2SocksKit", targets: ["Tun2SocksKit"]),
    .library(name: "Tun2SocksKitC", targets: ["Tun2SocksKitC"])
  ],
  targets: [
    .target(
      name: "Tun2SocksKit",
      dependencies: ["HevSocks5Tunnel", "Tun2SocksKitC"])
    ),
    .target(
      name: "Tun2SocksKitC",
      dependencies: "."
    ),
    .binaryTarget(
      name: "LibXray",
      url: "https://github.com/tozik/Tun2SocksKit/releases/download/4.7.15/LibXray.xcframework.zip",
      checksum: ""
    )
  ]
)
