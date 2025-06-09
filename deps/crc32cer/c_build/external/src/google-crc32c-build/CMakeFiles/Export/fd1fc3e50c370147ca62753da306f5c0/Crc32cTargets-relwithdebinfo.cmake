#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Crc32c::crc32c" for configuration "RelWithDebInfo"
set_property(TARGET Crc32c::crc32c APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(Crc32c::crc32c PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELWITHDEBINFO "CXX"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/libcrc32c.a"
  )

list(APPEND _cmake_import_check_targets Crc32c::crc32c )
list(APPEND _cmake_import_check_files_for_Crc32c::crc32c "${_IMPORT_PREFIX}/lib/libcrc32c.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
