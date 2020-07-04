using ProjectFlow
using Documenter

makedocs(;
    modules=[ProjectFlow],
    authors="Data Psycho",
    repo="https://github.com/DataPsycho/ProjectFlow.jl/blob/{commit}{path}#L{line}",
    sitename="ProjectFlow.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://DataPsycho.github.io/ProjectFlow.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/DataPsycho/ProjectFlow.jl",
)
