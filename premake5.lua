include "../../premake/common_premake_defines.lua"

project "icu"
	kind "StaticLib"
	language "C++"
	-- TODO: fix when compilation errors fixed
	-- cppdialect "C++latest"
	cdialect "C17"
	targetname "%{prj.name}"
	inlining "Auto"

	files {
		"./icu4c/source/stubdata/**.h",
		"./icu4c/source/stubdata/**.c",
		"./icu4c/source/stubdata/**.cpp",
	}

	files {
		"./icu4c/source/IO/**.h",
		"./icu4c/source/IO/**.c",
		"./icu4c/source/IO/**.cpp",

		defines {
			"U_IO_IMPLEMENTATION"
		}
	}

	files {
		"./icu4c/source/i18n/**.h",
		"./icu4c/source/i18n/**.c",
		"./icu4c/source/i18n/**.cpp",

		defines {
			"U_I18N_IMPLEMENTATION"
		}
	}

	files {
		"./icu4c/source/common/**.h",
		"./icu4c/source/common/**.c",
		"./icu4c/source/common/**.cpp",

		defines {
			"U_COMMON_IMPLEMENTATION"
		}
	}
	
	includedirs {
		"%{IncludeDir.icu}"
	}

	filter "toolset:msc"
		buildoptions { "/utf-8" }
		disablewarnings { "4244", "4996", "4101" }

	filter "system:windows"
		defines { "_CRT_SECURE_NO_WARNINGS" }