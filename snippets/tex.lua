local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

--- Return amount of indent specified
---@param lv number Indent level
---@param str string Indent string
---@return string Indent string
local function indent(lv, str)
    local ret = string.rep("\t", lv)
    return ret .. str
end

--- Create the graphics content node
---@param lv number Indent level
---@return table
local graphics_content = function(jl, lv)
    return sn(jl, {
        t({ indent(lv, "\\centering") }),
        c(1, {
            sn(nil, {
                t({ "", indent(lv, "\\includegraphics[width=") }),
                i(1, "0.8"),
                t("\\textwidth]{./img/"),
                i(2, "image.png"),
                t("}"),
            }),
            sn(nil, {
                t({ "", indent(lv, "\\resizebox{") }),
                i(1, "0.8"),
                t("\\textwidth}{!}{\\input{./schem/"),
                i(2, "schematic.tex"),
                t("}}"),
            }),
        }, { restore_cursor = true }),
        t({ "", indent(lv, "\\caption{"), indent(lv + 1, "") }),
        i(2, "Caption"),
        t({ "", indent(lv, "}\\label{") }),
        i(3, "label"),
        t("}"),
    })
end

return {
    s({ trig = "fig", name = "Figure (standard or subfigure)" }, {
        c(1, {
            sn(0, {
                t({ "\\begin{figure}", "" }),
                graphics_content(1, 1),
                t({ "", "\\end{figure}" }),
            }),
            sn(0, {
                t({ "\\begin{figure}", "" }),
                t(indent(1, "\\begin{subfigure}{")),
                i(0, "0.9"),
                t({ "\\textwidth}", "" }),
                graphics_content(1, 2),
                t({ "", indent(1, "\\end{subfigure}") }),
                t({ "", "", "\t\\vskip\\baselineskip", "", "" }),
                t(indent(1, "\\begin{subfigure}{")),
                i(0, "0.9"),
                t({ "\\textwidth}", "" }),
                graphics_content(2, 2),
                t({ "", indent(1, "\\end{subfigure}") }),
                t({ "", "\\end{figure}" }),
            }),
        }, { restore_cursor = true }),
    }),
}
