# DarkWiiPlayer/rgbstr

A lua library that takes a string and returns a pseudo-random colour as RGB
values. This is primarily intended for things like tags on websites and such.

## Usage

```lua
rgbstr = require 'rgbstr'

local red, green, blue = rgbstr.floats("Hello, World!")

local red, green, blue = rgbstr.bytes("#TagName", 12, 1, .8)
```

The `floats` and `bytes` functions take the same arguments:

* The input string
* A number of colour steps to clamp the result to
* Saturation from 0 to 1
* Lightness from 0 to 1

One returns values from 0 to 1 while the other returns (whole) bytes from 0 to 255
