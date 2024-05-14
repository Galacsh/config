function Helper.get_foreground(name)
  local hl = vim.api.nvim_get_hl
    and vim.api.nvim_get_hl(0, { name = name })
    or vim.api.nvim_get_hl_by_name(name, true)
  local fg = hl and (hl.fg or hl.foreground)
  return fg and { fg = string.format("#%06x", fg) } or nil
end

function Helper.concat(t1, t2)
  local tbl = {}
  for i = 1, #t1 do
    tbl[i] = t1[i]
  end
  for i = 1, #t2 do
    tbl[#t1 + i] = t2[i]
  end
  return tbl
end

