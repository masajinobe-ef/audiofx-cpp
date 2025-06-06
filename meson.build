project('cpp-first-app', 'cpp',
  version: '1.0',
  default_options: [
    'cpp_std=c++20',
    'warning_level=3',
    'werror=true',
    'buildtype=debug',
    'default_library=static',
    'b_ndebug=if-release',
    'b_lto=true'
  ])

compiler = meson.get_compiler('cpp')

src_files = ['src/main.cpp']

executable(
  meson.project_name(),
  src_files,
  install: true,
  cpp_args: ['-fcolor-diagnostics'],
)

message('\n⚙️  Конфигурация:')
message('----------------------')
message('Тип сборки:    ' + get_option('buildtype'))
message('Стандарт C++:  ' + get_option('cpp_std'))
message('Исходников:    ' + '1')
message('Директория:    ' + meson.current_build_dir())
message('----------------------\n')

if get_option('buildtype') == 'debug'
  message('💡 Совет: Для release-сборки используйте: meson configure ' + meson.current_build_dir() + ' --buildtype=release')
endif
