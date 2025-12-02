-- colors/oldcrt.lua - Matching IntelliJ screenshot
vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "oldcrt"
vim.o.termguicolors = true
vim.o.background = "dark"

local p = {
  -- Base
  bg          = "#1A1614",   -- warm dark brown
  fg          = "#A9B7C6",   -- muted gray-blue for base text/operators
  
  -- UI
  cursor_line = "#242018",
  selection   = "#3A3028",
  line_nr     = "#6A6055",
  whitespace  = "#2A2420",
  
  -- Syntax - matched to screenshot
  keyword     = "#CC7832",   -- orange: const, async, await, if, return, new, try, catch
  variable    = "#A9B7C6",   -- gray-blue: local variables
  property    = "#9876AA",   -- purple: .env, .LOCAL_MODE, .PORT, .origins
  func        = "#FFC66D",   -- yellow: function names, method calls
  type        = "#6A8A6A",   -- muted sage: type annotations
  string      = "#6A8759",   -- olive green: strings
  number      = "#6897BB",   -- blue: numbers
  constant    = "#CC7832",   -- orange: true, false, null
  param_name  = "#8A8A8A",   -- gray: named params
  class       = "#A9C77E",   -- soft lime: class names (NestFactory, RegExp, AppModule)
  builtin     = "#8888C6",   -- soft purple-blue: built-in objects (process, console)
  
  comment     = "#5F7A5F",   -- muted sage green
  
  -- Diagnostics
  error       = "#FF3333",
  warn        = "#FFCC00",
  info        = "#66FFAA",
  hint        = "#33FF99",
}

local set = vim.api.nvim_set_hl

-- Editor UI
set(0, "Normal",        { fg = p.fg, bg = p.bg })
set(0, "NormalNC",      { fg = p.fg, bg = p.bg })
set(0, "NormalFloat",   { fg = p.fg, bg = p.bg })
set(0, "SignColumn",    { bg = p.bg })
set(0, "LineNr",        { fg = p.line_nr })
set(0, "CursorLineNr",  { fg = p.fg, bold = true })
set(0, "CursorLine",    { bg = p.cursor_line })
set(0, "CursorColumn",  { bg = p.cursor_line })
set(0, "ColorColumn",   { bg = "#242018" })
set(0, "VertSplit",     { fg = "#3A3028" })
set(0, "WinSeparator",  { fg = "#3A3028" })
set(0, "StatusLine",    { fg = p.fg, bg = "#242018" })
set(0, "StatusLineNC",  { fg = p.line_nr, bg = "#242018" })

set(0, "Pmenu",         { fg = p.fg, bg = "#201C18" })
set(0, "PmenuSel",      { fg = p.bg, bg = p.func })
set(0, "PmenuSbar",     { bg = "#201C18" })
set(0, "PmenuThumb",    { bg = "#4A4038" })

set(0, "Visual",        { fg = p.fg, bg = p.selection })
set(0, "Search",        { bg = "#335500" })
set(0, "IncSearch",     { bg = "#446600" })
set(0, "MatchParen",    { bg = "#3A3028", bold = true })

set(0, "NonText",       { fg = p.whitespace })
set(0, "Whitespace",    { fg = p.whitespace })
set(0, "SpecialKey",    { fg = p.whitespace })
set(0, "Folded",        { fg = p.fg, bg = "#242018" })
set(0, "FoldColumn",    { fg = p.line_nr, bg = p.bg })

-- Syntax
set(0, "Comment",       { fg = p.comment, italic = true })
set(0, "Constant",      { fg = p.constant })
set(0, "String",        { fg = p.string })
set(0, "Character",     { fg = p.string })
set(0, "Number",        { fg = p.number })
set(0, "Boolean",       { fg = p.constant })
set(0, "Float",         { fg = p.number })

set(0, "Identifier",    { fg = p.variable })
set(0, "Function",      { fg = p.func })

set(0, "Statement",     { fg = p.keyword })
set(0, "Conditional",   { fg = p.keyword })
set(0, "Repeat",        { fg = p.keyword })
set(0, "Label",         { fg = p.fg })
set(0, "Operator",      { fg = p.fg })
set(0, "Keyword",       { fg = p.keyword })
set(0, "Exception",     { fg = p.keyword })

