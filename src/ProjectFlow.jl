module ProjectFlow

const PF_ROOT = joinpath(homedir(), ".projectflow/")

include("loader.jl")
include("manager.jl")
include("project.jl")
include("logger.jl")
include("template.jl")

export Project, initiate

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
function initiate(p::Project)
    properties = select_property(PF_ROOT, p.profile)
    set_workflow(properties)
    meta_info = consolidate(p)
    name = meta_info["full_name"]
    pexist, datalake, iviz, idata = pathfinder(name, properties)
    if !pexist
        log_project(PF_ROOT, meta_info)
        pmap = Dict(
            "i" => p.id,
            "n" => p.name,
            "t" => p.template,
            "p" => p.profile,
        )
        p = project_path(name, properties)
        save_template(p, pmap)
    end
    return datalake, iviz, idata
end

end # module
