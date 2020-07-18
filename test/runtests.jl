using ProjectFlow
using Test

dirs = ["JuliaProjects", "adhocs"]
for dir in dirs
    fpath = joinpath(homedir(), dir)
    if !isdir()
        mkdir(fpath)
    end
end

const ROOT_DIR = joinpath(homedir(), ".projectflow/")
const TEST_PROPERTY = "root_dir=User/local/bin"
const A_BAD_PROFILE = Dict(
    "default" => Dict(
    "insights_viz_dir" => "vizfiles",
    "insights_data_dir" => "datafiles",
    "insights_dir" => "insights",
    )
)
const TEST_PROPERTIES = Dict(
    "insights_viz_dir" => "vizfiles",
    "insights_data_dir" => "datafiles",
    "insights_dir" => "insights",
    "projects_dir" => "projects",
    "data_dir" => "datalake",
    "project_root" => joinpath(homedir(), "JuliaProjects/adhocs/")
)


const A_PROJECT = ProjectFlow.Project(
    id="xyz",
    name="My Fancy? *Project1 2 ",
    template="jl",
    profile="default"
)

# Tests for Profile Loader
@testset "Read Profiles" begin
    @testset "Reading Profiles" begin
        # path = joinpath(ROOT_DIR, "profiles")
        # @test ProjectFlow.profiles_exist(path)
        @test ProjectFlow.split_string(TEST_PROPERTY) == Pair("root_dir", "User/local/bin")
    end
    @testset "Profile Validation"  begin
        let err = nothing
            try
                ProjectFlow.validate_profiles(A_BAD_PROFILE)
            catch err
            end
            @test err isa Exception
        end
    end
end

# Test for Managers
@testset "File Manager Activity" begin
    @testset "Initiate Profile from Property" begin
        @test ProjectFlow.set_workflow(TEST_PROPERTIES) == nothing
    end
end

# Test for Logger
@testset "Logger Activity" begin
    @testset "Check Project Logging" begin
        msg = "Project added to log successfully."
        meta_info = ProjectFlow.consolidate(A_PROJECT)
        @test ProjectFlow.log_project("./", meta_info) == msg
    end
end

# Test for Logger
# @testset "Module Test" begin
#     @testset "Main Module Tests" begin
#         datalake, iviz, idata = initiate(A_PROJECT)
#         @test !isempty(datalake)
#     end
# end
