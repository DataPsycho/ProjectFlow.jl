"""
Internal profile checker which check if the config file exist or not.

# Argument
- `path` : File path of the profiles
"""
function profiles_exist(path::String) :: Bool
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
Invalidate the loaded properties from profiles config file.

# Argument
- `p` profiles Dict will all profiles from config file
"""
function validate_profiles(p::Dict)
    all_keys = [
        "project_root", "projects_dir", "data_dir",
        "insights_dir", "insights_viz_dir",
        "insights_data_dir",
    ]
    missing_keys = []
    for (key, value) in p
        for property in all_keys
            if !haskey(value, property)
                push!(missing_keys, property)
            end
        end
    end
    if !isempty(missing_keys)
        msg = join(missing_keys, ", ")
        err = ErrorException("$msg keys does not exist in profile.")
        throw(err)
    end
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
    path = joinpath(path, "profiles")
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
    try
        validate_profiles(all_profiles)
    catch ex
        rethrow(ex)
    end
    return all_profiles
end

"""
function select_property(path::String, name::String)

Select property of a profile from a given profile value.

# Argument
- path: Path for Profile
- name: Name of the Profile

```
Example:
const ROOT_DIR = joinpath(homedir(), ".projectflow/")
select_property(ROOT_DIR, "default")
```
"""
function select_property(path::String, name::String)
    try
        profiles = load_profiles(path)
        property = profiles[name]
        root = property["project_root"]
        property["projects_dir"] = joinpath(root, property["projects_dir"])
        property["data_dir"] = joinpath(root, property["data_dir"])
        property["insights_dir"] = joinpath(root, property["insights_dir"])
        return property
    catch ex
        rethrow(ex)
    end
end
