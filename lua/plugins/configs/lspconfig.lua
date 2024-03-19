dofile(vim.g.base46_cache .. "lsp")
require "nvchad.lsp"

local M = {}
local utils = require "core.utils"

-- export on_attach & capabilities for custom lspconfigs
M.on_attach = function(client, bufnr)
  utils.load_mappings("lspconfig", {
        buffer = bufnr 
    })

  if client.server_capabilities.signatureHelpProvider then
    require("nvchad.signature").setup(client)
  end

  if not utils.load_config().ui.lsp_semantic_tokens and client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

require("lspconfig").lua_ls.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,

  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          [vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types"] = true,
          [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     underline = true,
--     virtual_text = true,
--     signs = true,
--     update_in_insert = true
--   }
-- )
--
-- require'lspconfig'.ast_grep.setup{
--   cmd = {'ast-grep'};
--   filetypes = {'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'java', 'c', 'cpp', 'rust', 'python', 'ruby', 'go', 'lua', 'sh', 'bash', 'zsh', 'fish', 'powershell', 'bat', 'awk', 'sed', 'yaml', 'json', 'html', 'css', 'scss', 'less', 'stylus', 'graphql', 'markdown', 'vim', 'dockerfile', 'plaintext', 'csharp', 'php', 'r', 'haskell', 'ocaml', 'perl', 'scala', 'kotlin', 'swift', 'dart', 'elm', 'erlang', 'fsharp', 'julia', 'lisp', 'nim', 'purescript', 'reason', 'svelte', 'tcl', 'verilog', 'vhdl', 'zig', 'racket', 'scheme', 'clojure', 'fennel', 'moonscript', 'nix', 'toml', 'ini', 'nixos', 'nixexpr', 'nixcfg', 'nixenv', 'nixfile', 'nixopts', 'nixset', 'nixshell', 'nixstore', 'nixsys'};
--   root_dir = function(fname)
--     return vim.fn.getcwd() 
--   end
-- }

return M
