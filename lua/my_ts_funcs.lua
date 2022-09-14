local ts = vim.treesitter
local ts_utils = require 'nvim-treesitter.ts_utils'

local function test_cur_node(query) 
  local q = ts.parse_query(vim.bo.filetype, query)

  local bufnr = vim.api.nvim_get_current_buf() or 0
  local cur_node = ts_utils.get_node_at_cursor()
  
  for id, node, metadata in q:iter_captures(cur_node, bufnr) do 
    -- vim.pretty_print(node:type())
    -- vim.pretty_print(id)
    -- vim.pretty_print(metadata)
    return true
  end
  return false
end

return {
  test_cur_node = test_cur_node
}
