highScore = {}

function highScore.load()
    file_descriptor = io.open("score.save", "r")
    if (file_descriptor == nil) then
        file_descriptor = io.open("score.save", "w")
        file_descriptor:write("0 0 0")
        file_descriptor:close()
        file_descriptor = io.open("score.save", "r")
    end
    content = file_descriptor:read()
    highScore = {}
    for num in string.gmatch(content, "%d+") do
      table.insert(highScore, tonumber(num))
    end
    file_descriptor:close()
end
