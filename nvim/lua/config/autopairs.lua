local status, autopairs = pcall(require, "nvim-autopairs")
if not status then
    return
end

autopairs.setup({
    check_ts = true,
    ts_config = {}
})

local cmp_autopairs_setup, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
if not cmp_autopairs_setup then
    return
end

local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
    return
end

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
