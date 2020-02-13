cmake_minimum_required(VERSION 3.6)

set(project_name app)
project(${project_name})

# GLFW
find_package(PkgConfig REQUIRED)
pkg_search_module(GLFW REQUIRED glfw3)

#GLU
#pkg_search_module(GLU REQUIRED glu)

set(cimgui lib/cimgui)
set(imgui_impl ${cimgui}/imgui/examples)
set(gl3w lib/gl3w)
set(linmath lib/linmath/)

# library search path
set(ENV{PKG_CONFIG_PATH} "$ENV{PKG_CONFIG_PATH}:/usr/local/lib/pkgconfig")
set(ENV{LD_LIBRARY_PATH} "ENV{LD_LIBRARY_PATH}:/usr/local/lib")

# build dir
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/bin)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=c11 -Wall -g")

set(CMAKE_VERBOSE_MAKEFILE ON)

# Include dirs
include_directories(
	src
	${cimgui} 
	${cimgui}/imgui ${imgui_impl}
    ${gl3w}
    ${klib}
    ${linmath})

# add_subdirectory(dep/cimgui)
file(GLOB 
	cimgui_files 
	"${cimgui}/*.cpp" 
	"${cimgui}/imgui/*.cpp"
	"${imgui_impl}/imgui_impl_glfw.cpp"
	"${imgui_impl}/imgui_impl_opengl3.cpp")
add_library(cimgui ${cimgui_files})
target_compile_definitions(cimgui PRIVATE 
	IMGUI_IMPL_API=extern\ \"C\"
	IMGUI_IMPL_OPENGL_LOADER_GL3W)

file(GLOB source_files "src/*.c")
file(GLOB gl3w_files "${gl3w}/GL/*.c")

add_executable(
	${project_name} 
	${source_files}
	${gl3w_files})
target_compile_definitions(${project_name} PRIVATE 
	IMGUI_IMPL_API=\ )

target_link_libraries(
	${project_name}
    ${GLFW_LIBRARIES}
	m GL dl cimgui)
