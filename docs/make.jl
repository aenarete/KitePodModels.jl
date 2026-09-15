using KitePodModels
using Documenter

DocMeta.setdocmeta!(KitePodModels, :DocTestSetup, :(using KitePodModels); recursive=true)

makedocs(;
    modules=[KitePodModels],
    authors="Uwe Fechner <fechner@aenarete.eu> and contributors",
    repo="https://github.com/OpenSourceAWE/KitePodModels.jl/blob/{commit}{path}#{line}",
    sitename="KitePodModels.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://OpenSourceAWE.github.io/KitePodModels.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Types" => "types.md",
        "Functions" => "functions.md",
        "Parameters" => "parameters.md",
    ],
)

deploydocs(;
    repo="github.com/OpenSourceAWE/KitePodModels.jl",
    devbranch="main",
)
