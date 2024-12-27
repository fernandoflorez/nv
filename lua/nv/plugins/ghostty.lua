return {
    "ghostty",
    ft = "ghostty",
    dir = (function()
        local resources_dir = os.getenv("GHOSTTY_RESOURCES_DIR")
        if not resources_dir or resources_dir == "" then
            return "/dev/null"
        end
        local vim_dir = resources_dir:gsub("/ghostty$", "/vim/vimfiles")
        local ok = vim.loop.fs_stat(vim_dir)
        if not ok then
            return "/dev/null"
        end

        return vim_dir
    end)(),
}
