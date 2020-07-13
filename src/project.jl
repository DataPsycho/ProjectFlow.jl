using Dates
const TEMPLATE = ["jl"]

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

function clean_name(s::String)
    return replace(s, r"[^a-zA-Z]+" => " ")
end

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
    if p.template ∉ TEMPLATE
        push!(issues, "Only $(join(TEMPLATE, ",")) is allowed as template parameter")
    end
    if !isempty(issues)
        msg = join(issues, ", \n")
        err = ErrorException("Could not validate Project: $msg")
        throw(err)
    end
end


function consolidate(p::Project)
    date_today = today()
    cleaned_name = p.name |> clean_name
    name_array =  cleaned_name |> strip |> split
    combined = join(name_array[1:3], "_")
    new_name = "$(date_today)_$(combined)_$(p.id)"
    metainfo = Dict(
        "uid" => p.id,
        "name" => cleaned_name,
        "full_name" => new_name,
        "created_date" => string(date_today),
        "profile" => p.profile
    )
    return metainfo
end

function isexist(m::Array{String})
    msg = []
    for path in m
        if isdir(path)
            push!(msg, (
                "Project already exist at $path. "
                *"Loading the paths."
                )
            )
        end
    end
    if length(msg) > 0
        str_msg = join(msg, "\n")
        println(str_msg)
        return true
    end
    return false
end

function load_or_create(n::String, prf::Dict)
    i_viz_dir = ""
    i_data_dir = ""
    root = prf["project_root"]
    projects = joinpath(root, prf["projects_dir"], n)
    datalake = joinpath(root, prf["data_dir"], n)
    insights = joinpath(root, prf["insights_dir"], n)
    meta_array = [projects, datalake, insights]
    iviz_dir = joinpath(insights, prf["insights_viz_dir"])
    idata_dir = joinpath(insights, prf["insights_data_dir"])
    if isexist(meta_array)
        return true, datalake, iviz_dir, idata_dir
    end
    push!(meta_array, iviz_dir, idata_dir)
    try
        for path in meta_array
            mkdir(path)
        end
        return false, datalake, iviz_dir, idata_dir
    catch ex
        throw(ex)
    end
end
