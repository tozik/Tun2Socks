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
      dependencies: ["HevSocks5Tunnel", "Tun2SocksKitC"]
    ),
    .target(
      name: "Tun2SocksKitC",
      publicHeadersPath: "."
    ),
    .binaryTarget(
      name: "HevSocks5Tunnel",
      url: "https://github.com/tozik/Tun2Socks-tozik/releases/download/4.7.20/HevSocks5Tunnel.xcframework.zip",
      checksum: "1bf98c2908802912e1b057c10ff4e97664a621d34b219d62150767a446858482"
    )
  ]
)
