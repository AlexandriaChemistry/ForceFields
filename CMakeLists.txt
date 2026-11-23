# Installs the force field files in share/act/forcefields of the prefix, in
# the same directory tree as here, as the conda package forcefields does
# (conda/recipe.yaml). That is the data directory of ACT and ACT-utilities,
# so use the prefix of those:
#
#   cmake -S . -B build -DCMAKE_INSTALL_PREFIX=<prefix of ACT>
#   cmake --install build
#
# Nothing is built.

cmake_minimum_required(VERSION 3.16)
project(ForceFields NONE)

set(FORCEFIELDS_INSTALL_DIR "share/act/forcefields" CACHE STRING
    "Directory below the prefix for the force field files")

# Each directory with force field files, which are found again when one is added
file(GLOB _forcefield_dirs LIST_DIRECTORIES true CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/*")
foreach(_dir IN LISTS _forcefield_dirs)
    get_filename_component(_name "${_dir}" NAME)
    if(IS_DIRECTORY "${_dir}" AND NOT _name MATCHES "^(\\.|build|conda$)")
        install(DIRECTORY "${_dir}" DESTINATION "${FORCEFIELDS_INSTALL_DIR}"
                FILES_MATCHING PATTERN "*.xml")
    endif()
endforeach()
install(FILES LICENSE README.md DESTINATION "${FORCEFIELDS_INSTALL_DIR}")
