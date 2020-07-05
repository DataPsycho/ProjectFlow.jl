
const MY_ROOT = joinpath(homedir(), ".projectflow/config")

function config_exist() :: Bool
    if isfile(MY_ROOT)
        return true
    end
    return false
end

function load_config()
    all_config = Dict{String, Dict{String, String}}
    if config_exist()
        for item in eachline(MY_ROOT)
            println(typeof(item))
            end
        end
    end
end

load_config()
