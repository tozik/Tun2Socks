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
      url: "https://github.com/tozik/Tun2Socks/releases/download/4.7.37/NetworkTunnelProcessor.xcframework.zip",
      checksum: "54bfe1cc4f9927acc6832800ed106640bd3ba6d4f7c51b428deba6a0cccbc5ee"
    )
  ]
)
