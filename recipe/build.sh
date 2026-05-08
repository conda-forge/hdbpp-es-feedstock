cmake ${CMAKE_ARGS} \
      -G Ninja \
      -DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
      -DCMAKE_BUILD_TYPE=RelWithDebInfo \
      -DLIBHDBPP_BACKEND=libhdbpp \
      -S . -B build

cmake --build build -v
cmake --install build

# Separate debugging symbols on Linux
if [ -n "${OBJCOPY}" ]
then
  mkdir -p ${PREFIX}/lib/debug
  ${OBJCOPY} --only-keep-debug ${PREFIX}/bin/hdb++es-srv ${PREFIX}/lib/debug/hdb++es-srv.dbg
  chmod 664 ${PREFIX}/lib/debug/hdb++es-srv.dbg
  ${OBJCOPY} --strip-debug ${PREFIX}/bin/hdb++es-srv
  ${OBJCOPY} --add-gnu-debuglink=${PREFIX}/lib/debug/hdb++es-srv.dbg ${PREFIX}/bin/hdb++es-srv
fi
