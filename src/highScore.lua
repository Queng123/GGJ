highScore = {}

function highScore.load()
    file_descriptor = io.open("save/score", "r")
    content = file_descriptor:read()
    highScore = {}
    for num in string.gmatch(content, "%d+") do
      table.insert(highScore, tonumber(num))
    end
    file_descriptor:close()
end
