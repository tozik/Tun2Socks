// swift-tools-version: 5.7

import PackageDescription

let package = Package(
  name: "NetworkTunnelProcessor",
  platforms: [.iOS(.v15), .macOS(.v13)],
  products: [
    .library(name: "NetworkTunnelProcessor", targets: ["NetworkTunnelProcessor"]),
    .library(name: "NetworkTunnelProcessorCode", targets: ["NetworkTunnelProcessorCode"])
  ],
  targets: [
    .target(
      name: "NetworkTunnelProcessor",
      dependencies: ["HevSocks5Tunnel", "NetworkTunnelProcessorCode"]
    ),
    .target(
      name: "NetworkTunnelProcessorCode",
      publicHeadersPath: "."
    ),
    .binaryTarget(
      name: "HevSocks5Tunnel",
      url: "https://github.com/tozik/Tun2Socks/releases/download/4.7.33/NetworkTunnelProcessor.xcframework.zip",
      checksum: "b91ccf55f896e035ebd8e9442381ef3b2d9fe966013d0a2a3d78ec248ea91977"
    )
  ]
)
