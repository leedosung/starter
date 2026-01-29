require("nvchad.configs.lspconfig").defaults()

-- LSP 서버 목록
-- 각 서버는 Mason으로 먼저 설치되어야 함 (:Mason 실행)
local servers = {
  "html",        -- HTML: 웹 페이지 마크업 언어
  "cssls",       -- CSS: 스타일시트 언어
  "ts_ls",       -- TypeScript/JavaScript: 웹 프론트엔드 및 Node.js 개발
  "eslint",      -- ESLint: JavaScript/TypeScript 코드 품질 검사 도구
  "clangd",      -- C/C++: 시스템 프로그래밍 언어
  "gopls",       -- Go: 구글이 개발한 시스템 프로그래밍 언어
  "rust_analyzer", -- Rust: 메모리 안전성을 보장하는 시스템 프로그래밍 언어
  "jsonls",      -- JSON: 데이터 교환 포맷
  "bashls",      -- Bash/Shell: 쉘 스크립트 작성
  "yamlls",      -- YAML: 설정 파일 포맷 (Kubernetes, Docker Compose 등)
  "marksman",    -- Markdown: 문서 작성 언어
  "lua_ls",      -- Lua: Neovim 설정 및 스크립트 언어
  "terraformls", -- Terraform: 인프라스트럭처 자동화 (IaC)
  "dockerls"     -- Dockerfile: 컨테이너 이미지 빌드 스크립트
}

-- LSP 서버 활성화 (Neovim 0.10+ 내장 함수)
vim.lsp.enable(servers)

-- lua_ls 추가 설정: Neovim 환경 인식
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        -- vim을 글로벌로 인식 (undefined global 경고 제거)
        globals = { "vim" },
      },
      workspace = {
        -- Neovim 런타임 파일 인식
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false, -- 외부 라이브러리 확인 비활성화 (속도 향상)
      },
      telemetry = {
        enable = false, -- 텔레메트리 비활성화
      },
    },
  },
})

-- LSP 서버 옵션 변경: :h vim.lsp.config 참고 
