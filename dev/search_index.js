var documenterSearchIndex = {"docs":
[{"location":"","page":"Home","title":"Home","text":"CurrentModule = ProjectFlow","category":"page"},{"location":"#ProjectFlow","page":"Home","title":"ProjectFlow","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"ProjectFlow is a ad-hoc analytics project manager. Upon creating a new type Project and providing it to initiate function will crate all necessary directory into local machine to start working on the project.","category":"page"},{"location":"#Steps:","page":"Home","title":"Steps:","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"First we need to create a profile which ProjectFlow will use to set up initial","category":"page"},{"location":"","page":"Home","title":"Home","text":"directories. Profile should be stored in /home/username/.projectflow/ directory. inside of .projectflow we will create a file called profiles and add the profile name and properties. Inside of priofile file should looks like this:","category":"page"},{"location":"","page":"Home","title":"Home","text":"[default]\nproject_root=/home/datapsycho/JuliaProjects/adhocs\nprojects_dir=projects\ndata_dir=datalake\ninsights_dir=insights\ninsights_viz_dir=vizfiles\ninsights_data_dir=datafiles\n","category":"page"},{"location":"","page":"Home","title":"Home","text":"The convention must be followed and all these directory map should be there. Here it say our project root where all the projects will be created. Our raw data will be stored in datalake our visuals will be stored in insights/vizfiles and our post analysis report data will be stored in insights/datafiles.","category":"page"},{"location":"","page":"Home","title":"Home","text":"The Root Project folders must be created before going to next step. which is JuliaProjects/adhocs in the examples.","category":"page"},{"location":"","page":"Home","title":"Home","text":"Next we have to create type called project and run the Initiate method.","category":"page"},{"location":"","page":"Home","title":"Home","text":"Either it will crate a new project or it will load the paths of existing project.","category":"page"},{"location":"","page":"Home","title":"Home","text":"using ProjectFlow\n\np = ProjectFlow.Project(\n    id=\"xyz\",\n    name=\"My Fancy? *Project1 2 \",\n    template=\"jl\",\n    profile=\"default\"\n)\n\ndatalake, iviz, idata = initiate(p)","category":"page"},{"location":"","page":"Home","title":"Home","text":"The following execution will create the directories in adhocs directory such as:","category":"page"},{"location":"","page":"Home","title":"Home","text":"JuliaProjects/adhocs/\n├── datalake\n│   └── 2020-07-18_My_Fancy_Project_xyz\n├── insights\n│   └── 2020-07-18_My_Fancy_Project_xyz\n│       ├── datafiles\n│       └── vizfiles\n└── projects\n    └── 2020-07-18_My_Fancy_Project_xyz\n        └── code.jl","category":"page"},{"location":"","page":"Home","title":"Home","text":"Inside of the code.jl there will already boiler plate code to start project.","category":"page"},{"location":"","page":"Home","title":"Home","text":"# Project Name:\n# Regular Imports\nusing ProjectFlow\n\np = Project(\n    id=\"xyz\",\n    name=\"My Fancy? *Project1 2 \",\n    template=\"jl\",\n    profile=\"default\"\n)\n\ndatalake, idata, iviz = initiate(p)","category":"page"},{"location":"","page":"Home","title":"Home","text":"Which is the starting point of start writing adhoc dataanalytics single file project.","category":"page"},{"location":"","page":"Home","title":"Home","text":"You might want to create a separate environment for whole adhocs project and an initializer jl file  filled up with init code and use it every time before starting a new project.","category":"page"},{"location":"","page":"Home","title":"Home","text":"# initializer.jl file\nusing ProjectFlow\n\np = ProjectFlow.Project(\n    id=\"xyz\",\n    name=\"My Fancy? *Project1 2 \",\n    template=\"jl\",\n    profile=\"default\"\n)\n\ndatalake, iviz, idata = initiate(p)","category":"page"},{"location":"#Internal-Methods-Index","page":"Home","title":"Internal Methods Index","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [ProjectFlow]","category":"page"},{"location":"#ProjectFlow.Project","page":"Home","title":"ProjectFlow.Project","text":"Immutable type Project. Project hold:\n\nUnique Project Id\nProject name\nTemplate extention jl tocreate .jl file, in future will have option for .ipynb notebook\nThe profile to use when creating projects, the default value is default\n\n\n\n\n\n","category":"type"},{"location":"#ProjectFlow.cache_template-Tuple{Dict,String}","page":"Home","title":"ProjectFlow.cache_template","text":"cache_template(p::Dict, t::String)\n\nLoad the template in the memory and replace the idetifier with given value of stirng.\n\nArgument\n\np: map of pared values of identifier and replacer\nt: text templare to replace the identiter with value\n\n\n\n\n\n","category":"method"},{"location":"#ProjectFlow.clean_name-Tuple{String}","page":"Home","title":"ProjectFlow.clean_name","text":"function clean_name(s::String)\n\nTake a strign remove spacial character from the string\n\nArgument\n\ns: String to remove special character\n\nExample:\n\nclean_name(\"Here is < 12 ?\")\n\n\n\n\n\n","category":"method"},{"location":"#ProjectFlow.consolidate-Tuple{Project}","page":"Home","title":"ProjectFlow.consolidate","text":"consolidate(p::Project)\n\nConsolidate a value of type project and return a Dict object with cleaned project name and newly added attribute.\n\n#Arguemnt\n\np: Value of type project\n\nExample\n\nA_PROJECT = ProjectFlow.Project(\n    id=\"xyz\",\n    name=\"My Fancy? *Project1 2 \",\n    template=\"jl\",\n    profile=\"pycharm\"\n)\nconsolidate(A_PROJECT)\n\n\n\n\n\n","category":"method"},{"location":"#ProjectFlow.initiate-Tuple{Project}","page":"Home","title":"ProjectFlow.initiate","text":"function initiate(p::Project)\n\nThis is the main function compose all other function together and upon giving value of type project function will validate the initialisers and create a new project or load a existing project.\n\nArgument\n\np: value of type Project\n\nExample\n\np = Project(\n    id=\"xyz\",\n    name=\"My Fancy? *Project1 2 \",\n    template=\"jl\",\n    profile=\"default\"\n)\ninitiate(p)\n\n\n\n\n\n","category":"method"},{"location":"#ProjectFlow.isexist-Tuple{Array{String,N} where N,String}","page":"Home","title":"ProjectFlow.isexist","text":"isexist(m::Array{String}, pid::String)\n\nInternal function to check if a project already exist with the same name with a given profile\n\nArgument\n\nm: Array of string with all the path to check.\npid: Project id and Project name as string\n\n\n\n\n\n","category":"method"},{"location":"#ProjectFlow.load_profiles-Tuple{String}","page":"Home","title":"ProjectFlow.load_profiles","text":"Load the profiles from the users profile setup file.\n\nArgument\n\nPath of profile file.\n\nExample\n\nconst ROOT_DIR = joinpath(homedir(), \".projectflow/profiles\")\nprofiles = load_profiles(ROOT_DIR)\n\n\n\n\n\n","category":"method"},{"location":"#ProjectFlow.log_project-Tuple{String,Dict}","page":"Home","title":"ProjectFlow.log_project","text":"Log a project after consolidation to the given project.\n\nArgument\n\npath: path of the log file.\nprj: The consolidated project dictionary\n\n\n\n\n\n","category":"method"},{"location":"#ProjectFlow.pathfinder-Tuple{Dict,Dict}","page":"Home","title":"ProjectFlow.pathfinder","text":"Take new porject fullname and profile path. create a new project if the project does not exist or load the path of the project if the project already exist.\n\nArgument\n\nmeta: Project Metadata after Consolidation\nprf: loaded profile\n\nreturn if the project exist as true/false and all relevant path.\n\n\n\n\n\n","category":"method"},{"location":"#ProjectFlow.profiles_exist-Tuple{String}","page":"Home","title":"ProjectFlow.profiles_exist","text":"Internal profile checker which check if the config file exist or not.\n\nArgument\n\npath : File path of the profiles\n\n\n\n\n\n","category":"method"},{"location":"#ProjectFlow.save_template","page":"Home","title":"ProjectFlow.save_template","text":"make_template(path::String, p::Dict, t::String)\n\nMake a template based on given project info and path and save it to projrct folder.\n\nArgument\n\npath: Path to save the cached template\np: map of pared values of identifier and replacer\nt: text templare to replace the identiter with value\n\n\n\n\n\n","category":"function"},{"location":"#ProjectFlow.select_property-Tuple{String,String}","page":"Home","title":"ProjectFlow.select_property","text":"function select_property(path::String, name::String)\n\nSelect property of a profile from a given profile value.\n\nArgument\n\npath: Path for Profile\nname: Name of the Profile\n\nExample:\nconst ROOT_DIR = joinpath(homedir(), \".projectflow/\")\nselect_property(ROOT_DIR, \"default\")\n\n\n\n\n\n","category":"method"},{"location":"#ProjectFlow.set_workflow-Tuple{Dict}","page":"Home","title":"ProjectFlow.set_workflow","text":"function setup_flow(p::Dict)\n\nSet up the initial project flow. Execution of the function will create datalake, insights, vizfiles and datafiles directories in to given project roots.\n\nArgument\n\np: A dictionary auto read by the profiler.\n\n\n\n\n\n","category":"method"},{"location":"#ProjectFlow.split_string-Tuple{String}","page":"Home","title":"ProjectFlow.split_string","text":"Split profile strings in to property to add in to dict collection.\n\nArgument\n\nproperty string with signature key=pair\n\nExample\n\nsplit_string(\"repo=my_beautiful_repo\")\n\n\n\n\n\n","category":"method"},{"location":"#ProjectFlow.validate-Tuple{Project}","page":"Home","title":"ProjectFlow.validate","text":"validate(p::Project)\n\nvalidate a given value of type project.\n\n#Arguemnt\n\np: Value of type project\n\nExample\n\nA_PROJECT = ProjectFlow.Project(\n    id=\"xyz\",\n    name=\"My Fancy? *Project1 2 \",\n    template=\"jl\",\n    profile=\"pycharm\"\n)\nvalidate(A_PROJECT)\n\n\n\n\n\n","category":"method"},{"location":"#ProjectFlow.validate_profiles-Tuple{Dict}","page":"Home","title":"ProjectFlow.validate_profiles","text":"Invalidate the loaded properties from profiles config file.\n\nArgument\n\np profiles Dict will all profiles from config file\n\n\n\n\n\n","category":"method"},{"location":"#ProjectFlow.write_append-Tuple{String,String}","page":"Home","title":"ProjectFlow.write_append","text":"write_append(path::String, content::String)\n\nCreate the file if not exist. If exist write to file.\n\nArgument\n\npath: path to write file\ncontent: The content to write in the file\n\n\n\n\n\n","category":"method"}]
}
