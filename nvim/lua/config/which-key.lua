local status, whichkey = pcall(require, "which-key")
if not status then
    return
end

whichkey.setup()

vim.o.timeout = true
vim.o.timeoutlen = 300
