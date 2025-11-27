# Изменения для переименования библиотеки в NetworkTunnelProcessor

## Внесенные изменения:

### 1. GitHub Actions Workflow (`.github/workflows/release.yml`)
- ✅ Изменил путь заголовочного файла: `hev-socks5-tunnel.h` → `network-tunnel-processor.h`
- ✅ Изменил путь к template файлу: `HevSocks5Tunnel.template` → `NetworkTunnelProcessor.template`
- ✅ Изменил название XCFramework: `HevSocks5Tunnel.xcframework` → `NetworkTunnelProcessor.xcframework`
- ✅ Изменил название ZIP архива: `HevSocks5Tunnel.xcframework.zip` → `NetworkTunnelProcessor.xcframework.zip`
- ✅ Обновил все ссылки в Package.swift генерации
- ✅ Обновил скрипты для работы с новым именем библиотеки

### 2. Package.swift
- ✅ Изменил название бинарной цели: `HevSocks5Tunnel` → `NetworkTunnelProcessor`
- ✅ Обновил зависимости в target `Tun2SocksKit`
- ✅ Изменил URL для загрузки с `-tozik` репозитория на основной репозиторий

### 3. Template файл
- ✅ Создал новый файл `Templates/NetworkTunnelProcessor.template`
- ✅ Изменил module name: `HevSocks5Tunnel` → `NetworkTunnelProcessor`
- ✅ Изменил umbrella header: `hev-socks5-tunnel.h` → `network-tunnel-processor.h`

### 4. Swift код (`Sources/Tun2SocksKit/Tunnel.swift`)
- ✅ Изменил импорт: `import HevSocks5Tunnel` → `import NetworkTunnelProcessor`
- ❗ Пока будет ошибка компиляции до создания новой библиотеки

## Результат:
После запуска workflow с новой версией будет создана библиотека `NetworkTunnelProcessor.xcframework.zip` вместо `HevSocks5Tunnel.xcframework.zip`. Все функции и API остаются теми же, меняется только название модуля для импорта.

## Примечание:
Ошибка компиляции `No such module 'NetworkTunnelProcessor'` исчезнет после первого успешного запуска workflow и создания новой версии библиотеки.
