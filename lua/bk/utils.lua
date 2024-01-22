function map(mode, lhs, rhs, desc, opts)
  local options = { noremap = true, silent = true, desc = desc }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end
