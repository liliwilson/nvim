local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node
local f = ls.function_node
local sn = ls.snippet_node


return {
    s("derivedebug", t("#[derive(Debug)]")),
    s({ trig = 'for', dscr = '`for _ in _` loop', priority = 5000 }, {
        t { 'for ' },
        i(1, 'pat'),
        t { ' in ' },
        i(2, 'expr'),
        t { ' {', '\t' },
        i(0),
        t { '', '}' },
    }),
    s('if', {
        t { 'if ' },
        i(1, 'expr'),
        t { ' {', '\t' },
        i(0),
        t { '', '}' },
    }),
    s('else', {
        t { 'else {', '\t' },
        i(0),
        t { '', '}' },
    }),
    s({ trig = 'match', dscr = '`match` with two matching arms.' }, {
        t { 'match ' },
        i(1, 'expr'),
        t { ' {', '\t' },
        i(2, 'Some(expr)'),
        t { ' => ' },
        i(3, 'expr'),
        t { ',', '\t' },
        i(4, 'None'),
        t { ' => ' },
        i(4, 'expr'),
        t { ',', '' },
        t { '}' },
    }),
    s({ trig = 'while-let', dscr = 'while-let' }, {
        t { 'while let ' },
        i(1, 'Some(pat)'),
        t { ' = ' },
        i(2, 'expr'),
        t { '', '' },
        t { '{', '\t' },
        i(3, 'unimplemented!();'),
        t { '', '' },
        t { '}' },
    }),
    s({ trig = 'struct', dscr = 'Classic `struct` that implements `std::fmt::Debug`' }, {
        t { '#[derive(Debug)]', '' },
        t { 'struct ' },
        i(1, 'Name'),
        t { ' {', '\t' },
        i(0),
        t { '', '' },
        t { '}', '' },
    }),
    s({ trig = 'print_with_args', dscr = '`print!("{:?}", arg)`\nFormatted `print!`' }, {
        t { 'print!("' },
        t { '{:?}", ' },
        i(1),
        t { ');' },
    }),
    s({ trig = 'fnreturn', dscr = 'Return function' }, {
        t { 'fn ' },
        i(1, 'name'),
        t { '(' },
        i(2, 'arg'),
        t { ') -> ' },
        i(3, 'ret_type'),
        t { ' {', '\t' },
        i(4, 'unimplemented!();'),
        t { '', '}' },
    }),
}
