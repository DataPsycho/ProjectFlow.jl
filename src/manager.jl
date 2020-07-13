"""
function make_dir(path::String)

Check if the following directory exist or not.

# Argument
- path: Full directory path.
"""

function makedir(path::String)
    if !isdir(path)
        mkdir(path)
    end
end

"""
function setup_flow(p::Dict)

Set up the initial project flow. Execution of the function will
create datalake, insights, vizfiles and datafiles directories
in to given project roots.

# Argument
- p: A dictionary auto read by the profiler.
"""
function set_workflow(p::Dict)
    root = p["project_root"]
    projects = p["projects_dir"]
    data = p["data_dir"]
    insights = p["insights_dir"]
    try
        makedir(joinpath(root, projects))
        makedir(joinpath(root, data))
        makedir(joinpath(root, insights))
        return
    catch ex
        throw(ex)
    end
end
