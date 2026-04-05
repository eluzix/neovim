-- colors/pastelnight.lua - Dark background with colorful pastel syntax
vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "yuvi"
vim.o.termguicolors = true
vim.o.background = "dark"

local p = {
  -- Base
  bg          = "#1a1414",   -- dark peach-black
  fg          = "#d4c5c0",   -- soft warm gray

  -- UI
  cursor_line = "#241c1c",
  selection   = "#352828",
  line_nr     = "#5a4540",
  whitespace  = "#2a2020",
  border      = "#4a3838",
  float_bg    = "#1e1818",

  -- Pastel Syntax (max variation girly palette)
  keyword     = "#f2a6c8",   -- pastel pink: keywords, control flow
  variable    = "#d4c5d0",   -- soft rose-gray: local variables
  property    = "#f5b8a8",   -- pastel salmon: properties, fields
  func        = "#eed680",   -- pastel sunshine: functions, methods
  type        = "#88d4e8",   -- pastel ocean: types, interfaces
  string      = "#a8e0a0",   -- pastel lime: strings
  number      = "#f0a880",   -- pastel tangerine: numbers
  constant    = "#e87878",   -- pastel cherry: true, false, null
  class       = "#b8a0f0",   -- pastel iris: class/struct names
  builtin     = "#e090c8",   -- pastel magenta: builtins (self, this)
  param       = "#d0e0a0",   -- pastel pistachio: parameters
  operator    = "#80d8d0",   -- pastel teal: operators
  decorator   = "#f0a0a0",   -- pastel strawberry: decorators/attributes
  escape      = "#e8d088",   -- pastel honey: string escapes
  tag         = "#f08888",   -- pastel red: JSX/HTML tags

  comment     = "#6a5560",   -- muted mauve

  -- Diagnostics
  error       = "#e898a8",   -- pastel coral
  warn        = "#f0d0a0",   -- pastel apricot
  info        = "#c9a0e8",   -- pastel lavender
  hint        = "#f2a6c8",   -- pastel pink

  -- Git
  git_add     = "#f2a6c8",
  git_change  = "#f5c49a",
  git_delete  = "#e898a8",
}

local set = vim.api.nvim_set_hl

-- Editor UI
set(0, "Normal",        { fg = p.fg, bg = p.bg })
set(0, "NormalNC",      { fg = p.fg, bg = p.bg })
set(0, "NormalFloat",   { fg = p.fg, bg = p.float_bg })
set(0, "FloatBorder",   { fg = p.border, bg = p.float_bg })
set(0, "FloatTitle",    { fg = p.func, bg = p.float_bg, bold = true })
set(0, "SignColumn",    { bg = p.bg })
set(0, "LineNr",        { fg = p.line_nr })
set(0, "CursorLineNr",  { fg = p.func, bold = true })
set(0, "CursorLine",    { bg = p.cursor_line })
set(0, "CursorColumn",  { bg = p.cursor_line })
set(0, "ColorColumn",   { bg = "#241c1c" })
set(0, "VertSplit",     { fg = p.border })
set(0, "WinSeparator",  { fg = p.border })
set(0, "StatusLine",    { fg = p.fg, bg = "#241c1c" })
set(0, "StatusLineNC",  { fg = p.line_nr, bg = "#241c1c" })
set(0, "TabLine",       { fg = p.line_nr, bg = "#241c1c" })
set(0, "TabLineFill",   { bg = "#241c1c" })
set(0, "TabLineSel",    { fg = p.fg, bg = p.bg, bold = true })
set(0, "WinBar",        { fg = p.fg, bg = p.bg, bold = true })
set(0, "WinBarNC",      { fg = p.line_nr, bg = p.bg })

set(0, "Pmenu",         { fg = p.fg, bg = p.float_bg })
set(0, "PmenuSel",      { fg = p.bg, bg = p.func })
set(0, "PmenuSbar",     { bg = p.float_bg })
set(0, "PmenuThumb",    { bg = p.border })

set(0, "Visual",        { bg = p.selection })
set(0, "Search",        { fg = p.bg, bg = p.escape })
set(0, "IncSearch",     { fg = p.bg, bg = p.func })
set(0, "CurSearch",     { fg = p.bg, bg = p.decorator })
set(0, "Substitute",    { fg = p.bg, bg = p.tag })
set(0, "MatchParen",    { fg = p.escape, bg = p.selection, bold = true })

