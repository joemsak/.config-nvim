return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require("lualine").setup({
      options = {
        theme = "catppuccin",
        section_separators = { left = ' ', right = ''},
      }
    })
  end
}

--set -g @catppuccin_window_left_separator ""
--set -g @catppuccin_window_right_separator " "
--set -g @catppuccin_window_middle_separator " █"
--set -g @catppuccin_window_number_position "right"
