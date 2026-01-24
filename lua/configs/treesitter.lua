-- ~/.config/nvim/lua/configs/treesitter.lua

-- Treesitter: 코드를 구문 트리(AST)로 파싱하여 정확한 하이라이팅, 들여쓰기, 코드 접기 제공
-- LSP는 언어 서버, Linter는 코드 품질 검사, Treesitter는 구문 분석
require("nvim-treesitter.configs").setup({
  -- 자동으로 설치할 언어 파서 목록
  ensure_installed = {
    "vim",        -- Vim 스크립트
    "lua",        -- Lua (Neovim 설정)
    "vimdoc",     -- Vim 도움말 문서
    "html",       -- HTML
    "css",        -- CSS
    "json",       -- JSON
    "javascript", -- JavaScript
    "typescript", -- TypeScript
    "bash",       -- Bash/Shell 스크립트
    "markdown",   -- Markdown
    "markdown_inline", -- Markdown 인라인 코드
    "yaml",       -- YAML
    "dockerfile", -- Dockerfile
    "toml",       -- TOML (설정 파일)
    "go",         -- Go
    "python",     -- Python
    "rust",       -- Rust
    "c",          -- C
    "cpp",        -- C++
    "sql",        -- SQL
    "hcl",        -- HCL (Terraform)
    "graphql",    -- GraphQL
    "prisma",     -- Prisma (데이터베이스 ORM)
  },
  auto_install = true, -- 새 파일 타입을 열 때 파서 자동 설치

  -- 구문 강조: 정규표현식 기반보다 훨씬 정확한 하이라이팅
  highlight = {
    enable = true,
  },

  -- 스마트 들여쓰기: 언어 문법에 맞는 자동 들여쓰기
  indent = {
    enable = true,
  },

  -- 코드 접기: 함수, 클래스 등을 접었다 펼 수 있음 (za, zo, zc 키 사용)
  fold = {
    enable = true,
  },

  -- 점진적 선택: 선택 영역을 점진적으로 확장/축소
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",    -- Ctrl+Space: 선택 시작
      node_incremental = "<C-space>",  -- Ctrl+Space: 선택 확장 (단어 → 표현식 → 함수 → 클래스)
      scope_incremental = "<C-s>",     -- Ctrl+s: 스코프 확장
      node_decremental = "<bs>",       -- Backspace: 선택 축소
    },
  },

  -- 텍스트 객체: 함수, 클래스, 파라미터 등을 쉽게 선택/이동
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- 커서 뒤의 객체도 자동으로 찾음
      keymaps = {
        -- 함수
        ["af"] = "@function.outer",  -- vaf: 함수 전체 선택 (주석 포함)
        ["if"] = "@function.inner",  -- vif: 함수 내부 선택 (함수 본문만)
        -- 클래스
        ["ac"] = "@class.outer",     -- vac: 클래스 전체 선택
        ["ic"] = "@class.inner",     -- vic: 클래스 내부 선택
        -- 조건문 (if, for, while 등)
        ["ai"] = "@conditional.outer", -- vai: 조건문 전체 선택
        ["ii"] = "@conditional.inner", -- vii: 조건문 내부 선택
        -- 루프
        ["al"] = "@loop.outer",      -- val: 루프 전체 선택
        ["il"] = "@loop.inner",      -- vil: 루프 내부 선택
        -- 파라미터/인자
        ["aa"] = "@parameter.outer", -- vaa: 파라미터 선택 (쉼표 포함)
        ["ia"] = "@parameter.inner", -- via: 파라미터 선택 (값만)
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- jumplist에 추가 (Ctrl+o로 되돌아갈 수 있음)
      goto_next_start = {
        ["]m"] = "@function.outer",   -- ]m: 다음 함수 시작으로 이동
        ["]c"] = "@class.outer",      -- ]c: 다음 클래스 시작으로 이동
        ["]a"] = "@parameter.inner",  -- ]a: 다음 파라미터로 이동
      },
      goto_next_end = {
        ["]M"] = "@function.outer",   -- ]M: 다음 함수 끝으로 이동
        ["]C"] = "@class.outer",      -- ]C: 다음 클래스 끝으로 이동
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",   -- [m: 이전 함수 시작으로 이동
        ["[c"] = "@class.outer",      -- [c: 이전 클래스 시작으로 이동
        ["[a"] = "@parameter.inner",  -- [a: 이전 파라미터로 이동
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",   -- [M: 이전 함수 끝으로 이동
        ["[C"] = "@class.outer",      -- [C: 이전 클래스 끝으로 이동
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner", -- <leader>a: 현재 파라미터와 다음 파라미터 교환
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner", -- <leader>A: 현재 파라미터와 이전 파라미터 교환
      },
    },
  },
})