set(0, "NonText",       { fg = p.whitespace })
set(0, "Whitespace",    { fg = p.whitespace })
set(0, "SpecialKey",    { fg = p.whitespace })
set(0, "Folded",        { fg = p.comment, bg = "#241c1c" })
set(0, "FoldColumn",    { fg = p.line_nr, bg = p.bg })
set(0, "EndOfBuffer",   { fg = p.bg })
set(0, "Title",         { fg = p.class, bold = true })
set(0, "Directory",     { fg = p.class })

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
set(0, "Label",         { fg = p.keyword })
set(0, "Operator",      { fg = p.operator })
set(0, "Keyword",       { fg = p.keyword })
set(0, "Exception",     { fg = p.keyword })

set(0, "PreProc",       { fg = p.keyword })
set(0, "Include",       { fg = p.keyword })
set(0, "Define",        { fg = p.keyword })
set(0, "Macro",         { fg = p.decorator })
set(0, "PreCondit",     { fg = p.keyword })

set(0, "Type",          { fg = p.type })
set(0, "StorageClass",  { fg = p.keyword })
set(0, "Structure",     { fg = p.class })
set(0, "Typedef",       { fg = p.type })

set(0, "Special",       { fg = p.escape })
set(0, "SpecialChar",   { fg = p.escape })
set(0, "Tag",           { fg = p.tag })
set(0, "Delimiter",     { fg = p.fg })
set(0, "SpecialComment",{ fg = p.comment, italic = true, bold = true })
set(0, "Debug",         { fg = p.warn })

set(0, "Underlined",    { fg = p.class, underline = true })
set(0, "Bold",          { bold = true })
set(0, "Italic",        { italic = true })

set(0, "Error",         { fg = p.bg, bg = p.error })
set(0, "ErrorMsg",      { fg = p.error })
set(0, "WarningMsg",    { fg = p.warn })
set(0, "ModeMsg",       { fg = p.fg, bold = true })
set(0, "MoreMsg",       { fg = p.func })
set(0, "Question",      { fg = p.func })
set(0, "Todo",          { fg = p.bg, bg = p.escape, bold = true })

-- Diff
set(0, "DiffAdd",       { bg = "#1e2a1e" })
set(0, "DiffChange",    { bg = "#2a2518" })
set(0, "DiffDelete",    { fg = p.git_delete, bg = "#2a1818" })
set(0, "DiffText",      { fg = p.bg, bg = p.property, bold = true })
set(0, "Added",         { fg = p.git_add })
set(0, "Changed",       { fg = p.git_change })
set(0, "Removed",       { fg = p.git_delete })

-- Diagnostics
set(0, "DiagnosticError", { fg = p.error })
set(0, "DiagnosticWarn",  { fg = p.warn })
set(0, "DiagnosticInfo",  { fg = p.info })
set(0, "DiagnosticHint",  { fg = p.hint })
set(0, "DiagnosticUnderlineError", { undercurl = true, sp = p.error })
set(0, "DiagnosticUnderlineWarn",  { undercurl = true, sp = p.warn })
set(0, "DiagnosticUnderlineInfo",  { undercurl = true, sp = p.info })
set(0, "DiagnosticUnderlineHint",  { undercurl = true, sp = p.hint })
set(0, "DiagnosticVirtualTextError", { fg = p.error, bg = "#2a1818" })
set(0, "DiagnosticVirtualTextWarn",  { fg = p.warn, bg = "#2a2518" })
set(0, "DiagnosticVirtualTextInfo",  { fg = p.info, bg = "#1a2028" })
set(0, "DiagnosticVirtualTextHint",  { fg = p.hint, bg = "#1e2a1e" })

-- Git Signs
set(0, "GitSignsAdd",    { fg = p.git_add })
set(0, "GitSignsChange", { fg = p.git_change })
set(0, "GitSignsDelete", { fg = p.git_delete })

-- Treesitter
set(0, "@comment",              { fg = p.comment, italic = true })
set(0, "@string",               { fg = p.string })
set(0, "@string.escape",        { fg = p.escape })
set(0, "@string.special",       { fg = p.escape })
set(0, "@string.regex",         { fg = p.tag })
set(0, "@character",            { fg = p.string })
set(0, "@number",               { fg = p.number })
set(0, "@boolean",              { fg = p.constant })
set(0, "@float",                { fg = p.number })

set(0, "@variable",             { fg = p.variable })
set(0, "@variable.member",      { fg = p.property })
set(0, "@variable.parameter",   { fg = p.param })
set(0, "@variable.builtin",     { fg = p.builtin, italic = true })
set(0, "@property",             { fg = p.property })
set(0, "@field",                { fg = p.property })

set(0, "@function",             { fg = p.func })
set(0, "@function.call",        { fg = p.func })
set(0, "@function.method",      { fg = p.func })
set(0, "@function.method.call", { fg = p.func })
set(0, "@function.builtin",     { fg = p.func, italic = true })
set(0, "@method",               { fg = p.func })
set(0, "@method.call",          { fg = p.func })
set(0, "@constructor",          { fg = p.class })

