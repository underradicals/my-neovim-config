require("lazy").setup({
	{ import = "plugins.spec" },
}, {
	checker = { enabled = true },
	change_detection = { notify = false },
})
