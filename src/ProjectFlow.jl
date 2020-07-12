module ProjectFlow

const ROOT_DIR = joinpath(homedir(), ".projectflow/profiles")

include("utils.jl")
include("profiler.jl")
include("manager.jl")

function build(p::Project)
    try
        validate(p)
    catch ex
        rethrow(ex)
    end
    metainfo = consolidate(p)

end

end # module
