require "nvchad.mappings"

-- 사용자 정의 키 매핑

local map = vim.keymap.set

-- 기본 매핑
-- map("n", ";", ":", { desc = "CMD enter command mode" })
-- 입력 모드에서 jk로 빠르게 Normal 모드로 전환
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- LSP 기능
-- <leader>ca: 현재 커서 위치에서 사용 가능한 코드 액션 표시 (자동 import, 수정 제안 등)
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
-- <leader>cf: 현재 버퍼의 코드를 LSP 설정에 따라 자동 포맷
map("n", "<leader>cf", vim.lsp.buf.format, { desc = "LSP format" })

-- JSON 포맷팅 (jq 명령어 필요)
-- <leader>jf: 현재 버퍼의 JSON을 예쁘게 포맷 (들여쓰기 적용)
map("n", "<Leader>jf", "<cmd>%!jq<cr>", { desc = "Format JSON" })
-- <leader>jc: 현재 버퍼의 JSON을 압축 (공백 제거, 한 줄로 만들기)
map("n", "<Leader>jc", "<cmd>%!jq -c<cr>", { desc = "Minify JSON" })

-- JWT 디코딩 (jwt-cli 필요)
-- Visual 모드: 선택한 JWT를 디코딩하여 새 창에 표시
-- Normal 모드: 현재 줄의 JWT를 디코딩하여 새 창에 표시
map("v", "<Leader>jd", function()
  -- 선택된 텍스트 가져오기
  vim.cmd('normal! "xy')
  local jwt = vim.fn.getreg('x')

  -- 공백 제거
  jwt = jwt:gsub("%s+", "")

  -- jwt decode 실행
  local handle = io.popen("echo '" .. jwt .. "' | jwt decode -j - 2>&1")
  local result = handle:read("*a")
  handle:close()

  -- 랜덤 이름 생성
  local random_id = string.format("%06x", math.random(0, 0xffffff))
  local buf_name = "JWT_decoded_" .. random_id .. ".json"

  -- 새 vertical split 창에 결과 표시
  vim.cmd("vsplit " .. buf_name)

  -- 결과를 버퍼에 삽입
  local lines = vim.split(result, "\n")
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  vim.bo.filetype = "json"
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "wipe"
end, { desc = "Decode JWT (visual)" })

map("n", "<Leader>jd", function()
  -- 현재 줄 가져오기
  local line = vim.api.nvim_get_current_line()

  -- 공백 제거
  line = line:gsub("%s+", "")

  -- jwt decode 실행
  local handle = io.popen("echo '" .. line .. "' | jwt decode -j - 2>&1")
  local result = handle:read("*a")
  handle:close()

  -- 랜덤 이름 생성
  local random_id = string.format("%06x", math.random(0, 0xffffff))
  local buf_name = "JWT_decoded_" .. random_id .. ".json"

  -- 새 vertical split 창에 결과 표시
  vim.cmd("vsplit " .. buf_name)

  -- 결과를 버퍼에 삽입
  local lines = vim.split(result, "\n")
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  vim.bo.filetype = "json"
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "wipe"
end, { desc = "Decode JWT (line)" })

-- XML 포맷팅 (xmllint 명령어 필요)
-- <leader>xf: 현재 버퍼의 XML을 예쁘게 포맷 (들여쓰기 적용)
map("n", "<Leader>xf", "<cmd>%!xmllint --format -<cr>", { desc = "Format XML" })
-- <leader>xc: 현재 버퍼의 XML을 압축 (불필요한 공백 제거)
map("n", "<Leader>xc", "<cmd>%!xmllint --noblanks -<cr>", { desc = "Minify XML" })

-- Telescope (파일 검색 도구)
-- <leader>fr: 마지막에 실행했던 Telescope 검색 재개
map("n", "<Leader>fr", "<cmd>Telescope resume<cr>", { desc = "Telescope resume" })

-- 마크다운 미리보기 (glow 명령어 필요)
-- <leader>mv: 현재 마크다운 파일을 glow로 렌더링하여 수직 분할 창에 표시
map("n", "<Leader>mv", "<cmd>vsplit | term glow %<cr>", { desc = "Markdown view" })

