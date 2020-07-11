# ProjectFlow

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://DataPsycho.github.io/ProjectFlow.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://DataPsycho.github.io/ProjectFlow.jl/dev)
[![Build Status](https://travis-ci.com/DataPsycho/ProjectFlow.jl.svg?branch=master)](https://travis-ci.com/DataPsycho/ProjectFlow.jl)
[![Coverage](https://codecov.io/gh/DataPsycho/ProjectFlow.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/DataPsycho/ProjectFlow.jl)

*Project Has not been tested for all labels tagged here.*

ProjectFlow is a ad-hoc analytics project management tracker. Upon
giving the name, id of a new project it should load the required
configuration from `/home/username/.projectflow/profiles` and create
seperate repository for storing raw data and post analysis insights,
a `project.jl` file where we start writing code for the project and a
post analysis read me file to provide the final conclusion of the project.

It will also log the new project in to `/home/username/.projectflow/project.log` file and when creating the project.jl file it will add
the relative path for raw data and post analysis and some regular import and writer function to readme file as a template.
