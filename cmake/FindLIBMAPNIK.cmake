# - Find LIBMAPNIK
# Find the LIBMAPNIK includes and libraries.
# This module defines:
#  LIBMAPNIK_FOUND
#  LIBMAPNIK_INCLUDE_DIRS
#  LIBMAPNIK_LIBRARIES

find_package(PkgConfig QUIET)
pkg_check_modules(LIBMAPNIK QUIET libmapnik)

find_path(LIBMAPNIK_INCLUDE_DIR
  NAMES version.hpp
  PATHS ${LIBMAPNIK_INCLUDE_DIRS}
  PATH_SUFFIXES mapnik
)

if((NOT LIBMAPNIK_INCLUDE_DIRS) AND (LIBMAPNIK_INCLUDE_DIR))
  set(LIBMAPNIK_INCLUDE_DIRS ${LIBMAPNIK_INCLUDE_DIR})
elseif(LIBMAPNIK_INCLUDE_DIRS AND LIBMAPNIK_INCLUDE_DIR)
  list(APPEND LIBMAPNIK_INCLUDE_DIRS ${LIBMAPNIK_INCLUDE_DIR})
endif()

find_library(LIBMAPNIK_LIBRARY
  NAMES ${LIBMAPNIK_LIBRARIES} mapnik
)

if((NOT LIBMAPNIK_LIBRARIES) AND (LIBMAPNIK_LIBRARY))
  set(LIBMAPNIK_LIBRARIES ${LIBMAPNIK_LIBRARY})
elseif(LIBMAPNIK_LIBRARIES AND LIBMAPNIK_LIBRARY)
  list(APPEND LIBMAPNIK_LIBRARIES ${LIBMAPNIK_LIBRARY})
endif()

message(VERBOSE "LIBMAPNIK_INCLUDE_DIRS=${LIBMAPNIK_INCLUDE_DIRS}")
message(VERBOSE "LIBMAPNIK_INCLUDE_DIR=${LIBMAPNIK_INCLUDE_DIR}")
message(VERBOSE "LIBMAPNIK_LIBRARIES=${LIBMAPNIK_LIBRARIES}")
message(VERBOSE "LIBMAPNIK_LIBRARY=${LIBMAPNIK_LIBRARY}")

if((NOT LIBMAPNIK_FOUND) AND (LIBMAPNIK_INCLUDE_DIRS) AND (LIBMAPNIK_LIBRARIES))
  set(LIBMAPNIK_FOUND True)
endif()

if((NOT LIBMAPNIK_VERSION) AND (LIBMAPNIK_FOUND))
  file(STRINGS "${LIBMAPNIK_INCLUDE_DIR}/version.hpp" _contents REGEX "#define MAPNIK_[A-Z]+_VERSION[ \t]+")
  if(_contents)
    string(REGEX REPLACE ".*#define MAPNIK_MAJOR_VERSION[ \t]+([0-9]+).*" "\\1" LIBMAPNIK_MAJOR_VERSION "${_contents}")
    string(REGEX REPLACE ".*#define MAPNIK_MINOR_VERSION[ \t]+([0-9]+).*" "\\1" LIBMAPNIK_MINOR_VERSION "${_contents}")
    string(REGEX REPLACE ".*#define MAPNIK_PATCH_VERSION[ \t]+([0-9]+).*" "\\1" LIBMAPNIK_PATCH_VERSION "${_contents}")

    set(LIBMAPNIK_VERSION ${LIBMAPNIK_MAJOR_VERSION}.${LIBMAPNIK_MINOR_VERSION}.${LIBMAPNIK_PATCH_VERSION})
  endif()
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LIBMAPNIK
  FOUND_VAR LIBMAPNIK_FOUND
  REQUIRED_VARS LIBMAPNIK_FOUND LIBMAPNIK_INCLUDE_DIRS LIBMAPNIK_LIBRARIES
  VERSION_VAR LIBMAPNIK_VERSION
)

mark_as_advanced(LIBMAPNIK_INCLUDE_DIR LIBMAPNIK_LIBRARY)