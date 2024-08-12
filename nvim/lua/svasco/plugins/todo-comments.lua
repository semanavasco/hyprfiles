return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local todo_comments = require("todo-comments")

    -- setting keymaps
    local keymap = vim.keymap

    keymap.set("n", "]t", function()
      todo_comments.jump_next()
    end, { desc = "Go to next TO-DO comment."})
    
    keymap.set("n", "[t", function()
      todo_comments.jump_prev()
    end, { desc = "Go to previous TO-DO comment."})
    
    todo_comments.setup()
  end,
}
