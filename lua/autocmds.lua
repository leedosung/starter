require "nvchad.autocmds"

-- Treesitter 기반 코드 폴딩 설정
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"  -- Neovim 0.10+ 최신 방법
vim.o.foldenable = true       -- 시작 시 fold 적용
vim.o.foldlevel = 99          -- 기본적으로 다 펼쳐진 상태 (0이면 모두 접힌 상태로 시작)

-- 외부 파일 변경 자동 리로드 설정
vim.opt.autoread = true

-- 파일 변경 감지 및 자동 리로드
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd("checktime")
    end
  end,
})

-- 외부에서 파일이 변경되었을 때 자동으로 리로드 (확인 메시지 없이)
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  callback = function()
    vim.notify("File changed on disk. Buffer reloaded.", vim.log.levels.INFO)
  end,
})

-- 버퍼 내용 기반 filetype 자동 감지
-- filetype이 없는 버퍼의 내용을 분석하여 자동으로 filetype 설정
local function detect_filetype()
  -- filetype이 이미 설정되어 있으면 스킵
  if vim.bo.filetype ~= "" then
    return
  end

  -- 버퍼가 비어있으면 스킵
  local line_count = vim.api.nvim_buf_line_count(0)
  if line_count == 0 or (line_count == 1 and vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] == "") then
    return
  end

  -- 첫 몇 줄 읽기
  local lines = vim.api.nvim_buf_get_lines(0, 0, math.min(10, line_count), false)
  local content = table.concat(lines, "\n")

  -- JSON 감지 ({ 또는 [ 로 시작)
  if content:match("^%s*{") or content:match("^%s*%[") then
    vim.bo.filetype = "json"
    return
  end

  -- XML 감지 (<?xml 또는 < 태그로 시작)
  if content:match("^%s*<%?xml") or content:match("^%s*<[^!]") then
    vim.bo.filetype = "xml"
    return
  end

  -- YAML 감지 (--- 또는 key: value 패턴)
  if content:match("^%-%-%-") or content:match("%w+:%s") then
    vim.bo.filetype = "yaml"
    return
  end
end

-- BufEnter, TextChanged 이벤트에 자동 감지 연결
vim.api.nvim_create_autocmd({"BufEnter", "BufReadPost", "TextChanged", "TextChangedI"}, {
  callback = detect_filetype,
})

-- .env 파일을 sh 타입으로 설정 (bash treesitter로 구문 강조)
-- shell로 인식되지만 shellcheck는 lint.lua에서 제외됨
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {".env", ".env.*", "*.env"},
  callback = function()
    vim.bo.filetype = "sh"
    -- .env 파일임을 표시 (lint 설정에서 사용)
    vim.b.is_env_file = true
  end,
})
