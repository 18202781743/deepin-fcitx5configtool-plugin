cmake_minimum_required(VERSION 3.16 FATAL_ERROR)

set(CMAKE_DISABLE_IN_SOURCE_BUILD ON)
set(CMAKE_DISABLE_SOURCE_CHANGES ON)

if ("${CMAKE_BINARY_DIR}" STREQUAL "${CMAKE_SOURCE_DIR}")
  message(FATAL_ERROR "In-source builds are disabled.
    Please create a subfolder and use `cmake ..` inside it.
    NOTE: cmake will now create CMakeCache.txt and CMakeFiles/*.
          You must delete them, or cmake will refuse to work.")
endif()

project(fcitx5-configtool VERSION 5.1.2)

find_package(ECM 1.0.0 REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR})
include(FeatureSummary)
include(ECMSetupVersion)
include(GenerateExportHeader)
option(ENABLE_CONFIG_QT "Enable fcitx5-config-qt" On)
option(ENABLE_TEST "Enable test" Off)
add_definitions(-DTRANSLATION_DOMAIN=\"org.fcitx.fcitx5.kcm\")
add_definitions(-DFCITX_GETTEXT_DOMAIN=\"fcitx5-configtool\")
add_definitions(-DQT_NO_KEYWORDS)

# Find Qt version
find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core)
message("   >>> Found Qt version: ${QT_VERSION_MAJOR}")
set(QT_DESIRED_VERSION ${QT_VERSION_MAJOR})

if (QT_VERSION_MAJOR MATCHES 6)
    set(DTK_VERSION_MAJOR 6)
    set(KF_VERSION_MAJOR 6)
else()
    set(DTK_VERSION_MAJOR "")
    set(KF_VERSION_MAJOR 5)
endif()
message("   >>> Build with DTK: ${DTK_VERSION_MAJOR}")

find_package(Fcitx5Core 5.0.4 REQUIRED)
find_package(Fcitx5Config REQUIRED)
find_package(Fcitx5Utils REQUIRED)

find_package(IsoCodes REQUIRED)

include("${FCITX_INSTALL_CMAKECONFIG_DIR}/Fcitx5Utils/Fcitx5CompilerSettings.cmake")

find_package(PkgConfig REQUIRED)
find_package(Gettext REQUIRED)
find_package(X11 REQUIRED)
find_package(XKeyboardConfig REQUIRED)
pkg_check_modules(XkbFile "xkbfile" REQUIRED IMPORTED_TARGET)

set(DEFAULT_XKB_RULES "evdev" CACHE STRING "Xkb rules name")

if (QT_DESIRED_VERSION MATCHES 6)
  add_subdirectory(src)
else()
  add_subdirectory(src-old)
endif()

feature_summary(WHAT ALL INCLUDE_QUIET_PACKAGES FATAL_ON_MISSING_REQUIRED_PACKAGES)
