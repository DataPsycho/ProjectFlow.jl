module ProjectFlow

const ROOT_DIR = joinpath(homedir(), ".projectflow/")

include("loader.jl")
include("manager.jl")
include("project.jl")
include("logger.jl")

# export Project, build

p = Project(
    id="xyz",
    name="My Fancy? *Project1 2 ",
    template="jl",
    profile="default"
)

"""
function initiate(p::Project)

This is the main function compose all other function together and
upon giving value of type project function will validate the
initialisers and create a new project or load a existing project.

#Argument
- p: value of type Project

#Example
```
p = Project(
    id="xyz",
    name="My Fancy? *Project1 2 ",
    template="jl",
    profile="default"
)
initiate(p)
```
"""
function build_load(p::Project, prp::Dict)
    properties = select_property(ROOT_DIR, p.profile)
    set_workflow(properties)
    meta_info = consolidate(p)
    name = meta_info["full_name"]
    pexist, datalake, iviz, idata = load_or_create(name, properties)
    if !pexist
        log_project("./", meta_info)
    end
    return datalake, iviz, idata
end

end # module
