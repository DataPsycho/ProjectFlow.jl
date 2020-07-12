module ProjectFlow

const ROOT_DIR = joinpath(homedir(), ".projectflow/profiles")

include("loader.jl")
include("manager.jl")
include("project.jl")
include("logger.jl")

function build(p::Project)
    try
        validate(p)
    catch ex
        rethrow(ex)
    end
    metainfo = consolidate(p)

end

end # module
