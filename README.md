mkdir -p build && cd build

cmake .. \
  -G Ninja \
  -DCMAKE_C_COMPILER=clang \
  -DCMAKE_CXX_COMPILER=clang++ \
  -DCMAKE_BUILD_TYPE=RelWithDebInfo \
  -DCMAKE_EXE_LINKER_FLAGS="-fuse-ld=lld" \
  -DCMAKE_INTERPROCEDURAL_OPTIMIZATION=ON # LTO

ninja -j$(nproc)

./audiofx-cpp
