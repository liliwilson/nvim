return {
    "f-person/git-blame.nvim",
    event = "BufReadPre",
    config = function()
        -- Customize the blame message format
        vim.g.gitblame_message_template = "<author> • <date> • <summary>"

        -- Set highlight group for blame text
        vim.g.gitblame_highlight_group = "Comment"

        -- Date format (use %r for relative time like "2 hours ago")
        vim.g.gitblame_date_format = "%r"
    end,
}
