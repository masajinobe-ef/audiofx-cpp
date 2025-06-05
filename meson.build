project('cpp-first-app', 'cpp',
  version: '1.0',
  default_options: [
    'cpp_std=c++17',
    'warning_level=3',
    'werror=false',
    'b_ndebug=if-release',
  ])

compiler = meson.get_compiler('cpp')
compiler_id = compiler.get_id()
if compiler_id != 'clang'
  warning('Используется компилятор: ' + compiler_id)
  message('Рекомендуется использовать Clang для сборки')
endif

sources = files(
  'src/main.cpp',
)

cflags = []

build_type = get_option('buildtype')
if build_type == 'debug'
  cflags += ['-g', '-O0']
  message('Сборка в DEBUG режиме')
elif build_type == 'release'
  cflags += ['-O3', '-DNDEBUG']
  message('Сборка в RELEASE режиме')
endif

cflags += [
  '-Wall',
  '-Wextra',
  '-Wpedantic'
]

executable(meson.project_name(),
  sources,
  install: false,
  cpp_args: cflags,
  dependencies: [
    #
    ]
)