set(0, "PreProc",       { fg = p.keyword })
set(0, "Include",       { fg = p.keyword })
set(0, "Define",        { fg = p.keyword })
set(0, "Macro",         { fg = p.keyword })
set(0, "PreCondit",     { fg = p.keyword })

set(0, "Type",          { fg = p.type })
set(0, "StorageClass",  { fg = p.keyword })
set(0, "Structure",     { fg = p.class })
set(0, "Typedef",       { fg = p.type })

set(0, "Special",       { fg = p.constant })
set(0, "SpecialChar",   { fg = p.string })
set(0, "Tag",           { fg = p.func })
set(0, "Delimiter",     { fg = p.fg })
set(0, "SpecialComment",{ fg = p.comment, italic = true })
set(0, "Debug",         { fg = p.warn })

set(0, "Underlined",    { fg = p.func, underline = true })
set(0, "Bold",          { bold = true })
set(0, "Italic",        { italic = true })

set(0, "Error",         { fg = p.bg, bg = p.error })
set(0, "ErrorMsg",      { fg = p.error })
set(0, "WarningMsg",    { fg = p.warn })
set(0, "ModeMsg",       { fg = p.fg })
set(0, "MoreMsg",       { fg = p.info })
set(0, "Question",      { fg = p.info })

-- Diff
set(0, "DiffAdd",       { fg = p.fg, bg = "#2A3020" })
set(0, "DiffChange",    { fg = p.fg, bg = "#3A3020" })
set(0, "DiffDelete",    { fg = "#FF5555", bg = "#3A2020" })
set(0, "DiffText",      { fg = p.bg, bg = p.func, bold = true })

-- Diagnostics
set(0, "DiagnosticError", { fg = p.error })
set(0, "DiagnosticWarn",  { fg = p.warn })
set(0, "DiagnosticInfo",  { fg = p.info })
set(0, "DiagnosticHint",  { fg = p.hint })
set(0, "DiagnosticUnderlineError", { undercurl = true, sp = p.error })
set(0, "DiagnosticUnderlineWarn",  { undercurl = true, sp = p.warn })
set(0, "DiagnosticUnderlineInfo",  { undercurl = true, sp = p.info })
set(0, "DiagnosticUnderlineHint",  { undercurl = true, sp = p.hint })

-- Git
set(0, "GitSignsAdd",    { fg = "#00DD88" })
set(0, "GitSignsChange", { fg = "#008F39" })
set(0, "GitSignsDelete", { fg = "#FF5555" })

-- Treesitter
set(0, "@comment",              { fg = p.comment, italic = true })
set(0, "@string",               { fg = p.string })
set(0, "@string.escape",        { fg = p.func })
set(0, "@string.special",       { fg = p.func })
set(0, "@character",            { fg = p.string })
set(0, "@number",               { fg = p.number })
set(0, "@boolean",              { fg = p.constant })
set(0, "@float",                { fg = p.number })

set(0, "@variable",             { fg = p.variable })           -- gray-blue
set(0, "@variable.member",      { fg = p.property })           -- purple: obj.member
set(0, "@variable.parameter",   { fg = p.variable })           -- params in definition
set(0, "@variable.builtin",     { fg = p.builtin })            -- this, self, process
set(0, "@property",             { fg = p.property })           -- purple
set(0, "@field",                { fg = p.property })           -- purple

set(0, "@function",             { fg = p.func })               -- yellow
set(0, "@function.call",        { fg = p.func })               -- yellow
set(0, "@function.method",      { fg = p.func })               -- yellow
set(0, "@function.method.call", { fg = p.func })               -- yellow
set(0, "@method",               { fg = p.func })               -- yellow
set(0, "@method.call",          { fg = p.func })               -- yellow
set(0, "@constructor",          { fg = p.class })              -- mint: new RegExp

set(0, "@keyword",              { fg = p.keyword })            -- orange
set(0, "@keyword.function",     { fg = p.keyword })            -- async, function
set(0, "@keyword.return",       { fg = p.keyword })            -- return
set(0, "@keyword.operator",     { fg = p.keyword })            -- new, typeof
set(0, "@keyword.import",       { fg = p.keyword })            -- import
set(0, "@keyword.export",       { fg = p.keyword })            -- export
set(0, "@conditional",          { fg = p.keyword })            -- if, else
set(0, "@repeat",               { fg = p.keyword })            -- for, while
set(0, "@exception",            { fg = p.keyword })            -- try, catch

