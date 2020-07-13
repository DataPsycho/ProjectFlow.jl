module ProjectFlow

const ROOT_DIR = joinpath(homedir(), ".projectflow/")

include("loader.jl")
include("manager.jl")
include("project.jl")
include("logger.jl")

p = Project(
    id="xyz",
    name="My Fancy? *Project1 2 ",
    template="jl",
    profile="default"
)


function build(p::Project, prp::Dict)
    properties = select_property(ROOT_DIR, p.profile)
    set_workflow(properties)
    meta_info = consolidate(p)
    name = meta_info["full_name"]
    p_exist, datalake, iviz, idata = load_or_create(name, properties)
    if !exist
        log_project("./", p)
    end
    return datalake, iviz, idata
end

end # module
