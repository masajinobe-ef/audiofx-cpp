# C++ First App Build Instructions

## Установка прав на выполнение скрипта
sudo chmod +x bld

## 🏗️ Инициализация проекта

- **Debug-сборка:**
  ./bld setup

- **Release-сборка:**
  ./bld setup --release

## 🔧 Сборка проекта
./bld build

## ▶️ Сборка и запуск
./bld run

## ⚙️ Изменение конфигурации
./bld config --buildtype=release -Dcpp_std=c++23

## 🧹 Очистка объектных файлов
./bld clean

## 💥 Полное удаление сборки
./bld purge

## 📦 Установка программы
./bld install

## ℹ️ Показать справку
./bld help

