return {
  {
    "lewis6991/gitsigns.nvim",
    event = "BufEnter",
    opts = {
      signs = {
        add = { text = "┃" },
        change = { text = "┃" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "┃" },
        untracked = { text = "┆" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = buffer
          vim.keymap.set(mode, l, r, opts)
        end

        function next_hunk()
          if vim.wo.diff then return '<Leader>gn' end
          vim.schedule(function() gs.nav_hunk('next') end)
          return '<Ignore>'
        end

        function prev_hunk()
          if vim.wo.diff then return '<Leader>gp' end
          vim.schedule(function() gs.nav_hunk('prev') end)
          return '<Ignore>'
        end

        -- Navigation
        map('n', '<Leader>gn', next_hunk, { silent = true, noremap = true, expr = true, desc = "Next hunk" })
        map('n', '<Leader>gp', prev_hunk, { silent = true, noremap = true, expr = true, desc = "Prev hunk" })

        -- Actions
        map('n', '<Leader>gh', gs.preview_hunk, { silent = true, noremap = true, desc = "Hunk" })
        map('n', '<Leader>ga', gs.stage_hunk, { silent = true, noremap = true, desc = "Stage hunk" })
        map('v', '<Leader>ga', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, { silent = true, noremap = true, desc = "Stage hunk" })
        map('n', '<Leader>gr', gs.reset_hunk, { silent = true, noremap = true, desc = "Reset hunk" })
        map('v', '<Leader>gr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, { silent = true, noremap = true, desc = "Reset hunk" })
        map('n', '<Leader>gu', gs.undo_stage_hunk, { silent = true, noremap = true, desc = "Undo stage hunk" })
        map('n', '<Leader>gA', gs.stage_buffer, { silent = true, noremap = true, desc = "Stage buffer" })
        map('n', '<Leader>gR', gs.reset_buffer, { silent = true, noremap = true, desc = "Reset buffer" })
        map('n', '<Leader>gb', function() gs.blame_line({ full = true }) end, { silent = true, noremap = true, desc = "Blame line" })
        map('n', '<Leader>gd', gs.diffthis, { silent = true, noremap = true, desc = "Diff" })
      end,
    },
  }
}

