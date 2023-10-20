cmake ${CMAKE_ARGS} \
      -DCMAKE_BUILD_TYPE=RelWithDebInfo \
      -DLIBHDBPP_BACKEND=libhdbpp \
      -S . -B build

cmake --build build -v -j $CPU_COUNT
cmake --build build --target install


# Separate debugging symbols on Linux
if [ ! -z "${OBJCOPY}" ]
then
  ${OBJCOPY} --only-keep-debug ${PREFIX}/bin/hdb++es-srv ${PREFIX}/bin/hdb++es-srv.dbg
  chmod 664 ${PREFIX}/bin/hdb++es-srv.dbg
  ${OBJCOPY} --strip-debug ${PREFIX}/bin/hdb++es-srv
  ${OBJCOPY} --add-gnu-debuglink=${PREFIX}/bin/hdb++es-srv.dbg ${PREFIX}/bin/hdb++es-srv
fi
