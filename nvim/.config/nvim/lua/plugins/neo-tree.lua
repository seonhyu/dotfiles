-- Neo-tree - File Explorer
return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    default_component_configs = {
      modified = {
        symbol = '[+]',
        highlight = 'NeoTreeModified',
      },
      name = {
        trailing_slash = false,
        use_git_status_colors = true,
        highlight = 'NeoTreeFileName',
      },
      git_status = {
        symbols = {
          added = '✚',
          modified = '',
          deleted = '✖',
          renamed = '󰁕',
          untracked = '',
          ignored = '',
          unstaged = '󰄱',
          staged = '',
          conflict = '',
        },
      },
    },
    filesystem = {
      sort_case_insensitive = false,
      sort_function = function(a, b)
        if a.type == b.type then
          return a.path < b.path
        else
          return a.type < b.type
        end
      end,
      window = {
        mappings = {
          ['\\'] = 'close_window',
          ['<bs>'] = 'navigate_up',
          ['.'] = 'set_root',
          ['H'] = 'toggle_hidden',
          ['R'] = 'refresh',
          ['#'] = 'fuzzy_sorter',
        },
        position = 'left',
        width = 50,
      },
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_hidden = true,
        always_show = {
          '.gitignore',
        },
        never_show = {
          '.DS_Store',
          'thumbs.db',
        },
      },
      follow_current_file = {
        enabled = false,
        leave_dirs_open = false,
      },
      group_empty_dirs = false,
      hijack_netrw_behavior = 'open_default',
      use_libuv_file_watcher = true,
    },
    window = {
      mapping_options = {
        noremap = true,
        nowait = true,
      },
    },
    event_handlers = {
      {
        event = 'file_open_requested',
        handler = function()
          require('neo-tree.command').execute({ action = 'close' })
        end,
      },
    },
  },
}
