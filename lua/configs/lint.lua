local lint = require("lint")

-- Linter 설정
-- LSP가 기본 문법/타입 검사를 하고, Linter는 추가적인 코드 품질 검사를 수행
-- ESLint는 LSP로 실행 중이므로 여기서는 제외
lint.linters_by_ft = {
  -- Shell 스크립트: 문법 검사 및 베스트 프랙티스 검사
  sh = { "shellcheck" },
  bash = { "shellcheck" },

  -- YAML: 들여쓰기, 문법, 스타일 검사 (yamlls는 기본 문법만 체크)
  yaml = { "yamllint" },
  yml = { "yamllint" },

  -- Markdown: 스타일, 링크, 헤딩 구조 검사
  markdown = { "markdownlint" },
}

-- Linter 자동 실행 설정
-- 파일 열기, 저장, 편집 시 자동으로 linter 실행
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  callback = function()
    -- .env 파일에서는 shellcheck 실행하지 않음
    if vim.b.is_env_file then
      return
    end
    lint.try_lint()
  end,
})
