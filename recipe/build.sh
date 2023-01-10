cmake ${CMAKE_ARGS} \
      -DCMAKE_BUILD_TYPE=RelWithDebInfo \
      -DLIBHDBPP_BACKEND=libhdbpp \
      -S . -B build

cmake --build build -v -j $CPU_COUNT
cmake --build build --target install
