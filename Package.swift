// swift-tools-version: 5.7

import PackageDescription

let package = Package(
  name: "Tun2SocksKit",
  platforms: [.iOS(.v15), .macOS(.v13)],
  products: [
    .library(name: "Tun2SocksKit", targets: ["Tun2SocksKit"]),
    .library(name: "Tun2SocksKitC", targets: ["Tun2SocksKitC"])
  ],
  targets: [
    .target(
      name: "Tun2SocksKit",
      dependencies: ["NetworkTunnelProcessor", "Tun2SocksKitC"]
    ),
    .target(
      name: "Tun2SocksKitC",
      publicHeadersPath: "."
    ),
    .binaryTarget(
      name: "NetworkTunnelProcessor",
      url: "https://github.com/tozik/Tun2Socks/releases/download/4.7.24/NetworkTunnelProcessor.xcframework.zip",
      checksum: "3e1b2d3b0928fb3e493a9c05f57e91230ee12bcd37d56676481c0cc0668a7773"
    )
  ]
)
