using Dates
const CODEFILES_EXT = ["jl"]

"""
Immutable type Project. Project hold:
- Unique Project Id
- Project name
- Template extention jl tocreate .jl file, in future will have option for .ipynb notebook
- The profile to use when creating projects, the default value is `default`
"""
struct Project
    id::String
    name::String
    template::String
    profile::String

    Project(; id="", name="", template="", profile="default") = new(
        id, name, template, profile
    )
    Project(id, name, template, profile) = new(
        id, name, template, profile
    )
end

"""
function clean_name(s::String)

Take a strign remove spacial character from the string

# Argument
- s: String to remove special character

# Example:
```
clean_name("Here is < 12 ?")
```
"""
function clean_name(s::String)
    return replace(s, r"[^a-zA-Z]+" => " ") |> strip
end

"""
validate(p::Project)

validate a given value of type project.

#Arguemnt
- p: Value of type project

# Example
```
A_PROJECT = ProjectFlow.Project(
    id="xyz",
    name="My Fancy? *Project1 2 ",
    template="jl",
    profile="pycharm"
)
validate(A_PROJECT)
```
"""
function validate(p::Project)
    issues = []
    if isempty(p.id)
        push!(issues, "Project id should be unique and can not be empty")
    end
    if p.name |> clean_name |> strip |> split |> length < 3
        push!(issues,
            ("Project name mush have atleast 3 words; "
             *"excluding numbers and spacial character")
        )
    end
    if p.template ∉ CODEFILES_EXT
        push!(issues, "Only $(join(CODEFILES_EXT, ",")) is allowed as template parameter")
    end
    if !isempty(issues)
        msg = join(issues, ", \n")
        err = ErrorException("Could not validate Project: $msg")
        throw(err)
    end
end

"""
consolidate(p::Project)

Consolidate a value of type project and return a Dict object
with cleaned project name and newly added attribute.

#Arguemnt
- p: Value of type project

# Example
```
A_PROJECT = ProjectFlow.Project(
    id="xyz",
    name="My Fancy? *Project1 2 ",
    template="jl",
    profile="pycharm"
)
consolidate(A_PROJECT)
```
"""
function consolidate(p::Project)
    try
        validate(p)
    catch ex
        rethrow(ex)
    end
    date_today = today()
    cleaned_name = p.name |> clean_name
    name_array =  cleaned_name |> strip |> split
    combined = join(name_array[1:3], "_")
    new_name = "$(date_today)_$(combined)_$(p.id)"
    unique_index = "$(combined)_$(p.id)"
    metainfo = Dict(
        "uid" => p.id,
        "uidx" => unique_index,
        "name" => cleaned_name,
        "full_name" => new_name,
        "created_date" => string(date_today),
        "profile" => p.profile
    )
    return metainfo
end

"""
    isexist(m::Array{String}, pid::String)
Internal function to check if a project already exist with the
same name with a given profile

# Argument
- m: Array of string with all the path to check.
- pid: Project id and Project name as string
"""
function isexist(m::Array{String}, uidx::String)
    msg = []
    old_uidx = ""
    for path in m
        all_files = readdir(path)
        for file in all_files
            if occursin(uidx, file)
                old_uidx = file
                push!(msg, (
                    "Project already exist at $path. "
                    *"Loading the paths."
                    )
                )
            end
        end
    end
    if length(msg) > 0
        str_msg = join(msg, "\n")
        println(str_msg)
        return true, old_uidx
    end
    return false, nothing
end


"""
Take new porject fullname and profile path. create a new
project if the project does not exist or load the path of
the project if the project already exist.

# Argument
- meta: Project Metadata after Consolidation
- prf: loaded profile

return if the project exist as true/false and all relevant
path.
"""
function pathfinder(meta::Dict, prf::Dict)
    # n name of the project
    project_id = meta["uidx"]
    check_list = [
        prf["projects_dir"],
        prf["insights_dir"],
        prf["data_dir"]
    ]

    proj_exist, old_name = isexist(check_list, project_id)
    if proj_exist
        iviz_dir = joinpath(prf["insights_dir"], old_name, prf["insights_viz_dir"])
        idata_dir = joinpath(prf["insights_dir"], old_name, prf["insights_data_dir"])
        datalake = joinpath(prf["data_dir"], old_name)
        # empty string as projectpath
        return true, "", datalake, iviz_dir, idata_dir
    end
    new_name = meta["full_name"]
    project = joinpath(prf["projects_dir"], new_name)
    datalake = joinpath(prf["data_dir"], new_name)
    insights = joinpath(prf["insights_dir"], new_name)
    meta_array = [project, datalake, insights]
    iviz_dir = joinpath(insights, prf["insights_viz_dir"])
    idata_dir = joinpath(insights, prf["insights_data_dir"])
    push!(meta_array, iviz_dir, idata_dir)
    try
        for path in meta_array
            mkdir(path)
        end
        println("Project created at $project")
        return false, project, datalake, iviz_dir, idata_dir
    catch ex
        throw(ex)
    end
end
