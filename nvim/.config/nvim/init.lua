-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- fcitx5 状态切换与恢复
local fcitx_st = ""
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    fcitx_st = vim.fn.system("fcitx5-remote")
    vim.fn.jobstart("fcitx5-remote -c")
  end,
})
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    if fcitx_st:match("2") then
      vim.fn.jobstart("fcitx5-remote -o")
    end
  end,
})
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.fn.jobstart("fcitx5-remote -c")
  end,
})
-- 快捷键: <F5> 编译并运行当前 C++ 文件，<F6> 关闭运行窗口
local cpp_runner_win = nil
local cpp_runner_buf = nil

vim.keymap.set("n", "<F5>", function()
  local ext = vim.fn.expand("%:e")
  if ext ~= "cpp" and ext ~= "cc" and ext ~= "cxx" then
    vim.notify("当前文件不是 C++ 文件", vim.log.levels.WARN)
    return
  end

  vim.cmd("write")

  local src = vim.fn.shellescape(vim.fn.expand("%:p"))
  local exe = vim.fn.shellescape(vim.fn.expand("%:p:r"))
  local cmd = "g++ -std=c++17 -Wall -Wextra " .. src .. " -o " .. exe .. " && " .. exe

  if cpp_runner_win and vim.api.nvim_win_is_valid(cpp_runner_win) then
    vim.api.nvim_set_current_win(cpp_runner_win)
  else
    vim.cmd("botright 15split")
    cpp_runner_win = vim.api.nvim_get_current_win()
  end

  if cpp_runner_buf and vim.api.nvim_buf_is_valid(cpp_runner_buf) then
    vim.api.nvim_win_set_buf(cpp_runner_win, cpp_runner_buf)
    vim.bo[cpp_runner_buf].modifiable = true
    vim.api.nvim_buf_set_lines(cpp_runner_buf, 0, -1, false, {})
  else
    cpp_runner_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(cpp_runner_win, cpp_runner_buf)
  end

  vim.fn.termopen(cmd)
  vim.cmd("startinsert")
end, { desc = "Compile and run C++" })

vim.keymap.set("n", "<F6>", function()
  if cpp_runner_win and vim.api.nvim_win_is_valid(cpp_runner_win) then
    vim.api.nvim_win_close(cpp_runner_win, true)
  end
end, { desc = "Close C++ runner window" })
