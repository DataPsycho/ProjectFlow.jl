
const ROOT_DIR = joinpath(homedir(), ".projectflow/profiles")

function config_exist(path) :: Bool
    if isfile(path)
        return true
    end
    return false
end

function split_string(s::String)::Pair
    property = split(s, "=")
    return string(property[1]) => string(property[2])
end

function load_profiles(path) :: Dict
    all_profiles = Dict{String, Dict{String, String}}()
    if config_exist(path)
        is_header = false
        global header = ""
        for line in eachline(path)
            global header
            if occursin(r"\[\w+\]", line)
                is_header = true
                header = replace(line, r"[\[\]]" => "")
                all_profiles[header] = Dict{String, String}()
            else
                is_header = false
            end
            if !is_header && !isempty(strip(line))
                property = split_string(line)
                push!(all_profiles[header], property)
            end
        end
    else
        err = ErrorException("$path file does not exist")
        throw(err)
    end
    return all_profiles
end
