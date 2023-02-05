OsuFileReader = {}

function OsuFileReader.getInfo(filepath)
    file = io.open(filepath, "r")
    if file then
        -- Read the entire file into a string
        content = file:read("all")

        -- Extract the beatmap information
        beatmap_info = {}
        i = 0
        for line in string.gmatch(content, "[^\n]+") do
            beatmap_info[i] = line
            i = i + 1
        end
    file:close()
    return beatmap_info
    else
        return {}
    end
end
