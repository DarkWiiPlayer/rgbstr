package = "rgbstr"
version = "dev-1"
source = {
	url = "git+https://github.com/darkwiiplayer/rgbstr"
}
description = {
	homepage = "https://github.com/darkwiiplayer/rgbstr",
	license = "Unlicense"
}
build = {
	type = "builtin",
	modules = {
		rgbstr = "src/rgbstr.lua"
	}
}
