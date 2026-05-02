vim.opt_local.suffixesadd:prepend(".md")

vim.keymap.set("n", "gf", function()
    local line = vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2] + 1
    for text_start, _, target, paren_end in
        line:gmatch("()%[[^%]]+()%]%(([^%)]+)()%)")
    do
        if col >= text_start and col < paren_end then
            if target:match("^https?://") then
                vim.ui.open(target)
            else
                vim.cmd("edit " .. vim.fn.fnameescape(target))
            end
            return
        end
    end
    vim.cmd("normal! gf")
end, { buffer = true, desc = "Follow markdown link" })
