local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node
local f = ls.function_node
local sn = ls.snippet_node

return {
    s("todo", {
        t("- [ ] "), i(1, "Task description")
    }),
    s("link", {
        t("["), i(1, "text"), t("]("), i(2, "url"), t(")")
    }),
    s("linkpaste", { -- paste link from clipboard
        t("["),
        i(1, "link"),
        t("]("),
        d(2, function()
            return sn(nil, i(1, vim.fn.getreg("+")))
        end, {}),
        t(")"),
    }),
    s("code", {
        t("```"),
        i(1, "language"),
        t({ "", "" }),
        i(2, "code"),
        t({ "", "```" })
    }),
    s("table", {
        t("| a | b | c |"),
        t({ "", "| ------------- |-------------  | ------- |", "" }),
        t("| d | e | f |"),
    }),
    s("article", {
        t("- [ ] "),
        t("["),
        i(1, "article"),
        t("]("),
        d(2, function()
            local clip = vim.fn.getreg("+")

            if clip:find("\n") or clip == nil then
                return sn(nil, i(1, "link"))
            end

            return sn(nil, i(1, clip))
        end, {}),
        t(") - "),
        d(3, function()
            local date = os.date("%B %d, %Y")
            return sn(nil, i(1, date))
        end, {}),

    }),
}
