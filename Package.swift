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
      url: "https://github.com/tozik/Tun2Socks/releases/download/4.7.25/NetworkTunnelProcessor.xcframework.zip",
      checksum: "7656f9b2d79b36b6551a95526398e8bfc44e2800c8fcc5699e2dd66857e13258"
    )
  ]
)
