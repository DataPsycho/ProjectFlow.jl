using ProjectFlow
using Test

const ROOT_DIR = joinpath(homedir(), ".projectflow/profiles")
const TEST_PROPERTY = "root_dir=User/local/bin"
const A_PROFILE = Dict(
    "default" => Dict(
    "insights_viz_dir" => "vizfiles",
    "insights_data_dir" => "datafiles",
    "insights_dir" => "insights",
    )
)

@testset "Read Profiles" begin
    @testset "Reading Profiles" begin
        @test ProjectFlow.profiles_exist(ROOT_DIR)
        @test ProjectFlow.split_string(TEST_PROPERTY) == Pair("root_dir", "User/local/bin")
    end
    @testset "Profile Validation"  begin
        let err = nothing
            try
                ProjectFlow.validate_profiles(A_PROFILE)
            catch err
            end
            @test err isa Exception
        end
    end
end


@testset "File Manager Activity" begin
    @testset "ABC" begin
        @test 3 = 3
    end
end
