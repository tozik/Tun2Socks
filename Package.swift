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
      url: "https://github.com/tozik/Tun2Socks/releases/download/4.7.33/NetworkTunnelProcessor.xcframework.zip",
      checksum: "b91ccf55f896e035ebd8e9442381ef3b2d9fe966013d0a2a3d78ec248ea91977"
    )
  ]
)