-- 터미널 토글 (ToggleTerm 플러그인)
-- <leader>h: 하단에 수평 터미널 열기/닫기
map("n", "<leader>h", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Horizontal terminal" })
-- <leader>v: 오른쪽에 수직 터미널 열기/닫기 (너비 60)
map("n", "<leader>v", "<cmd>ToggleTerm direction=vertical size=60<CR>", { desc = "Vertical terminal" })
-- <leader>o: 화면 중앙에 플로팅 터미널 열기/닫기
map("n", "<leader>o", "<cmd>ToggleTerm direction=float size=80<CR>", { desc = "Float terminal" })

-- 진단 메시지 표시 토글
-- LSP의 진단 메시지(에러, 경고, 힌트 등)의 표시 수준을 토글
-- false: 에러만 표시 (깔끔한 화면)
-- true: 모든 수준의 진단 표시 (힌트, 정보, 경고, 에러 모두)
local show_other_diagnostics = false

map("n", "<Leader>l", function()
  show_other_diagnostics = not show_other_diagnostics

  -- 표시할 진단 메시지의 심각도 범위 설정
  local severity = show_other_diagnostics
    and { min = vim.diagnostic.severity.HINT, max = vim.diagnostic.severity.ERROR }  -- 모든 레벨
    or { min = vim.diagnostic.severity.ERROR, max = vim.diagnostic.severity.ERROR }  -- 에러만

  vim.diagnostic.config({
    virtual_text = { severity = severity },  -- 코드 끝에 표시되는 진단 메시지
    signs = show_other_diagnostics,          -- 왼쪽 사인 컬럼에 아이콘 표시 여부
    underline = true,                        -- 문제가 있는 코드에 밑줄 표시
  })
  vim.opt.signcolumn = show_other_diagnostics and "yes" or "no"  -- 사인 컬럼 표시 토글
end, { desc = "Toggle diagnostics (errors only/all)" })

-- 터미널 관련 키맵 및 동작 설정

-- 터미널 버퍼에 진입하면 자동으로 Insert 모드로 전환
-- 이유: 터미널은 명령어 입력이 주 목적이므로 자동으로 입력 가능 상태로 만듦
vim.api.nvim_create_autocmd({"BufEnter", "WinEnter"}, {
  pattern = "term://*",  -- 터미널 버퍼 패턴 매칭
  command = "startinsert"
})

-- 터미널 모드에서 Ctrl+h/j/k/l로 윈도우 이동
-- 동작 순서: 터미널 모드 종료 → Normal 모드 전환 → 윈도우 이동
-- 장점: 터미널 작업 중에도 다른 윈도우로 즉시 이동 가능 (일반 모드와 동일한 키 사용)
local directions = {
  { key = "h", cmd = "h", desc = "Move to left window" },   -- 왼쪽
  { key = "j", cmd = "j", desc = "Move to down window" },   -- 아래
  { key = "k", cmd = "k", desc = "Move to up window" },     -- 위
  { key = "l", cmd = "l", desc = "Move to right window" },  -- 오른쪽
}

for _, dir in ipairs(directions) do
  map("t", "<C-" .. dir.key .. ">", function()
    vim.cmd.stopinsert()       -- 터미널 insert 모드 종료
    vim.cmd.wincmd(dir.cmd)    -- 윈도우 이동 명령 실행
  end, { noremap = true, silent = true, desc = dir.desc })
end

-- 터미널에서 Ctrl+q로 터미널 닫기
-- 동작: Ctrl+q 누르면 → Insert 모드 종료 → 탭이 여러개면 탭 닫기, 아니면 윈도우 닫기
-- 장점: 빠르게 터미널 종료 가능 (일반적인 :q 대신), Esc는 터미널 프로그램에서 정상 동작
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    vim.keymap.set("t", "<C-q>", function()
      vim.cmd.stopinsert()  -- Insert 모드 종료
      if vim.fn.tabpagenr("$") > 1 then
        vim.cmd.tabclose()  -- 탭이 2개 이상이면 현재 탭 닫기
      else
        vim.cmd.close()     -- 탭이 1개면 윈도우만 닫기
      end
    end, { buffer = buf, silent = true, desc = "Close terminal" })
  end,
})

-- Git 관련 키매핑 (Diffview 사용)
-- <leader>gh: 현재 파일의 Git 히스토리를 Diffview로 표시 (읽기 전용, 안전)
map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", { desc = "Git file history" })

-- 마우스 모드 토글
-- <leader>me: 마우스 사용 ON/OFF 전환
-- ON(a): 마우스로 커서 이동, 텍스트 선택, 윈도우 크기 조절 가능
-- OFF(""): 마우스 비활성화, 터미널 자체의 마우스 기능 사용 (복사/붙여넣기 등)
map("n", "<leader>me", function()
  local is_enabled = vim.o.mouse == "a"
  vim.opt.mouse = is_enabled and "" or "a"
  vim.notify(is_enabled and "Mouse disabled" or "Mouse enabled", vim.log.levels.INFO)
end, { desc = "Toggle mouse mode" })
