local status, themery = pcall(require, "themery")
if not status then
    return
end

themery.setup({
    themes = { "onedark", "gruvbox" },
    livePreview = true
})
