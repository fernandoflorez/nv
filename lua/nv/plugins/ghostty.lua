local resources_dir = os.getenv("GHOSTTY_RESOURCES_DIR")
if resources_dir and resources_dir ~= "" then
    local vim_dir = resources_dir:gsub("/ghostty$", "/vim/vimfiles")
    local ok = vim.loop.fs_stat(vim_dir)
    if ok then
        return { "ghostty", ft = "ghostty", dir = vim_dir }
    end
end

return { "ghostty", ft = "ghostty", enabled = false }
