return {
  {
    "dyng/ctrlsf.vim",
    cmd = {
      "CtrlSF",
      "CtrlSFClearHL",
      "CtrlSFClose",
      "CtrlSFFocus",
      "CtrlSFOpen",
      "CtrlSFQuickfix",
      "CtrlSFStop",
      "CtrlSFToggle",
      "CtrlSFUpdate",
    },
    init = function()
      vim.g.ctrlsf_default_root = 'cwd'
      -- vim.g.ctrlsf_auto_focus = {at = 'start'}
    end
  }
}
