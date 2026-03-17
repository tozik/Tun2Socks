#!/usr/bin/env bash
# build-local.sh — локальная сборка, воспроизводящая шаги CI из release-obfs.yml
# Использование: ./build-local.sh [VERSION] [HST_TAG]
#   VERSION  — строка версии релиза, напр. 4.142  (по умолчанию: 0.0.0-local)
#   HST_TAG  — тег hev-socks5-tunnel (по умолчанию: latest)

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
VERSION="${1:-0.0.0-local}"
HST_TAG="${2:-latest}"

BUILD_DIR="$REPO_ROOT/.build-xcframework"

echo "=== Build dir: $BUILD_DIR"
echo "=== Version:   $VERSION"

# ─── Получить актуальный тег упстрим-библиотеки ────────────────────────────
if [ "$HST_TAG" = "latest" ]; then
  HST_TAG=$(curl -s https://api.github.com/repos/heiher/hev-socks5-tunnel/releases/latest \
            | python3 -c "import sys,json; print(json.load(sys.stdin)['tag_name'])")
  echo "=== Latest hev-socks5-tunnel tag: $HST_TAG"
fi

# ─── Подготовка рабочей директории ─────────────────────────────────────────
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

# ─── Клонирование исходников ────────────────────────────────────────────────
echo ""
echo "=== [1/6] Cloning hev-socks5-tunnel @ $HST_TAG ..."
git clone --recurse-submodules --depth 1 \
    --branch "$HST_TAG" \
    https://github.com/heiher/hev-socks5-tunnel.git temp

echo ""
echo "=== [2/6] Cloning simulator-patched fork ..."
git clone --depth 1 \
    https://github.com/tozik/hev-socks5-tunnel-iphonesimulator-new.git fake

# ─── macOS arm64 + x86_64 ───────────────────────────────────────────────────
echo ""
echo "=== [3/6] Building macOS (arm64 + x86_64) ..."
mkdir -p macos_arm64_x86_64/macos_arm64 macos_arm64_x86_64/macos_x86_64

cd "$BUILD_DIR/temp"
make clean
make PP=g++ CC=gcc \
     CFLAGS="-arch x86_64 -mmacosx-version-min=12.0" \
     LFLAGS="-arch x86_64 -mmacosx-version-min=12.0" \
     static
libtool -static \
        -o "$BUILD_DIR/macos_arm64_x86_64/macos_x86_64/libhev-socks5-tunnel.a" \
        bin/libhev-socks5-tunnel.a \
        third-part/lwip/bin/liblwip.a \
        third-part/yaml/bin/libyaml.a \
        third-part/hev-task-system/bin/libhev-task-system.a

make clean
make PP=g++ CC=gcc \
     CFLAGS="-arch arm64 -mmacosx-version-min=12.0" \
     LFLAGS="-arch arm64 -mmacosx-version-min=12.0" \
     static
libtool -static \
        -o "$BUILD_DIR/macos_arm64_x86_64/macos_arm64/libhev-socks5-tunnel.a" \
        bin/libhev-socks5-tunnel.a \
        third-part/lwip/bin/liblwip.a \
        third-part/yaml/bin/libyaml.a \
        third-part/hev-task-system/bin/libhev-task-system.a

lipo -create \
     -o "$BUILD_DIR/macos_arm64_x86_64/libhev-socks5-tunnel.a" \
     "$BUILD_DIR/macos_arm64_x86_64/macos_arm64/libhev-socks5-tunnel.a" \
     "$BUILD_DIR/macos_arm64_x86_64/macos_x86_64/libhev-socks5-tunnel.a"

# ─── iOS device arm64 ───────────────────────────────────────────────────────
echo ""
echo "=== [4/6] Building iphoneos (arm64) ..."
mkdir -p "$BUILD_DIR/iphoneos_arm64"

cd "$BUILD_DIR/temp"
make clean
make PP="xcrun --sdk iphoneos --toolchain iphoneos clang" \
     CC="xcrun --sdk iphoneos --toolchain iphoneos clang" \
     CFLAGS="-arch arm64 -mios-version-min=12.0" \
     LFLAGS="-arch arm64 -mios-version-min=12.0" \
     static
