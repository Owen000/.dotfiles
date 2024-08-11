local function nolazy(plugin)
	plugin.lazy = false
	plugin.priority = 100
	return plugin
end

return {
	nolazy({ "folke/lazy.nvim", version = "*" }),
}