set(0, "@type",                 { fg = p.type })               -- gray: type annotations
set(0, "@type.builtin",         { fg = p.type })               -- string, number, boolean
set(0, "@type.definition",      { fg = p.class })              -- interface/type name
set(0, "@class",                { fg = p.class })              -- class names
set(0, "@constant",             { fg = p.constant })           -- UPPER_CASE
set(0, "@constant.builtin",     { fg = p.constant })           -- true, false, null

set(0, "@parameter",            { fg = p.variable })
set(0, "@attribute",            { fg = p.func })               -- decorators
set(0, "@punctuation",          { fg = p.fg })
set(0, "@punctuation.bracket",  { fg = p.fg })
set(0, "@punctuation.delimiter",{ fg = p.fg })
set(0, "@punctuation.special",  { fg = p.func })               -- template literal ${}
set(0, "@operator",             { fg = p.fg })

set(0, "@tag",                  { fg = p.keyword })            -- JSX tags
set(0, "@tag.attribute",        { fg = p.property })
set(0, "@tag.delimiter",        { fg = p.fg })

-- LSP Semantic Tokens
set(0, "@lsp.type.variable",      { fg = p.variable })         -- gray-blue
set(0, "@lsp.type.property",      { fg = p.property })         -- purple
set(0, "@lsp.type.parameter",     { fg = p.variable })         -- gray-blue
set(0, "@lsp.type.function",      { fg = p.func })             -- yellow
set(0, "@lsp.type.method",        { fg = p.func })             -- yellow
set(0, "@lsp.type.type",          { fg = p.type })             -- gray
set(0, "@lsp.type.class",         { fg = p.class })            -- mint
set(0, "@lsp.type.interface",     { fg = p.type })             -- gray
set(0, "@lsp.type.enum",          { fg = p.class })
set(0, "@lsp.type.enumMember",    { fg = p.constant })
set(0, "@lsp.type.namespace",     { fg = p.class })
set(0, "@lsp.type.keyword",       { fg = p.keyword })
set(0, "@lsp.type.string",        { fg = p.string })
set(0, "@lsp.type.number",        { fg = p.number })

-- LSP modifiers
set(0, "@lsp.mod.readonly",       { })
set(0, "@lsp.mod.declaration",    { })
set(0, "@lsp.mod.local",          { })
set(0, "@lsp.mod.defaultLibrary", { })
set(0, "@lsp.mod.async",          { })

-- LSP typemod
set(0, "@lsp.typemod.variable.declaration",   { fg = p.variable })
set(0, "@lsp.typemod.variable.readonly",      { fg = p.variable })
set(0, "@lsp.typemod.variable.local",         { fg = p.variable })
set(0, "@lsp.typemod.property.declaration",   { fg = p.property })
set(0, "@lsp.typemod.parameter.declaration",  { fg = p.variable })
set(0, "@lsp.typemod.function.declaration",   { fg = p.func })
set(0, "@lsp.typemod.function.async",         { fg = p.func })
set(0, "@lsp.typemod.method.declaration",     { fg = p.func })
set(0, "@lsp.typemod.method.async",           { fg = p.func })
set(0, "@lsp.typemod.class.declaration",      { fg = p.class })

-- Telescope
set(0, "TelescopeNormal",       { fg = p.fg, bg = p.bg })
set(0, "TelescopeBorder",       { fg = "#4A4038" })
set(0, "TelescopeTitle",        { fg = p.bg, bg = p.fg, bold = true })
set(0, "TelescopeSelection",    { bg = p.selection })
set(0, "TelescopeMatching",     { fg = p.func, bold = true })

-- Completion
set(0, "CmpItemAbbr",           { fg = p.fg })
set(0, "CmpItemAbbrMatch",      { fg = p.func, bold = true })
set(0, "CmpItemAbbrMatchFuzzy", { fg = p.func, bold = true })
set(0, "CmpItemKind",           { fg = p.class })
set(0, "CmpItemMenu",           { fg = p.comment })

-- LSP references
set(0, "LspReferenceText",  { bg = "#2A2620" })
set(0, "LspReferenceRead",  { bg = "#2A2620" })
set(0, "LspReferenceWrite", { bg = "#3A3028" })

set(0, "TreesitterContext", { bg = "#201C18" })