set(0, "@keyword",              { fg = p.keyword })
set(0, "@keyword.function",     { fg = p.keyword })
set(0, "@keyword.return",       { fg = p.keyword })
set(0, "@keyword.operator",     { fg = p.keyword })
set(0, "@keyword.import",       { fg = p.keyword })
set(0, "@keyword.export",       { fg = p.keyword })
set(0, "@keyword.coroutine",    { fg = p.keyword, italic = true })
set(0, "@keyword.conditional",  { fg = p.keyword })
set(0, "@keyword.repeat",       { fg = p.keyword })
set(0, "@keyword.exception",    { fg = p.keyword })
set(0, "@conditional",          { fg = p.keyword })
set(0, "@repeat",               { fg = p.keyword })
set(0, "@exception",            { fg = p.keyword })

set(0, "@type",                 { fg = p.type })
set(0, "@type.builtin",         { fg = p.type, italic = true })
set(0, "@type.definition",      { fg = p.class })
set(0, "@class",                { fg = p.class })
set(0, "@constant",             { fg = p.constant })
set(0, "@constant.builtin",     { fg = p.constant, italic = true })
set(0, "@constant.macro",       { fg = p.decorator })

set(0, "@parameter",            { fg = p.param })
set(0, "@attribute",            { fg = p.decorator })
set(0, "@attribute.builtin",    { fg = p.decorator, italic = true })
set(0, "@punctuation",          { fg = p.fg })
set(0, "@punctuation.bracket",  { fg = p.fg })
set(0, "@punctuation.delimiter",{ fg = p.fg })
set(0, "@punctuation.special",  { fg = p.operator })
set(0, "@operator",             { fg = p.operator })
set(0, "@module",               { fg = p.class })

set(0, "@tag",                  { fg = p.tag })
set(0, "@tag.attribute",        { fg = p.property, italic = true })
set(0, "@tag.delimiter",        { fg = p.fg })
set(0, "@tag.builtin",          { fg = p.tag, italic = true })

-- Markup (markdown, etc.)
set(0, "@markup.heading",       { fg = p.class, bold = true })
set(0, "@markup.strong",        { bold = true })
set(0, "@markup.italic",        { italic = true })
set(0, "@markup.strikethrough", { strikethrough = true })
set(0, "@markup.link",          { fg = p.class, underline = true })
set(0, "@markup.link.url",      { fg = p.type, underline = true })
set(0, "@markup.raw",           { fg = p.string })
set(0, "@markup.list",          { fg = p.operator })

-- LSP Semantic Tokens
set(0, "@lsp.type.variable",      { fg = p.variable })
set(0, "@lsp.type.property",      { fg = p.property })
set(0, "@lsp.type.parameter",     { fg = p.param })
set(0, "@lsp.type.function",      { fg = p.func })
set(0, "@lsp.type.method",        { fg = p.func })
set(0, "@lsp.type.type",          { fg = p.type })
set(0, "@lsp.type.class",         { fg = p.class })
set(0, "@lsp.type.interface",     { fg = p.type })
set(0, "@lsp.type.enum",          { fg = p.class })
set(0, "@lsp.type.enumMember",    { fg = p.constant })
set(0, "@lsp.type.namespace",     { fg = p.class })
set(0, "@lsp.type.keyword",       { fg = p.keyword })
set(0, "@lsp.type.string",        { fg = p.string })
set(0, "@lsp.type.number",        { fg = p.number })
set(0, "@lsp.type.decorator",     { fg = p.decorator })
set(0, "@lsp.type.macro",         { fg = p.decorator })

-- LSP modifiers
set(0, "@lsp.mod.readonly",       { })
set(0, "@lsp.mod.declaration",    { })
set(0, "@lsp.mod.local",          { })
set(0, "@lsp.mod.defaultLibrary", { })
set(0, "@lsp.mod.async",          { })
set(0, "@lsp.mod.deprecated",     { strikethrough = true })

-- LSP typemod
set(0, "@lsp.typemod.variable.declaration",   { fg = p.variable })
set(0, "@lsp.typemod.variable.readonly",      { fg = p.variable })
set(0, "@lsp.typemod.variable.local",         { fg = p.variable })
set(0, "@lsp.typemod.property.declaration",   { fg = p.property })
set(0, "@lsp.typemod.parameter.declaration",  { fg = p.param })
set(0, "@lsp.typemod.function.declaration",   { fg = p.func })
set(0, "@lsp.typemod.function.async",         { fg = p.func })
set(0, "@lsp.typemod.method.declaration",     { fg = p.func })
set(0, "@lsp.typemod.method.async",           { fg = p.func })
set(0, "@lsp.typemod.class.declaration",      { fg = p.class })

