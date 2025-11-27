// swift-tools-version: 5.7

import PackageDescription

let package = Package(
  name: "VPNSTrafficManager",
  platforms: [.iOS(.v15), .macOS(.v13)],
  products: [
    .library(name: "VPNSTrafficManager", targets: ["VPNSTrafficManager"]),
    .library(name: "VPNSTrafficManagerCode", targets: ["VPNSTrafficManagerCode"])
  ],
  targets: [
    .target(
      name: "VPNSTrafficManager",
      dependencies: ["HevSocks5Tunnel", "VPNSTrafficManagerCode"]
    ),
    .target(
      name: "VPNSTrafficManagerCode",
      publicHeadersPath: "."
    ),
    .binaryTarget(
      name: "HevSocks5Tunnel",
      url: "https://github.com/tozik/Tun2Socks/releases/download/4.141/VPNSTrafficManager.xcframework.zip",
      checksum: "8dea3367d818560be507f66e9fff9f069f582646a4ef94374be1dc681aa7da8a"
    )
  ]
)
