-- dictionary-abbreviations.lua
local M = {}

function M.process_abbreviations_csv(filename)
    local file = io.open(filename, "r")
    if not file then
        tex.print("\\textbf{Error: Could not open abbreviations file: " .. filename .. "}")
        return
    end

    tex.print("\\begin{longtable}{>{\\itshape}p{2cm} p{5.5cm} p{5.5cm}}")
    tex.print("& \\textbf{Abbreviations} & \\textbf{Kratice} \\\\")
    tex.print("\\endhead")
    
    -- Table footers
    tex.print("\\multicolumn{3}{r}{\\small\\textit{Continued on next page...}} \\\\")
    tex.print("\\endfoot")
    tex.print("\\endlastfoot")

    -- Parse rows line-by-line
    for line in file:lines() do
        -- Skip empty rows or structural lines
        if line:match("%S") then
            -- Match 3 fields split by commas, accounting for basic trailing spaces
            local col0, col1, col2 = line:match("([^,]+),([^,]+),([^,]+)")
            if col0 and col1 and col2 then
                -- Strip trailing/leading spaces from strings safely
                col0 = col0:gsub("^%s*(.-)%s*$", "%1")
                col1 = col1:gsub("^%s*(.-)%s*$", "%1")
                col2 = col2:gsub("^%s*(.-)%s*$", "%1")
                
                -- Output the row safely to TeX
                tex.print(col0 .. " & " .. col1 .. " & " .. col2 .. " \\\\")
            end
        end
    end

    file:close()
    tex.print("\\end{longtable}")
end

return M

