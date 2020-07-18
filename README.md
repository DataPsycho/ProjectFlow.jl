# ProjectFlow

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://DataPsycho.github.io/ProjectFlow.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://DataPsycho.github.io/ProjectFlow.jl/dev)
[![Build Status](https://travis-ci.com/DataPsycho/ProjectFlow.jl.svg?branch=master)](https://travis-ci.com/DataPsycho/ProjectFlow.jl)
[![Coverage](https://codecov.io/gh/DataPsycho/ProjectFlow.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/DataPsycho/ProjectFlow.jl)


ProjectFlow is a ad-hoc analytics project manager. Upon creating a new type
`Project` and providing it to `initiate` function will crate all necessary
directory into local machine to start working on the project.

## Steps:
- First we need to create a profile which ProjectFlow will use to set up initial
directories. Profile should be stored in `/home/username/.projectflow/` directory.
inside of `.projectflow` we will create a file called `profiles` and add the
profile name and properties. Inside of priofile file should looks like this:

```
[default]
project_root=/home/datapsycho/JuliaProjects/adhocs
projects_dir=projects
data_dir=datalake
insights_dir=insights
insights_viz_dir=vizfiles
insights_data_dir=datafiles

```
The convention must be followed and all these directory map should be there.
Here it say our project root where all the projects will be created. Our raw data
will be stored in `datalake` our visuals will be stored in `insights/vizfiles`
and our post analysis report data will be stored in `insights/datafiles`.

__The Root Project folders must be created before going to next step. which is
`JuliaProjects/adhocs` in the examples.__

- Next we have to create type called project and run the `Initiate` method.
Either it will crate a new project or it will load the paths of existing
project.

```
using ProjectFlow

p = ProjectFlow.Project(
    id="xyz",
    name="My Fancy? *Project1 2 ",
    template="jl",
    profile="default"
)

datalake, iviz, idata = initiate(p)
```

The following execution will create the directories in `adhocs` directory such
as:

```
JuliaProjects/adhocs/
├── datalake
│   └── 2020-07-18_My_Fancy_Project_xyz
├── insights
│   └── 2020-07-18_My_Fancy_Project_xyz
│       ├── datafiles
│       └── vizfiles
└── projects
    └── 2020-07-18_My_Fancy_Project_xyz
        └── code.jl
```

- Inside of the code.jl there will already boiler plate code to start project.

```
# Project Name:
# Regular Imports
using ProjectFlow

p = Project(
    id="xyz",
    name="My Fancy? *Project1 2 ",
    template="jl",
    profile="default"
)

datalake, idata, iviz = initiate(p)
```

Which is the starting point of start writing adhoc dataanalytics single file
project.

_You might want to create a separate environment for whole adhocs project and
an initializer jl file  filled up with init code and use it every time
before starting a new project._


```julia
# initializer.jl file
using ProjectFlow

p = ProjectFlow.Project(
    id="xyz",
    name="My Fancy? *Project1 2 ",
    template="jl",
    profile="default"
)

datalake, iviz, idata = initiate(p)
```
