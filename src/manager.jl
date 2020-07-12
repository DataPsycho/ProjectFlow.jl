test_profile = Dict(
    "default" => Dict(
        "insights_viz_dir" => "vizfiles",
        "insights_data_dir" => "datafiles",
        "insights_dir" => "insights",
        "projects_dir" => "projects",
        "data_dir" => "datalake",
        "project_root" => "/home/datapsycho/JuliaProjects/adhocs/"
    )
)

"""
function make_dir(path::String)

Check if the following directory exist or not.

# Argument
- path: Full directory path.
"""

function make_dir(path::String)
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
function set_workflow(p::Dict, profile::String)
    properties = p[profile]
    root = properties["project_root"]
    projects = properties["projects_dir"]
    data = properties["data_dir"]
    insights = properties["insights_dir"]
    try
        make_dir(joinpath(root, projects))
        make_dir(joinpath(root, data))
        make_dir(joinpath(root, insights))
    catch ex
        throw(ex)
    end
end
