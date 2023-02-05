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

function OsuFileReader.getPosOfHits(table)
    for i, v in ipairs(table) do
        if string.find(v, "HitObjects") then
            return i
        end
    end
    return -1
end

function OsuFileReader.split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

function OsuFileReader.getHits(filename)
    file = OsuFileReader.getInfo(filename)
    pos = OsuFileReader.getPosOfHits(file)
    hits = {}
    for i = pos + 1, #file do
        hitInfo = OsuFileReader.split(file[i], ",")
        hit = {}
        hit.x = hitInfo[1]
        hit.y = hitInfo[2]
        hit.time = hitInfo[3]
        table.insert(hits, hit)
    end
    return hits
end

function OsuFileReader.load(filename)
    map = OsuFileReader.getHits(filename)
end
