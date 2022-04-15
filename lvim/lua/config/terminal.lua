-- Toogleterm
lvim.builtin.terminal.direction = 'vertical'
lvim.builtin.terminal.shade_terminals = true
lvim.builtin.terminal.size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end

vim.opt.termguicolors = true

