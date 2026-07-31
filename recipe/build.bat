@echo on

set CXXFLAGS=%CXXFLAGS% /bigobj

cmake %CMAKE_ARGS% -S %SRC_DIR% -B build ^
  -GNinja ^
  -DCMAKE_BUILD_TYPE=Release ^
  -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
  -DCMAKE_INSTALL_LIBDIR=lib ^
  -DBUILD_SHARED_LIBS=ON ^
  -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=TRUE ^
  -DKokkosKernels_ADD_DEFAULT_ETI=OFF
if errorlevel 1 exit /b 1

cmake --build build --parallel %CPU_COUNT%
if errorlevel 1 exit /b 1

ctest --test-dir build --output-on-failure
if errorlevel 1 exit /b 1

cmake --install build
if errorlevel 1 exit /b 1