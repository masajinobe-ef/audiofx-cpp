#!/usr/bin/env bash

PROJECT_NAME="myapp"
BUILD_DIR="build"
DEFAULT_COMPILER="clang++"
DEFAULT_BUILD_TYPE="debug"
DEFAULT_CXX_STANDARD="c++17"

BUILD_TYPE="$DEFAULT_BUILD_TYPE"
RUN_PROGRAM=false
CLEAN_BUILD=false

while [[ $# -gt 0 ]]; do
    case "$1" in
    --release)
        BUILD_TYPE="release"
        shift
        ;;
    --run)
        RUN_PROGRAM=true
        shift
        ;;
    clean)
        CLEAN_BUILD=true
        shift
        ;;
    *)
        echo "Неизвестный аргумент: $1"
        exit 1
        ;;
    esac
done

if [ "$CLEAN_BUILD" = true ]; then
    rm -rf "$BUILD_DIR"
    echo "✅ Директория сборки очищена"
    exit 0
fi

check_dependency() {
    if ! command -v "$1" &>/dev/null; then
        echo "❌ Ошибка: $1 не установлен!"
        exit 1
    fi
}

check_dependency meson
check_dependency ninja
check_dependency "$DEFAULT_COMPILER"

echo "🛠️  Конфигурация сборки:"
echo "----------------------"
echo "Тип сборки:   $BUILD_TYPE"
echo "Компилятор:   $DEFAULT_COMPILER"
echo "Стандарт C++: $DEFAULT_CXX_STANDARD"
echo "Директория:   $BUILD_DIR"
echo "----------------------"

if [ -d "$BUILD_DIR" ]; then
    echo "♻️  Удаляю старую директорию сборки..."
    rm -rf "$BUILD_DIR"
fi

meson setup "$BUILD_DIR" \
    --wipe \
    --buildtype="$BUILD_TYPE" \
    --default-library=static \
    -Dcpp_std="$DEFAULT_CXX_STANDARD" \
    -Dwarning_level=3 \
    -Dwerror=false \
    -Db_ndebug=if-release \
    -Dc_args="-Wall -Wextra" \
    -Dcpp_args="-Wall -Wextra" ||
    exit 1

echo "🔧 Компиляция проекта..."
cd "$BUILD_DIR" || exit 1
if ninja; then
    echo "✅ Сборка успешно завершена"
else
    echo "❌ Ошибка при сборке"
    exit 1
fi

if [ "$RUN_PROGRAM" = true ]; then
    echo "🚀 Запускаю программу:"
    echo "----------------------"
    ./"$PROJECT_NAME"
fi
