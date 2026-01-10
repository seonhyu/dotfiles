-- Mini.nvim - Small independent plugins
return {
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    require('mini.ai').setup({ n_lines = 500 })

    -- Add/delete/replace surroundings (vim-surround style)
    require('mini.surround').setup({
      mappings = {
        add = 'ys',
        delete = 'ds',
        replace = 'cs',
        find = '',
        find_left = '',
        highlight = '',
        update_n_lines = '',
      },
    })

    -- Statusline
    local statusline = require('mini.statusline')
    statusline.setup({ use_icons = vim.g.have_nerd_font })

    statusline.section_location = function()
      return '%2l:%-2v'
    end
  end,
}