libtool -static \
        -o "$BUILD_DIR/iphoneos_arm64/libhev-socks5-tunnel.a" \
        bin/libhev-socks5-tunnel.a \
        third-part/lwip/bin/liblwip.a \
        third-part/yaml/bin/libyaml.a \
        third-part/hev-task-system/bin/libhev-task-system.a
make clean

# ─── iOS Simulator arm64 + x86_64 ───────────────────────────────────────────
echo ""
echo "=== [5/6] Building iphonesimulator (arm64 + x86_64) ..."
mkdir -p "$BUILD_DIR/iphonesimulator_arm64_x86_64/iphonesimulator_arm64"
mkdir -p "$BUILD_DIR/iphonesimulator_arm64_x86_64/iphonesimulator_x86_64"

cd "$BUILD_DIR/fake"
make clean
make PP="xcrun -sdk iphonesimulator clang" \
     CC="xcrun -sdk iphonesimulator clang" \
     CFLAGS="-arch arm64 -mios-simulator-version-min=12.0" \
     LFLAGS="-arch arm64 -mios-simulator-version-min=12.0" \
     static
cp bin/libhev-socks5-tunnel.a \
   "$BUILD_DIR/iphonesimulator_arm64_x86_64/iphonesimulator_arm64/libhev-socks5-tunnel.a"

make clean
make PP="xcrun -sdk iphonesimulator clang" \
     CC="xcrun -sdk iphonesimulator clang" \
     CFLAGS="-arch x86_64 -mios-simulator-version-min=12.0" \
     LFLAGS="-arch x86_64 -mios-simulator-version-min=12.0" \
     static
cp bin/libhev-socks5-tunnel.a \
   "$BUILD_DIR/iphonesimulator_arm64_x86_64/iphonesimulator_x86_64/libhev-socks5-tunnel.a"

make clean
lipo -create \
     -o "$BUILD_DIR/iphonesimulator_arm64_x86_64/libhev-socks5-tunnel.a" \
     "$BUILD_DIR/iphonesimulator_arm64_x86_64/iphonesimulator_arm64/libhev-socks5-tunnel.a" \
     "$BUILD_DIR/iphonesimulator_arm64_x86_64/iphonesimulator_x86_64/libhev-socks5-tunnel.a"

# ─── XCFramework ────────────────────────────────────────────────────────────
echo ""
echo "=== [6/6] Building XCFramework ..."
mkdir -p "$BUILD_DIR/include"
cp "$BUILD_DIR/temp/src/hev-main.h" "$BUILD_DIR/include/vpns-traffic-manager.h"
cp "$REPO_ROOT/Templates/VPNSTrafficManager.template" "$BUILD_DIR/include/module.modulemap"

cd "$BUILD_DIR"
xcodebuild -create-xcframework \
           -library ./iphoneos_arm64/libhev-socks5-tunnel.a \
           -headers ./include \
           -library ./iphonesimulator_arm64_x86_64/libhev-socks5-tunnel.a \
           -headers ./include \
           -library ./macos_arm64_x86_64/libhev-socks5-tunnel.a \
           -headers ./include \
           -output ./VPNSTrafficManager.xcframework

zip -r "$BUILD_DIR/VPNSTrafficManager.xcframework.zip" VPNSTrafficManager.xcframework

CHECKSUM=$(shasum -a 256 "$BUILD_DIR/VPNSTrafficManager.xcframework.zip" | awk '{print $1}')

echo ""
echo "=================================================="
echo "  BUILD SUCCESS"
echo "  Archive : $BUILD_DIR/VPNSTrafficManager.xcframework.zip"
echo "  Checksum: $CHECKSUM"
echo "  HST tag : $HST_TAG"
echo "=================================================="
echo ""
echo "Для обновления Package.swift запустите с нужной VERSION:"
echo "  ./build-local.sh <version> $HST_TAG"