-- Telescope
set(0, "TelescopeNormal",       { fg = p.fg, bg = p.float_bg })
set(0, "TelescopeBorder",       { fg = p.border, bg = p.float_bg })
set(0, "TelescopeTitle",        { fg = p.bg, bg = p.func, bold = true })
set(0, "TelescopeSelection",    { bg = p.selection })
set(0, "TelescopeSelectionCaret", { fg = p.func })
set(0, "TelescopeMatching",     { fg = p.escape, bold = true })
set(0, "TelescopePromptNormal", { fg = p.fg, bg = p.float_bg })
set(0, "TelescopePromptBorder", { fg = p.border, bg = p.float_bg })
set(0, "TelescopePromptTitle",  { fg = p.bg, bg = p.keyword, bold = true })
set(0, "TelescopePromptPrefix", { fg = p.keyword })

-- Completion (nvim-cmp / blink)
set(0, "CmpItemAbbr",           { fg = p.fg })
set(0, "CmpItemAbbrMatch",      { fg = p.func, bold = true })
set(0, "CmpItemAbbrMatchFuzzy", { fg = p.func, bold = true })
set(0, "CmpItemAbbrDeprecated", { fg = p.comment, strikethrough = true })
set(0, "CmpItemKind",           { fg = p.class })
set(0, "CmpItemMenu",           { fg = p.comment })
set(0, "CmpItemKindFunction",   { fg = p.func })
set(0, "CmpItemKindMethod",     { fg = p.func })
set(0, "CmpItemKindVariable",   { fg = p.variable })
set(0, "CmpItemKindKeyword",    { fg = p.keyword })
set(0, "CmpItemKindClass",      { fg = p.class })
set(0, "CmpItemKindInterface",  { fg = p.type })
set(0, "CmpItemKindProperty",   { fg = p.property })
set(0, "CmpItemKindField",      { fg = p.property })
set(0, "CmpItemKindConstant",   { fg = p.constant })
set(0, "CmpItemKindSnippet",    { fg = p.decorator })
set(0, "CmpItemKindModule",     { fg = p.class })
set(0, "CmpItemKindText",       { fg = p.fg })
set(0, "CmpItemKindEnum",       { fg = p.class })
set(0, "CmpItemKindValue",      { fg = p.number })
set(0, "CmpItemKindStruct",     { fg = p.class })

-- LSP references
set(0, "LspReferenceText",  { bg = "#2a2020" })
set(0, "LspReferenceRead",  { bg = "#2a2020" })
set(0, "LspReferenceWrite", { bg = "#352828" })

-- Indent guides
set(0, "IndentBlanklineChar",        { fg = "#2a2020" })
set(0, "IblIndent",                  { fg = "#2a2020" })
set(0, "IblScope",                   { fg = p.border })

-- Treesitter context
set(0, "TreesitterContext",          { bg = "#241c1c" })
set(0, "TreesitterContextLineNumber",{ fg = p.line_nr, bg = "#241c1c" })

-- Lazy.nvim
set(0, "LazyButton",       { fg = p.fg, bg = "#241c1c" })
set(0, "LazyButtonActive",  { fg = p.bg, bg = p.func })
set(0, "LazyH1",            { fg = p.bg, bg = p.func, bold = true })

-- Which-key
set(0, "WhichKey",          { fg = p.func })
set(0, "WhichKeyGroup",     { fg = p.keyword })
set(0, "WhichKeySeparator", { fg = p.comment })
set(0, "WhichKeyDesc",      { fg = p.fg })
set(0, "WhichKeyValue",     { fg = p.comment })

-- Notify
set(0, "NotifyERRORBorder", { fg = p.error })
set(0, "NotifyWARNBorder",  { fg = p.warn })
set(0, "NotifyINFOBorder",  { fg = p.info })
set(0, "NotifyDEBUGBorder", { fg = p.comment })
set(0, "NotifyTRACEBorder", { fg = p.keyword })
set(0, "NotifyERRORTitle",  { fg = p.error })
set(0, "NotifyWARNTitle",   { fg = p.warn })
set(0, "NotifyINFOTitle",   { fg = p.info })
set(0, "NotifyDEBUGTitle",  { fg = p.comment })
set(0, "NotifyTRACETitle",  { fg = p.keyword })
set(0, "NotifyERRORIcon",   { fg = p.error })
set(0, "NotifyWARNIcon",    { fg = p.warn })
set(0, "NotifyINFOIcon",    { fg = p.info })
set(0, "NotifyDEBUGIcon",   { fg = p.comment })
set(0, "NotifyTRACEIcon",   { fg = p.keyword })
