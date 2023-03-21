-- Adapted from https://github.com/RRethy/nvim-base16
-- TODO: update this to use the new nvim highlights api
local M = {}

M.highlight = setmetatable({}, {
    __newindex = function(_, hlgroup, args)
        if ('string' == type(args)) then
            vim.cmd(('hi! link %s %s'):format(hlgroup, args))
            return
        end

        local guifg, guibg, gui, guisp, blend = args.guifg or nil, args.guibg or nil, args.gui or nil, args.guisp or nil, args.blend or nil
        local cmd = {'hi', hlgroup}
        if guifg then table.insert(cmd, 'guifg='..guifg) end
        if guibg then table.insert(cmd, 'guibg='..guibg) end
        if gui then table.insert(cmd, 'gui='..gui) end
        if guisp then table.insert(cmd, 'guisp='..guisp) end
        if blend then table.insert(cmd, 'blend='..blend) end
        vim.cmd(table.concat(cmd, ' '))
    end
})

function M.setup(colors)
    if vim.fn.exists('syntax_on') then
        vim.cmd('syntax reset')
    end

    M.colors = colors
    local hi = M.highlight

    -- Vim editor colors
    hi.Normal       = { guifg = M.colors.base05, guibg = 'none', gui = nil, guisp = nil }
    hi.Bold         = { guifg = nil, guibg = nil, gui = 'bold', guisp = nil }
    hi.Debug        = { guifg = M.colors.base08, guibg = nil, gui = nil, guisp = nil }
    hi.Directory    = { guifg = M.colors.base0D, guibg = nil, gui = nil, guisp = nil }
    hi.Error        = { guifg = M.colors.base08, guibg = 'none', gui = 'bold', guisp = nil }
    hi.ErrorMsg     = { guifg = M.colors.base08, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.Exception    = { guifg = M.colors.base08, guibg = nil, gui = nil, guisp = nil }
    hi.FoldColumn   = { guifg = M.colors.base0C, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.Folded       = { guifg = M.colors.base03, guibg = M.colors.base01, gui = nil, guisp = nil }
    hi.IncSearch    = { guifg = M.colors.base01, guibg = M.colors.base09, gui = 'none', guisp = nil }
    hi.Italic       = { guifg = nil, guibg = nil, gui = 'none', guisp = nil }
    hi.Macro        = { guifg = M.colors.base08, guibg = nil, gui = nil, guisp = nil }
    hi.MatchParen   = { guifg = nil, guibg = 'none', gui = 'underline', guisp = M.colors.base04 }
    hi.ModeMsg      = { guifg = M.colors.base0B, guibg = nil, gui = nil, guisp = nil }
    hi.MoreMsg      = { guifg = M.colors.base0B, guibg = nil, gui = nil, guisp = nil }
    hi.Question     = { guifg = M.colors.base0D, guibg = nil, gui = nil, guisp = nil }
    hi.Search       = { guifg = M.colors.base0A, guibg = M.colors.base01, gui = nil, guisp = nil }
    hi.Substitute   = { guifg = M.colors.base01, guibg = M.colors.base0A, gui = 'none', guisp = nil }
    hi.SpecialKey   = { guifg = M.colors.base03, guibg = nil, gui = nil, guisp = nil }
    hi.TooLong      = { guifg = M.colors.base08, guibg = nil, gui = nil, guisp = nil }
    hi.Underlined   = { guifg = nil, guibg = nil, gui = 'underline', guisp = nil }
    hi.Visual       = { guifg = nil, guibg = M.colors.base01, gui = nil, guisp = nil }
    hi.VisualNOS    = { guifg = M.colors.base08, guibg = nil, gui = nil, guisp = nil }
    hi.WarningMsg   = { guifg = M.colors.base08, guibg = nil, gui = nil, guisp = nil }
    hi.WildMenu     = { guifg = M.colors.base08, guibg = M.colors.base0A, gui = nil, guisp = nil }
    hi.Title        = { guifg = M.colors.base0D, guibg = nil, gui = 'none', guisp = nil }
    hi.Conceal      = { guifg = M.colors.base0D, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.Cursor       = { guifg = M.colors.base00, guibg = M.colors.base09, gui = nil, guisp = nil }
    hi.NonText      = { guifg = M.colors.base03, guibg = nil, gui = nil, guisp = nil }
    hi.LineNr       = { guifg = M.colors.base04, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.SignColumn   = { guifg = M.colors.base04, guibg = 'none', gui = nil, guisp = nil }
    hi.StatusLine   = { guifg = M.colors.base05, guibg = 'none', gui = 'none', guisp = nil }
    hi.StatusLineNC = { guifg = M.colors.base04, guibg = 'none', gui = 'none', guisp = nil }
    hi.WinBar       = { guifg = M.colors.base05, guibg = nil, gui = 'none', guisp = nil }
    hi.WinBarNC     = { guifg = M.colors.base04, guibg = nil, gui = 'none', guisp = nil }
    hi.VertSplit    = { guifg = M.colors.base01, guibg = 'none', gui = 'none', guisp = nil }
    hi.ColorColumn  = { guifg = nil, guibg = M.colors.base01, gui = 'none', guisp = nil }
    hi.CursorColumn = { guifg = nil, guibg = M.colors.base01, gui = 'none', guisp = nil }
    hi.CursorLine   = { guifg = nil, guibg = M.colors.base01, gui = nil, guisp = nil }
    hi.CursorLineNr = { guifg = M.colors.base04, guibg = M.colors.base01, gui = nil, guisp = nil }
    hi.QuickFixLine = { guifg = nil, guibg = M.colors.base01, gui = 'none', guisp = nil }
    hi.PMenu        = { guifg = M.colors.base05, guibg = 'none', gui = 'none', guisp = nil }
    hi.PMenuSel     = { guifg = nil, guibg = M.colors.base01, gui = nil, guisp = nil }
    hi.PMenuSbar    = { guifg = M.colors.base05, guibg = nil, gui = nil, guisp = nil }
    hi.PMenuThumb   = { guifg = nil, guibg = M.colors.base0F, gui = nil, guisp = nil }
    hi.TabLine      = { guifg = M.colors.base03, guibg = M.colors.base01, gui = 'none', guisp = nil }
    hi.TabLineFill  = { guifg = M.colors.base03, guibg = M.colors.base01, gui = 'none', guisp = nil }
    hi.TabLineSel   = { guifg = M.colors.base0B, guibg = M.colors.base09, gui = 'none', guisp = nil }

    hi.NvimInternalError = { guifg = M.colors.base00, guibg = M.colors.base08, gui = 'none', guisp = nil }

    hi.NormalFloat  = { guifg = M.colors.base05, guibg = 'none', gui = nil, guisp = nil }
    hi.FloatBorder  = { guifg = M.colors.base01, guibg = 'none', gui = nil, guisp = nil }
    hi.NormalNC     = { guifg = M.colors.base05, guibg = 'none', gui = nil, guisp = nil }
    hi.TermCursor   = { guifg = M.colors.base00, guibg = M.colors.base05, gui = 'none', guisp = nil }
    hi.TermCursorNC = { guifg = M.colors.base00, guibg = M.colors.base05, gui = nil, guisp = nil }

    -- Cursor colours
    hi.CursorNormal      = { guifg = M.colors.base00, guibg = M.colors.base09, gui = nil, guisp = nil }
    hi.CursorInsert      = { guifg = M.colors.base00, guibg = M.colors.base0B, gui = nil, guisp = nil }
    hi.CursorVisual      = { guifg = M.colors.base00, guibg = M.colors.base0E, gui = nil, guisp = nil }
    hi.CursorReplace     = { guifg = M.colors.base00, guibg = M.colors.base08, gui = nil, guisp = nil }
    hi.CursorOther       = { guifg = M.colors.base00, guibg = M.colors.base0D, gui = nil, guisp = nil }
    hi.MiniAnimateCursor = { guifg = M.colors.base09, guibg = nil, gui = 'reverse', guisp = 'nocombine' }

    -- Standard syntax highlighting
    hi.Boolean      = { guifg = M.colors.base09, guibg = nil, gui = nil, guisp = nil }
    hi.Character    = { guifg = M.colors.base08, guibg = nil, gui = nil, guisp = nil }
    hi.Comment      = { guifg = M.colors.base03, guibg = nil, gui = nil, guisp = nil }
    hi.Conditional  = { guifg = M.colors.base0E, guibg = nil, gui = nil, guisp = nil }
    hi.Constant     = { guifg = M.colors.base09, guibg = nil, gui = nil, guisp = nil }
    hi.Define       = { guifg = M.colors.base0E, guibg = nil, gui = 'none', guisp = nil }
    hi.Delimiter    = { guifg = M.colors.base0F, guibg = nil, gui = nil, guisp = nil }
    hi.Float        = { guifg = M.colors.base09, guibg = nil, gui = nil, guisp = nil }
    hi.Function     = { guifg = M.colors.base0D, guibg = nil, gui = nil, guisp = nil }
    hi.Identifier   = { guifg = M.colors.base08, guibg = nil, gui = 'none', guisp = nil }
    hi.Include      = { guifg = M.colors.base0D, guibg = nil, gui = nil, guisp = nil }
    hi.Keyword      = { guifg = M.colors.base0E, guibg = nil, gui = nil, guisp = nil }
    hi.Label        = { guifg = M.colors.base0A, guibg = nil, gui = nil, guisp = nil }
    hi.Number       = { guifg = M.colors.base09, guibg = nil, gui = nil, guisp = nil }
    hi.Operator     = { guifg = M.colors.base05, guibg = nil, gui = 'none', guisp = nil }
    hi.PreProc      = { guifg = M.colors.base0A, guibg = nil, gui = nil, guisp = nil }
    hi.Repeat       = { guifg = M.colors.base0A, guibg = nil, gui = nil, guisp = nil }
    hi.Special      = { guifg = M.colors.base0C, guibg = nil, gui = nil, guisp = nil }
    hi.SpecialChar  = { guifg = M.colors.base0F, guibg = nil, gui = nil, guisp = nil }
    hi.Statement    = { guifg = M.colors.base08, guibg = nil, gui = nil, guisp = nil }
    hi.StorageClass = { guifg = M.colors.base0A, guibg = nil, gui = nil, guisp = nil }
    hi.String       = { guifg = M.colors.base0B, guibg = nil, gui = nil, guisp = nil }
    hi.Structure    = { guifg = M.colors.base0E, guibg = nil, gui = nil, guisp = nil }
    hi.Tag          = { guifg = M.colors.base0A, guibg = nil, gui = nil, guisp = nil }
    hi.Todo         = { guifg = M.colors.base0A, guibg = M.colors.base01, gui = nil, guisp = nil }
    hi.Type         = { guifg = M.colors.base0A, guibg = nil, gui = 'none', guisp = nil }
    hi.Typedef      = { guifg = M.colors.base0A, guibg = nil, gui = nil, guisp = nil }

    -- Diff highlighting
    hi.DiffAdd     = { guifg = M.colors.base0B, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.DiffChange  = { guifg = M.colors.base03, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.DiffDelete  = { guifg = M.colors.base08, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.DiffText    = { guifg = M.colors.base0D, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.DiffAdded   = { guifg = M.colors.base0B, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.DiffFile    = { guifg = M.colors.base08, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.DiffNewFile = { guifg = M.colors.base0B, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.DiffLine    = { guifg = M.colors.base0D, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.DiffRemoved = { guifg = M.colors.base08, guibg = M.colors.base00, gui = nil, guisp = nil }

    -- Git highlighting
    hi.gitcommitOverflow      = { guifg = M.colors.base08, guibg = nil, gui = nil, guisp = nil }
    hi.gitcommitSummary       = { guifg = M.colors.base0B, guibg = nil, gui = nil, guisp = nil }
    hi.gitcommitComment       = { guifg = M.colors.base03, guibg = nil, gui = nil, guisp = nil }
    hi.gitcommitUntracked     = { guifg = M.colors.base03, guibg = nil, gui = nil, guisp = nil }
    hi.gitcommitDiscarded     = { guifg = M.colors.base03, guibg = nil, gui = nil, guisp = nil }
    hi.gitcommitSelected      = { guifg = M.colors.base03, guibg = nil, gui = nil, guisp = nil }
    hi.gitcommitHeader        = { guifg = M.colors.base0E, guibg = nil, gui = nil, guisp = nil }
    hi.gitcommitSelectedType  = { guifg = M.colors.base0D, guibg = nil, gui = nil, guisp = nil }
    hi.gitcommitUnmergedType  = { guifg = M.colors.base0D, guibg = nil, gui = nil, guisp = nil }
    hi.gitcommitDiscardedType = { guifg = M.colors.base0D, guibg = nil, gui = nil, guisp = nil }
    hi.gitcommitBranch        = { guifg = M.colors.base09, guibg = nil, gui = 'bold', guisp = nil }
    hi.gitcommitUntrackedFile = { guifg = M.colors.base0A, guibg = nil, gui = nil, guisp = nil }
    hi.gitcommitUnmergedFile  = { guifg = M.colors.base08, guibg = nil, gui = 'bold', guisp = nil }
    hi.gitcommitDiscardedFile = { guifg = M.colors.base08, guibg = nil, gui = 'bold', guisp = nil }
    hi.gitcommitSelectedFile  = { guifg = M.colors.base0B, guibg = nil, gui = 'bold', guisp = nil }

    hi.GitSignsAdd          = { guifg = M.colors.base0B, guibg = 'none', gui = nil, guisp = nil }
    hi.GitSignsChange       = { guifg = M.colors.base0D, guibg = 'none', gui = nil, guisp = nil }
    hi.GitSignsDelete       = { guifg = M.colors.base08, guibg = 'none', gui = nil, guisp = nil }
    hi.GitSignsChangedelete = { guifg = M.colors.base0E, guibg = 'none', gui = nil, guisp = nil }

    -- Spelling highlighting
    hi.SpellBad   = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = M.colors.base08 }
    hi.SpellLocal = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = M.colors.base0C }
    hi.SpellCap   = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = M.colors.base0D }
    hi.SpellRare  = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = M.colors.base0E }

    -- lSP
    hi.DiagnosticError                = { guifg = M.colors.base08, guibg = nil, gui = 'none', guisp = nil }
    hi.DiagnosticWarn                 = { guifg = M.colors.base0A, guibg = nil, gui = 'none', guisp = nil }
    hi.DiagnosticInfo                 = { guifg = M.colors.base0C, guibg = nil, gui = 'none', guisp = nil }
    hi.DiagnosticHint                 = { guifg = M.colors.base0E, guibg = nil, gui = 'none', guisp = nil }
    hi.DiagnosticUnderlineError       = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = M.colors.base08 }
    hi.DiagnosticUnderlineWarning     = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = M.colors.base0A }
    hi.DiagnosticUnderlineWarn        = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = M.colors.base0A }
    hi.DiagnosticUnderlineInformation = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = M.colors.base0C }
    hi.DiagnosticUnderlineHint        = { guifg = nil, guibg = nil, gui = 'undercurl', guisp = M.colors.base0E }

    hi.LspReferenceText                   = { guifg = nil, guibg = nil, gui = 'underline', guisp = M.colors.base04 }
    hi.LspReferenceRead                   = { guifg = nil, guibg = nil, gui = 'underline', guisp = M.colors.base04 }
    hi.LspReferenceWrite                  = { guifg = nil, guibg = nil, gui = 'underline', guisp = M.colors.base04 }
    hi.LspDiagnosticsDefaultError         = 'DiagnosticError'
    hi.LspDiagnosticsDefaultWarning       = 'DiagnosticWarn'
    hi.LspDiagnosticsDefaultInformation   = 'DiagnosticInfo'
    hi.LspDiagnosticsDefaultHint          = 'DiagnosticHint'
    hi.LspDiagnosticsUnderlineError       = 'DiagnosticUnderlineError'
    hi.LspDiagnosticsUnderlineWarning     = 'DiagnosticUnderlineWarning'
    hi.LspDiagnosticsUnderlineInformation = 'DiagnosticUnderlineInformation'
    hi.LspDiagnosticsUnderlineHint        = 'DiagnosticUnderlineHint'

    -- Treesitter
    hi.TSAnnotation         = { guifg = M.colors.base0F, guibg = nil, gui = 'none', guisp = nil }
    hi.TSAttribute          = { guifg = M.colors.base0A, guibg = nil, gui = 'none', guisp = nil }
    hi.TSBoolean            = { guifg = M.colors.base09, guibg = nil, gui = 'none', guisp = nil }
    hi.TSCharacter          = { guifg = M.colors.base08, guibg = nil, gui = 'none', guisp = nil }
    hi.TSComment            = { guifg = M.colors.base03, guibg = nil, gui = 'italic', guisp = nil }
    hi.TSConstructor        = { guifg = M.colors.base0D, guibg = nil, gui = 'none', guisp = nil }
    hi.TSConditional        = { guifg = M.colors.base0E, guibg = nil, gui = 'none', guisp = nil }
    hi.TSConstant           = { guifg = M.colors.base09, guibg = nil, gui = 'none', guisp = nil }
    hi.TSConstBuiltin       = { guifg = M.colors.base09, guibg = nil, gui = 'italic', guisp = nil }
    hi.TSConstMacro         = { guifg = M.colors.base08, guibg = nil, gui = 'none', guisp = nil }
    hi.TSError              = { guifg = M.colors.base08, guibg = nil, gui = 'none', guisp = nil }
    hi.TSException          = { guifg = M.colors.base08, guibg = nil, gui = 'none', guisp = nil }
    hi.TSField              = { guifg = M.colors.base05, guibg = nil, gui = 'none', guisp = nil }
    hi.TSFloat              = { guifg = M.colors.base09, guibg = nil, gui = 'none', guisp = nil }
    hi.TSFunction           = { guifg = M.colors.base0D, guibg = nil, gui = 'none', guisp = nil }
    hi.TSFuncBuiltin        = { guifg = M.colors.base0D, guibg = nil, gui = 'italic', guisp = nil }
    hi.TSFuncMacro          = { guifg = M.colors.base08, guibg = nil, gui = 'none', guisp = nil }
    hi.TSInclude            = { guifg = M.colors.base0D, guibg = nil, gui = 'none', guisp = nil }
    hi.TSKeyword            = { guifg = M.colors.base0E, guibg = nil, gui = 'none', guisp = nil }
    hi.TSKeywordFunction    = { guifg = M.colors.base0E, guibg = nil, gui = 'none', guisp = nil }
    hi.TSKeywordOperator    = { guifg = M.colors.base0E, guibg = nil, gui = 'none', guisp = nil }
    hi.TSLabel              = { guifg = M.colors.base0A, guibg = nil, gui = 'none', guisp = nil }
    hi.TSMethod             = { guifg = M.colors.base0D, guibg = nil, gui = 'none', guisp = nil }
    hi.TSNamespace          = { guifg = M.colors.base08, guibg = nil, gui = 'none', guisp = nil }
    hi.TSNone               = { guifg = M.colors.base05, guibg = nil, gui = 'none', guisp = nil }
    hi.TSNumber             = { guifg = M.colors.base09, guibg = nil, gui = 'none', guisp = nil }
    hi.TSOperator           = { guifg = M.colors.base05, guibg = nil, gui = 'none', guisp = nil }
    hi.TSParameter          = { guifg = M.colors.base05, guibg = nil, gui = 'none', guisp = nil }
    hi.TSParameterReference = { guifg = M.colors.base05, guibg = nil, gui = 'none', guisp = nil }
    hi.TSProperty           = { guifg = M.colors.base05, guibg = nil, gui = 'none', guisp = nil }
    hi.TSPunctDelimiter     = { guifg = M.colors.base0F, guibg = nil, gui = 'none', guisp = nil }
    hi.TSPunctBracket       = { guifg = M.colors.base05, guibg = nil, gui = 'none', guisp = nil }
    hi.TSPunctSpecial       = { guifg = M.colors.base05, guibg = nil, gui = 'none', guisp = nil }
    hi.TSRepeat             = { guifg = M.colors.base0E, guibg = nil, gui = 'none', guisp = nil }
    hi.TSString             = { guifg = M.colors.base0B, guibg = nil, gui = 'none', guisp = nil }
    hi.TSStringRegex        = { guifg = M.colors.base0C, guibg = nil, gui = 'none', guisp = nil }
    hi.TSStringEscape       = { guifg = M.colors.base0C, guibg = nil, gui = 'none', guisp = nil }
    hi.TSSymbol             = { guifg = M.colors.base0B, guibg = nil, gui = 'none', guisp = nil }
    hi.TSTag                = { guifg = M.colors.base08, guibg = nil, gui = 'none', guisp = nil }
    hi.TSTagDelimiter       = { guifg = M.colors.base0F, guibg = nil, gui = 'none', guisp = nil }
    hi.TSText               = { guifg = M.colors.base05, guibg = nil, gui = 'none', guisp = nil }
    hi.TSStrong             = { guifg = nil, guibg = nil, gui = 'bold', guisp = nil }
    hi.TSEmphasis           = { guifg = M.colors.base09, guibg = nil, gui = 'italic', guisp = nil }
    hi.TSUnderline          = { guifg = M.colors.base00, guibg = nil, gui = 'underline', guisp = nil }
    hi.TSStrike             = { guifg = M.colors.base00, guibg = nil, gui = 'strikethrough', guisp = nil }
    hi.TSTitle              = { guifg = M.colors.base0D, guibg = nil, gui = 'none', guisp = nil }
    hi.TSLiteral            = { guifg = M.colors.base09, guibg = nil, gui = 'none', guisp = nil }
    hi.TSURI                = { guifg = M.colors.base09, guibg = nil, gui = 'underline', guisp = nil }
    hi.TSType               = { guifg = M.colors.base0A, guibg = nil, gui = 'none', guisp = nil }
    hi.TSTypeBuiltin        = { guifg = M.colors.base0A, guibg = nil, gui = 'italic', guisp = nil }
    hi.TSVariable           = { guifg = M.colors.base08, guibg = nil, gui = 'none', guisp = nil }
    hi.TSVariableBuiltin    = { guifg = M.colors.base08, guibg = nil, gui = 'italic', guisp = nil }

    hi.TSDefinition      = { guifg = nil, guibg = nil, gui = 'underline', guisp = M.colors.base04 }
    hi.TSDefinitionUsage = { guifg = nil, guibg = nil, gui = 'underline', guisp = M.colors.base04 }
    hi.TSCurrentScope    = { guifg = nil, guibg = nil, gui = 'bold', guisp = nil }

    hi['@comment'] = 'TSComment'
    hi['@error'] = 'TSError'
    hi['@none'] = 'TSNone'
    hi['@preproc'] = 'PreProc'
    hi['@define'] = 'Define'
    hi['@operator'] = 'TSOperator'
    hi['@punctuation.delimiter'] = 'TSPunctDelimiter'
    hi['@punctuation.bracket'] = 'TSPunctBracket'
    hi['@punctuation.special'] = 'TSPunctSpecial'
    hi['@string'] = 'TSString'
    hi['@string.regex'] = 'TSStringRegex'
    hi['@string.escape'] = 'TSStringEscape'
    hi['@string.special'] = 'SpecialChar'
    hi['@character'] = 'TSCharacter'
    hi['@character.special'] = 'SpecialChar'
    hi['@boolean'] = 'TSBoolean'
    hi['@number'] = 'TSNumber'
    hi['@float'] = 'TSFloat'
    hi['@function'] = 'TSFunction'
    hi['@function.call'] = 'TSFunction'
    hi['@function.builtin'] = 'TSFuncBuiltin'
    hi['@function.macro'] = 'TSFuncMacro'
    hi['@method'] = 'TSMethod'
    hi['@method.call'] = 'TSMethod'
    hi['@constructor'] = 'TSConstructor'
    hi['@parameter'] = 'TSParameter'
    hi['@keyword'] = 'TSKeyword'
    hi['@keyword.coroutine'] = 'TSFuncMacro'
    hi['@keyword.function'] = 'TSKeywordFunction'
    hi['@keyword.operator'] = 'TSKeywordOperator'
    hi['@keyword.return'] = 'TSKeyword'
    hi['@conditional'] = 'TSConditional'
    hi['@repeat'] = 'TSRepeat'
    hi['@debug'] = 'Debug'
    hi['@label'] = 'TSLabel'
    hi['@include'] = 'TSInclude'
    hi['@exception'] = 'TSException'
    hi['@type'] = 'TSType'
    hi['@type.builtin'] = 'TSTypeBuiltin'
    hi['@type.qualifier'] = 'TSKeyword'
    hi['@type.definition'] = 'TSType'
    hi['@storageclass'] = 'StorageClass'
    hi['@attribute'] = 'TSAttribute'
    hi['@field'] = 'TSField'
    hi['@property'] = 'TSProperty'
    hi['@variable'] = 'TSVariable'
    hi['@variable.builtin'] = 'TSVariableBuiltin'
    hi['@constant'] = 'TSConstant'
    hi['@constant.builtin'] = 'TSConstant'
    hi['@constant.macro'] = 'TSConstant'
    hi['@namespace'] = 'TSNamespace'
    hi['@symbol'] = 'TSSymbol'
    hi['@text'] = 'TSText'
    hi['@text.diff.add'] = 'DiffAdd'
    hi['@text.diff.delete'] = 'DiffDelete'
    hi['@text.strong'] = 'TSStrong'
    hi['@text.emphasis'] = 'TSEmphasis'
    hi['@text.underline'] = 'TSUnderline'
    hi['@text.strike'] = 'TSStrike'
    hi['@text.title'] = 'TSTitle'
    hi['@text.literal'] = 'TSLiteral'
    hi['@text.uri'] = 'TSUri'
    hi['@text.math'] = 'Number'
    hi['@text.environment'] = 'Macro'
    hi['@text.environment.name'] = 'Type'
    hi['@text.reference'] = 'TSParameterReference'
    hi['@text.todo'] = 'Todo'
    hi['@text.note'] = 'Tag'
    hi['@text.warning'] = 'DiagnosticWarn'
    hi['@text.danger'] = 'DiagnosticError'
    hi['@tag'] = 'TSTag'
    hi['@tag.attribute'] = 'TSAttribute'
    hi['@tag.delimiter'] = 'TSTagDelimiter'

    hi['@class'] = 'TSType'
    hi['@struct'] = 'TSType'
    hi['@enum'] = 'TSType'
    hi['@enumMember'] = 'Constant'
    hi['@event'] = 'Identifier'
    hi['@interface'] = 'Structure'
    hi['@modifier'] = 'Identifier'
    hi['@regexp'] = 'TSStringRegex'
    hi['@typeParameter'] = 'Type'
    hi['@decorator'] = 'Identifier'

    hi.TreesitterContext = { guifg = nil, guibg = M.colors.base01, gui = 'italic', guisp = nil }

    -- User highlights
    hi.User1 = { guifg = M.colors.base08, guibg = M.colors.base02, gui = 'none', guisp = nil }
    hi.User2 = { guifg = M.colors.base0E, guibg = M.colors.base02, gui = 'none', guisp = nil }
    hi.User3 = { guifg = M.colors.base05, guibg = M.colors.base02, gui = 'none', guisp = nil }
    hi.User4 = { guifg = M.colors.base0C, guibg = M.colors.base02, gui = 'none', guisp = nil }
    hi.User5 = { guifg = M.colors.base05, guibg = M.colors.base02, gui = 'none', guisp = nil }
    hi.User6 = { guifg = M.colors.base05, guibg = M.colors.base01, gui = 'none', guisp = nil }
    hi.User7 = { guifg = M.colors.base05, guibg = M.colors.base02, gui = 'none', guisp = nil }
    hi.User8 = { guifg = M.colors.base00, guibg = M.colors.base02, gui = 'none', guisp = nil }
    hi.User9 = { guifg = M.colors.base00, guibg = M.colors.base02, gui = 'none', guisp = nil }

    -- Telescope 
    -- * selection
    hi.TelescopeSelection      = { guifg = M.colors.base06, guibg = M.colors.base01, gui = 'bold', guisp = nil }
    hi.TelescopeSelectionCaret = { guifg = M.colors.base09, guibg = M.colors.base01, gui= 'none', guisp = nil }
    hi.TelescopeMultiSelection = { guifg = M.colors.base0E, guibg = 'none', gui = 'italic', guisp = nil }
    hi.TelescopeMultiIcon      = { guifg = M.colors.base0E, guibg = nil, gui = 'bold', guisp = nil }
    -- * normal
    hi.TelescopeNormal         = { guifg = M.colors.base05, guibg = 'none', gui = 'none', guisp = nil }
    hi.TelescopePreviewNormal  = { guifg = M.colors.base05, guibg = 'none', gui = 'none', guisp = nil }
    hi.TelescopePromptNormal   = { guifg = M.colors.base05, guibg = 'none', gui = 'none', guisp = nil }
    hi.TelescopeResultsNormal  = { guifg = M.colors.base05, guibg = 'none', gui = 'none', guisp = nil }
    -- * border
    hi.TelescopeBorder         = { guifg = M.colors.base01, guibg = 'none', gui = nil, guisp = nil }
    hi.TelescopePromptBorder   = { guifg = M.colors.base01, guibg = 'none', gui = nil, guisp = nil }
    hi.TelescopeResultsBorder  = { guifg = M.colors.base01, guibg = 'none', gui = nil, guisp = nil }
    hi.TelescopePreviewBorder  = { guifg = M.colors.base01, guibg = 'none', gui = nil, guisp = nil }
    -- * title
    hi.TelescopeTitle          = { guifg = M.colors.base06, guibg = 'none', gui = nil, guisp = nil }
    hi.TelescopePromptTitle    = { guifg = M.colors.base06, guibg = 'none', gui = 'bold,italic,underline', guisp = M.colors.base09 }
    hi.TelescopeResultsTitle   = { guifg = M.colors.base06, guibg = 'none', gui = nil, guisp = nil }
    hi.TelescopePreviewTitle   = { guifg = M.colors.base06, guibg = 'none', gui = 'bold', guisp = nil }
    -- * prompt
    hi.TelescopePromptCounter  = { guifg = M.colors.base02, guibg = 'none', gui = 'none', guisp = nil }
    -- BUG: this highlight doesn't get applied for some reason
    hi.TelescopePromptPrefix   = { guifg = M.colors.base09, guibg = 'none', gui = 'bold', guisp = nil }
    -- * misc
    hi.TelescopeMatching       = { guifg = M.colors.base0A, guibg = nil, gui='bold,underline', guisp = M.colors.base0A }
    hi.TelescopePreviewMatch   = { guifg = M.colors.base0A, guibg = nil, gui='bold,underline', guisp = M.colors.base0A }
    hi.TelescopePreviewLine    = { guifg = nil, guibg = M.colors.base01, gui = nil, guisp = nil }
    -- 󰭎 

    -- notify
    hi.NotifyERRORBorder = { guifg = M.colors.base08, guibg = 'none', gui = 'none', guisp = nil }
    hi.NotifyWARNBorder  = { guifg = M.colors.base0E, guibg = 'none', gui = 'none', guisp = nil }
    hi.NotifyINFOBorder  = { guifg = M.colors.base01, guibg = 'none', gui = 'none', guisp = nil }
    hi.NotifyDEBUGBorder = { guifg = M.colors.base0C, guibg = 'none', gui = 'none', guisp = nil }
    hi.NotifyTRACEBorder = { guifg = M.colors.base0C, guibg = 'none', gui = 'none', guisp = nil }
    hi.NotifyERRORIcon   = { guifg = M.colors.base08, guibg = 'none', gui = 'none', guisp = nil }
    hi.NotifyWARNIcon    = { guifg = M.colors.base0E, guibg = 'none', gui = 'none', guisp = nil }
    hi.NotifyINFOIcon    = { guifg = M.colors.base05, guibg = 'none', gui = 'none', guisp = nil }
    hi.NotifyDEBUGIcon   = { guifg = M.colors.base0C, guibg = 'none', gui = 'none', guisp = nil }
    hi.NotifyTRACEIcon   = { guifg = M.colors.base0C, guibg = 'none', gui = 'none', guisp = nil }
    hi.NotifyERRORTitle  = { guifg = M.colors.base08, guibg = 'none', gui = 'none', guisp = nil }
    hi.NotifyWARNTitle   = { guifg = M.colors.base0E, guibg = 'none', gui = 'none', guisp = nil }
    hi.NotifyINFOTitle   = { guifg = M.colors.base05, guibg = 'none', gui = 'none', guisp = nil }
    hi.NotifyDEBUGTitle  = { guifg = M.colors.base0C, guibg = 'none', gui = 'none', guisp = nil }
    hi.NotifyTRACETitle  = { guifg = M.colors.base0C, guibg = 'none', gui = 'none', guisp = nil }
    hi.NotifyBackground  = { guifg = nil, guibg = M.colors.base00, gui = nil, guisp = nil }
    hi.NotifyERRORBody   = 'Normal'
    hi.NotifyWARNBody    = 'Normal'
    hi.NotifyINFOBody    = 'Normal'
    hi.NotifyDEBUGBody   = 'Normal'
    hi.NotifyTRACEBody   = 'Normal'

    -- nvim-cmp
    hi.CmpItemAbbr              = { guifg = M.colors.base05, guibg = 'none', gui = nil, guisp = nil }
    hi.CmpItemAbbrDeprecated    = { guifg = M.colors.base03, guibg = nil, gui = 'strikethrough', guisp = nil }
    hi.CmpItemAbbrMatch         = { guifg = M.colors.base0A, guibg = nil, gui = 'bold,underline', guisp = M.colors.base0A }
    hi.CmpItemAbbrMatchFuzzy    = { guifg = M.colors.base0A, guibg = nil, gui = 'bold,underline', guisp = M.colors.base0A }
    hi.CmpItemMenu              = { guifg = M.colors.base03, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindDefault       = { guifg = M.colors.base05, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindKeyword       = { guifg = M.colors.base0E, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindVariable      = { guifg = M.colors.base08, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindConstant      = { guifg = M.colors.base09, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindReference     = { guifg = M.colors.base05, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindValue         = { guifg = M.colors.base09, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindFunction      = { guifg = M.colors.base0D, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindMethod        = { guifg = M.colors.base0D, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindConstructor   = { guifg = M.colors.base0D, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindClass         = { guifg = M.colors.base0A, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindInterface     = { guifg = M.colors.base0A, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindStruct        = { guifg = M.colors.base0A, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindEvent         = { guifg = M.colors.base0A, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindEnum          = { guifg = M.colors.base0A, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindUnit          = { guifg = M.colors.base0A, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindModule        = { guifg = M.colors.base05, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindProperty      = { guifg = M.colors.base08, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindField         = { guifg = M.colors.base08, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindTypeParameter = { guifg = M.colors.base0A, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindEnumMember    = { guifg = M.colors.base0A, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindOperator      = { guifg = M.colors.base05, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindSnippet       = { guifg = M.colors.base04, guibg = nil, gui = nil, guisp = nil }
    hi.CmpItemKindText          = { guifg = M.colors.base05, guibg = nil, gui = nil, guisp = nil }

    -- vim-illuminate
    hi.IlluminatedWordText  = { guifg = nil, guibg = nil, gui = 'underline', guisp = M.colors.base04 }
    hi.IlluminatedWordRead  = { guifg = nil, guibg = nil, gui = 'underline', guisp = M.colors.base04 }
    hi.IlluminatedWordWrite = { guifg = nil, guibg = nil, gui = 'underline', guisp = M.colors.base04 }

    -- leap
    hi.LeapLabelPrimary   = { guifg = M.colors.base07, guibg = M.colors.base09, gui = 'bold', guisp = nil }
    hi.LeapLabelSecondary = { guifg = M.colors.base07, guibg = M.colors.base0F, gui = 'bold', guisp = nil }
    hi.LeapLabelSelected  = { guifg = M.colors.base07, guibg = M.colors.base02, gui = 'bold', guisp = nil }

    -- bufferline
    hi.BufferLineFileManager = { guifg = M.colors.base06, guibg = 'none', gui = 'bold,italic', guisp = nil }
    -- INFO: other bufferline highlights are set from ../plugins/ui.lua

    -- neo-tree
    hi.NeoTreeRootName     = { guifg = M.colors.base09, guibg = 'none', gui = 'bold', guisp = nil }
    hi.NeoTreeIndentMarker = { guifg = M.colors.base0F, guibg = 'none', gui = nil, guisp = nil }

    -- alpha
    hi.AlphaButtons  = { guifg = M.colors.base09, guibg = 'none', gui = 'none', guisp = nil }
    hi.AlphaShortcut = { guifg = M.colors.base0F, guibg = 'none', gui = 'italic', guisp = nil }
    hi.AlphaFooter   = { guifg = M.colors.base03, guibg = 'none', gui = 'none', guisp = nil }

    -- mini.indentscope
    hi.MiniIndentscopeSymbol    = { guifg = M.colors.base0F, guibg = nil, gui = nil, guisp = nil }
    hi.MiniIndentscopeSymbolOff = { guifg = M.colors.base08, guibg = nil, gui = nil, guisp = nil }

    -- noice
    -- TODO: setup noice highlight groups
    hi.NoiceCmdlinePopupBorder = { guifg = M.colors.base01, guibg = 'none', gui = nil, guisp = nil }
    hi.NoicePopupmenuMatch     = { guifg = M.colors.base0A, guibg = nil, gui = 'bold,underline', guisp = M.colors.base0A }
end

return M
