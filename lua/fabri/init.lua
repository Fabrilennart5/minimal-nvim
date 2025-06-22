-- My personal nvim config
-- loads core components inthis order:
-- 1.- Key mapping (remap.lua)
-- 2.- PLugin manager (lazy.lua)
-- 3.- Edito settings (set.lua)
require("fabri.remap")
require("fabri.lazy")
require("fabri.set")
