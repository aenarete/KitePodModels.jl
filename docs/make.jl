using KitePodSimulator
using Documenter

DocMeta.setdocmeta!(KitePodSimulator, :DocTestSetup, :(using KitePodSimulator); recursive=true)

makedocs(;
    modules=[KitePodSimulator],
    authors="Uwe Fechner <fechner@aenarete.eu> and contributors",
    repo="https://github.com/ufechner7/KitePodSimulator.jl/blob/{commit}{path}#{line}",
    sitename="KitePodSimulator.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://ufechner7.github.io/KitePodSimulator.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/ufechner7/KitePodSimulator.jl",
    devbranch="main",
)
