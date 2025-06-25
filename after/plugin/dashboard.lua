
local ascii_heatmap = require('git-dashboard-nvim').setup {}

local opts = {
  theme = 'doom',
  config = {
    header = ascii_heatmap,
    center = {
      { action = '', desc = '', icon = '', key = 'n' },
    },
    footer = function()
      return {}
    end,
  },
}

require('dashboard').setup(opts)

