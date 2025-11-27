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
      url: "https://github.com/tozik/Tun2Socks/releases/download/4.7.33/VPNSTrafficManager.xcframework.zip",
      checksum: "b91ccf55f896e035ebd8e9442381ef3b2d9fe966013d0a2a3d78ec248ea91977"
    )
  ]
)
