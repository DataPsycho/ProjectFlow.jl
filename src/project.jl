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


a_project = Project(
    id="xyz",
    name="My Fancy? *Project1 2 ",
    template="jl",
    profile="pycharm"
)

# wrong_project = Project(
#     id="",
#     name="Santa",
#     template="kj"
# )

function clean_name(s::String)
    return replace(s, r"[^a-zA-Z]+" => " ")
end

function validate(p::Project)
    issues = []
    if isempty(p.id)
        push!(issues, "Prouect id should be unique and can not be empty")
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
