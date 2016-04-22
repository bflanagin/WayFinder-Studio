include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}
)

set(
    WayFinderbackend_SRCS
    modules/WayFinder/backend.cpp
    modules/WayFinder/mytype.cpp
    modules/WayFinder/myio.cpp
)

# Make the unit test files visible on qtcreator
add_custom_target(WayFinderbackend_UNITTEST_QML_FILES ALL SOURCES "tests/unit/tst_mytype.qml")

add_library(WayFinderbackend MODULE
    ${WayFinderbackend_SRCS}
)

set_target_properties(WayFinderbackend PROPERTIES
         LIBRARY_OUTPUT_DIRECTORY WayFinder)

qt5_use_modules(WayFinderbackend Gui Qml Quick)

# Copy qmldir file to build dir for running in QtCreator
add_custom_target(WayFinderbackend-qmldir ALL
    COMMAND cp ${CMAKE_CURRENT_SOURCE_DIR}/modules/WayFinder/qmldir ${CMAKE_CURRENT_BINARY_DIR}/WayFinder
    DEPENDS ${QMLFILES}
)

# Install plugin file
install(TARGETS WayFinderbackend DESTINATION ${QT_IMPORTS_DIR}/WayFinder/)
install(FILES   modules/WayFinder/qmldir DESTINATION ${QT_IMPORTS_DIR}/WayFinder/)

