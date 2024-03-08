local plugins = {
  {
  "neovim/nvim-lspconfig",
   config = function()
      require "plugins.configs.lspconfig"
   end,
  },
  { "elkowar/yuck.vim" , lazy = false },  -- load a plugin at startup
  { "github/copilot.vim",
    lazy = false
    -- config = function ()
    --     vim.g.copilot_no_tab_map = true;
    --     vim.g.copilot_no_assumed_map = true;
    --     vim.g.copilot_tab_fallback = "";
    -- end
  },
  -- You can use any plugin specification from lazy.nvim
  {
    "Pocco81/TrueZen.nvim",
    cmd = { "TZAtaraxis", "TZMinimalist" },
    config = function()
      require "custom.configs.truezen" -- just an example path
    end,
  },

  -- this opts will extend the default opts 
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "html", "css", "bash",
        "cpp", "lua", "vim", "kotlin"
     },
    },
  },
  {
    "folke/which-key.nvim",
    enabled = false,
  },

  -- If your opts uses a function call, then make opts spec a function*
  -- should return the modified default config as well
  -- here we just call the default telescope config 
  -- and then assign a function to some of its options
  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      local conf = require "plugins.configs.telescope"
      conf.defaults.mappings.i = {
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<Esc>"] = require("telescope.actions").close,
      }

      return conf
    end,
  }
}

return plugins

