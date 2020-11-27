-- premake5.lua
	
workspace "RayTracing"
	configurations { "Debug", "Release" }
	platforms { "x64", "ARM64" }   
--	includedirs { ".", "engine" }
	defines { "_CRT_SECURE_NO_WARNINGS" }
	startproject "RayTracing"	
   
filter "action:vs*"
	system "windows"
	architecture "x86_64"  
	vectorextensions "SSE4.1"
	toolset "msc-clangcl"
    defines("WINDOWS")    
--	editandcontinue "Off"    
--	includedirs { "external/glfw-3.3/include", "external/glew-2.1.0/include", "external/fmod/api/core/inc", "external/stb" }

filter "action:xcode*"
    system "macosx"
    architecture "arm64"
    vectorextensions "NEON"
	toolset "clang"
    defines { "MACOS" }    
	buildoptions { "-Xclang -flto-visibility-public-std -fblocks" }

--filter "platforms:x64"
--	system "windows"
--	architecture "x86_64"  
--	vectorextensions "SSE4.1"
--	toolset "clang"
--    defines("RE_PLATFORM_WIN64")    
--	includedirs { "..", "../external/glfw-3.3/include", "../external/glew-2.1.0/include", "../external/fmod/api/core/inc", "../external/stb" }

filter "configurations:Debug"
	defines { "_DEBUG" }

filter "configurations:Release"
	defines { "NDEBUG" }

project "RayTracing"
	location "RayTracing"
	kind "ConsoleApp"
	language "C++"
	targetdir "bin/%{cfg.buildcfg}"   	
	debugdir "."
	
	files 
	{ 
		"RayTracing/**.h", 
		"RayTracing/**.cpp",
	}

	filter "action:xcode*"
		excludes
		{	
			"RayTracing/stdafx.cpp",
			"RayTracing/targetver.h"
		}

	filter "configurations:Debug"
		defines { "_DEBUG" }
		optimize "Off"
		symbols  "Full"      
--		libdirs { "lib/Debug" }

	filter "configurations:Release"
		defines { "NDEBUG" }
		optimize "Full"
--		libdirs { "lib/Release" }
