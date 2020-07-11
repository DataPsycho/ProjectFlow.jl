using ProjectFlow: make_dir

test_profile = Dict(
    "default" => Dict(
        "insights_viz_dir" => "vizfiles",
        "insights_data_dir" => "datafiles",
        "insights_dir" => "insights",
        "projects_dir" => "projects",
        "data_dir" => "datalake",
        "project_root" => "/home/datapsycho/JuliaProjects/"
    )
)

make_dir("/home/datapsycho/JuliaProjects/datalake")
