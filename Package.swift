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
      url: "https://github.com/tozik/Tun2Socks/releases/download/4.7.32/NetworkTunnelProcessor.xcframework.zip",
      checksum: "bb5f546f6f6f510f2ae746dda398918da6c0f3c32bb823c4bd9db04a07e3c457"
    )
  ]
)
