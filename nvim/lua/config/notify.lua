local notify_status, notify = pcall(require, "notify")
if not notify_status then
    return
end

notify.setup({
    stages = "slide",
    background_color = "FloatShadow"
})

vim.notify = notify
