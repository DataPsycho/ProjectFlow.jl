const ROOT_DIR = joinpath(homedir(), ".projectflow/profiles")

<<<<<<< HEAD
function profiles_exist(path) :: Bool
=======
"""
Internal profile checker which check if the config file exist or not.

# Argument
- `path` : File path of the profiles
"""
function config_exist(path::String) :: Bool
>>>>>>> 4c2520247be31dc8e4fd690ec98804b9f1b06547
    if isfile(path)
        return true
    end
    return false
end

"""
Split profile strings in to property to add in to dict collection.

# Argument
- property string with signature key=pair

# Example
```
split_string("repo=my_beautiful_repo")
```
"""
function split_string(s::String)::Pair
    property = split(s, "=")
    return string(property[1]) => string(property[2])
end

"""
Load the profiles from the users profile setup file.

# Argument
- Path of profile file.

# Example

```
const ROOT_DIR = joinpath(homedir(), ".projectflow/profiles")
profiles = load_profiles(ROOT_DIR)
```
"""
function load_profiles(path::String)::Dict
    all_profiles = Dict{String, Dict{String, String}}()
    if profiles_exist(path)
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
