void main(MultiBuild::Workspace& workspace) {	
	auto project = workspace.create_project(".");
	auto properties = project.properties();

	project.name("icu");
	properties.binary_object_kind(MultiBuild::BinaryObjectKind::eStaticLib);
	project.license("./LICENSE");
	// TODO: remove when compilation errors fixed
	properties.cpp_dialect(MultiBuild::LangDialectCpp::e14);

	properties.tags("utf8");

	project.include_own_required_includes(true);
	project.add_required_project_include({
		"./icu4c/source/*"
	});

	properties.files({
		"./icu4c/source/stubdata/**.h",
		"./icu4c/source/stubdata/**.c",
		"./icu4c/source/stubdata/**.cpp",

		"./icu4c/source/IO/**.h",
		"./icu4c/source/IO/**.c",
		"./icu4c/source/IO/**.cpp",

		"./icu4c/source/i18n/**.h",
		"./icu4c/source/i18n/**.c",
		"./icu4c/source/i18n/**.cpp",

		"./icu4c/source/common/**.h",
		"./icu4c/source/common/**.c",
		"./icu4c/source/common/**.cpp"
	});

	properties.defines({
		"U_IO_IMPLEMENTATION",
		"U_I18N_IMPLEMENTATION",
		"U_COMMON_IMPLEMENTATION"
	});

	{
		MultiBuild::ScopedFilter _(project, "project.compiler:VisualCpp");
		properties.disable_warnings({ "4244", "4996", "4101" });
	}

	{
		MultiBuild::ScopedFilter _(project, "config.platform:Windows");
		properties.defines("_CRT_SECURE_NO_WARNINGS");
	}
}