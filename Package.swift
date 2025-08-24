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
      dependencies: ["NetworkTunnelProcessorBinary", "NetworkTunnelProcessorCode"]
    ),
    .target(
      name: "NetworkTunnelProcessorCode",
      publicHeadersPath: "."
    ),
    .binaryTarget(
      name: "NetworkTunnelProcessorBinary",
      url: "https://github.com/tozik/Tun2Socks/releases/download/4.7.35/NetworkTunnelProcessor.xcframework.zip",
      checksum: "7135f7375dd8df5258740baac417dba2d47c1d12b1c305783536655d02133d38"
    )
  ]
)
