return {
  "jake-stewart/jfind.nvim",
  enabled = true,
  -- TODO: update to 2.0
  branch = "1.0",
  opts = {
    exclude = {
      ".git",
      ".idea",
      -- ".vscode",
      ".sass-cache",
      ".class",
      "__pycache__",
      "node_modules",
      "target",
      "build",
      "tmp",
      "assets",
      "dist",
      -- "public",
      "*.iml",
      "*.meta",
    },
  },
  keys = {
    {
      "<D-p>",
      function()
        local jfind = require "jfind"
        local key = require "jfind.key"

        jfind.findFile {
          preview = true,
          callback = {
            [key.DEFAULT] = vim.cmd.edit,
            [key.CTRL_S] = vim.cmd.split,
            [key.CTRL_X] = vim.cmd.split,
            [key.CTRL_V] = vim.cmd.vsplit,
          },
        }
      end,
    },
    {
      "<C-p>",
      function()
        local jfind = require "jfind"
        local key = require "jfind.key"

        jfind.findFile {
          preview = true,
          callback = {
            [key.DEFAULT] = vim.cmd.edit,
            [key.CTRL_S] = vim.cmd.split,
            [key.CTRL_X] = vim.cmd.split,
            [key.CTRL_V] = vim.cmd.vsplit,
          },
        }
      end,
    },
  },
}
