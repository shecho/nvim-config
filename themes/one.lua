return {
  "rakr/vim-one",
  priority = 2000, -- make sure to load this before all the other start plugins
  -- lazy = false,
  config = function()
    vim.cmd([[
        " if (has("autocmd") && !has("gui_running"))
        "     augroup highlightYankedText
        "     autocmd!
        "     autocmd TextYankPost *  silent! lua require'vim.highlight'.on_yank()
        "     augroup END
        "
        " endif
        let g:onedark_terminal_italics=1
        let g:onedark_termcolors=256
        let g:one_termcolors=256
        let g:one_allow_italics = 1
        syntax on
        " colorscheme onedark
        " call one#highlight('NonText', '828997', '000000', 'bold')"
        " call one#highlight('Whitespace', '828997', '000000', 'standout')
        call one#highlight('Cursor', '', '', 'standout')
        call one#highlight('CursorLine', '', '', 'bolditalic')
        " call one#highlight('CursorIM', '', '', 'bolditalic')"
        " call one#highlight('CursorLineNr', '', '', 'bolditalic')"
        " call one#highlight('LineNr', '', '', 'bolditalic')"
        " call one#highlight('Define', '', '000000', 'bolditalic')
        call one#highlight('Directory', '', '', 'bold')
        call one#highlight('Visual', '', '', 'bolditalic')
        call one#highlight('TabLine', '', '', 'bold')
        " call one#highlight('Search', '', '', 'bolditalic')
        " call one#highlight('IncSearch', '', '', 'bolditalic,standout')
        call one#highlight('Sttement', '', '', 'bold')
        call one#highlight('CursorColumn', '828997', '', 'standout')" word #4b5263 #5c6370  5c6370 #828997 #abb2bf  abb2bf
        " call one#highlight('normal', 'abb2bf', '282C34', 'bold')
        " call one#highlight('SpecialChar', '', '', 'bold,standout')
        " call one#highlight('Character', '', '', 'bold')
        " call one#highlight('@character', '', '', 'bold')
        " call one#highlight('Include', 'c678dd', '000000', 'italic')
        " call one#highlight('Float', '', '', 'bold'
        call one#highlight('Number', '', '', 'bold')
        call one#highlight('Delimiter','abb2bf', '', 'bold')"brackets () {} []
        call one#highlight('MatchParen', '', '', 'underline,bold')
        call one#highlight('normalfloat', '', '282C34', 'bold')
        call one#highlight('String', '', '', 'bold')
        call one#highlight('Repeat', '', '','italic')"
        call one#highlight('Type', '', '', 'bold')
        call one#highlight('Boolean', '', '', 'bolditalic')
        call one#highlight('Conditional', 'B243E6', '', 'italic')
        " call one#highlight('Special', '', '', 'bold')
        call one#highlight('@variable.builtin', 'd19a66', '', 'bold')
        call one#highlight('@variable.member', 'e06c75', '', 'bold')
        call one#highlight('@variable.parameter', 'e06c75', '', 'bold')
        call one#highlight('@variable', 'abb2bf', '', 'bold')
        " call one#highlight('@none', '', '', 'bold')
        " call one#highlight('@text', '', '000000', 'bold')
        " call one#highlight('@variable', '', '', 'bold')"
        " call one#highlight('@identifier', 'abb2bf', '', 'bold,standout')"
        " call one#highlight('@attribute', '', '000000', 'bold')
        " call one#highlight('Tag', 'B243E6', '000000', 'bold')
        call one#highlight('@Tag', 'e5c07b', '', 'bold') " #e5c07b
        call one#highlight('@Tag.delimiter', 'abb2bf', '', 'bold,') " #B243E6 #abb2bf
        call one#highlight('@Tag.attribute', 'd19a66', '', 'italic') " #B243E6 #d19a66
        call one#highlight('@Constant', 'e5c07b', '', 'bold')
        call one#highlight('@constant.builtin', 'c678dd', '', 'bold') " #c678dd
        call one#highlight('@Keyword', 'c678dd', '', 'italic')"reserved words
        call one#highlight('@keyword.function', '528bff', '', 'bolditalic')
        " call one#highlight('@keyword.conditional', '', '000000', 'italic')
        call one#highlight('@keyword.directive', '', '', 'italic')
        " call one#highlight('@keyword.exception', '', '000000', 'italic')
        " call one#highlight('@keyword.import', '', '000000', 'italic')
        " call one#highlight('@keyword.operator', '', '000000', 'italic')
        " call one#highlight('@keyword.repeat', '', '000000', 'italic')
        " call one#highlight('@Parameter', '', '000000', 'bolditalic,')"params abd arguments and variables names
        " call one#highlight('@Parameter.reference', '', '528bff', 'bolditalic,')"params abd arguments and variables names
        call one#highlight('@method', '526fff', '', 'italic') "  #526fff
        call one#highlight('@property', 'e06c75', '', 'italic') " #
        call one#highlight('@type.definition', '', '', 'bolditalic')
        call one#highlight('Asynchronous', '', '', 'italic')
        call one#highlight('Exception', '', '', 'italic') " try catch
        call one#highlight('StorageClass', '', '','bolditalic')" #B243E6 #8a3fa0  #7e3992  #c678dd #282C34 #abb2bf  #181a1f #282c34 #31353f #393f4a  #3b3f4c  #0e1013  #151820
        call one#highlight('Error', 'be5046', '', 'bolditalic')" #e06c75 #be5046 #e45649 #ca1243 #c18401 #e5c07b #d19a66 #56B6C2 #61afef #528bff #4078f2 #526fff
        call one#highlight('ErrorMsg', 'e06c75', '', 'bold')
        call one#highlight('DiagnosticVirtualTextError', 'e06c75', '', 'bolditalic')
        call one#highlight('DiagnosticError', 'e06c75', '', 'bolditalic')
        call one#highlight('DiagnosticFloatingError', 'e06c75', '', 'bolditalic')
        call one#highlight('DiagnosticSignError', 'e06c75', '', 'bolditalic')
        call one#highlight('DiagnosticUnderlineError', 'e06c75', '', 'bolditalic,underline')
        call one#highlight('@operator', 'c678dd', '', '')" *= - + =>'
        " call one#highlight('@punctuation.bracket', '', '', 'bold')" *= - + =>
        " call one#highlight('@Punctuation.delimiter', '', '', 'bold')
        " call one#highlight('@punctuation.delimiter', 'c678dd', '', 'bold')" *= - + =>'
        " call one#highlight('Operator', '', '000000', '')" *= - + =>'
        " call one#highlight('@function', '61afef', '', 'bold')"
        call one#highlight('@function.method', '528bff', '', 'bolditalic')"
        call one#highlight('@function.builtin', '7e3992', '', 'bolditalic')"
        call one#highlight('@function.macro', '7e3992', '', 'bolditalic')"
        call one#highlight('@text.uri', '', '', 'bolditalic,underline')"
        call one#highlight('@lsp.type.typeParameter', '828997', '', '')
        " --------------------------------------------------------------
            " \	    'guifgs': ['#858580', '#8fbcbb', '#d08770', '#a3be8c', '#ebcb8b', '#b48ead', '#80a880', '#887070'],
        " call one#highlight('RainbowDelimiterRed', 'e06c75', '', 'bold')
        " call one#highlight('RainbowDelimiterBlue', '8fbcbb', '', 'bold')
        " call one#highlight('RainbowDelimiterOrange', 'd08770', '', 'bold')
        " call one#highlight('RainbowDelimiterGreen', 'a3be8c', '', 'bold')
        " call one#highlight('RainbowDelimiterViolet', 'b48ead', '', 'bold')
        " call one#highlight('RainbowDelimiterCyan', '528bff', '', 'bold')
        " call one#highlight('RainbowDelimiterYellow', 'ebcb8b', '', 'bold')
        " call one#highlight('RainbowDelimiterYellow', 'ebcb8b', '', 'bold')
        call one#highlight('ExtraWhitespace', 'e06c75', 'ca1243', 'bold')
        "
      ]])
  end,
}
