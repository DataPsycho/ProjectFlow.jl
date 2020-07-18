using ProjectFlow

println("Testing Exports !")

p = Project(
    id="xyz",
    name="My Fancy? *Project1 2 ",
    template="jl",
    profile="default"
)

datalake, iviz, idata = initiate(p);
