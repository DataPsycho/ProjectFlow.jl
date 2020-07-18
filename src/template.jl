const FILENAME = "code"

const PF_TEMPLATE = """# Project Name:
# Regular Imports
using ProjectFlow

p = Project(
    id="\$i",
    name="\$n",
    template="\$t",
    profile="\$p"
)

datalake, idata, iviz = initiate(p)
"""

"""
cache_template(p::Dict, t::String)

Load the template in the memory and replace the idetifier with given value of
stirng.

# Argument
- p: map of pared values of identifier and replacer
- t: text templare to replace the identiter with value
"""
function cache_template(p::Dict, t::String)
    temp = t
    for (index, value) in p
        temp = replace(temp, "\$$index" => "$value")
    end
    return temp
end

"""
make_template(path::String, p::Dict, t::String)

Make a template based on given project info and path and save it to projrct
folder.

# Argument
- path: Path to save the cached template
- p: map of pared values of identifier and replacer
- t: text templare to replace the identiter with value
"""
function save_template(path::String, p::Dict, t=PF_TEMPLATE)
    savepath = joinpath(path, string(FILENAME, ".", p["t"]))
    temp = cache_template(p, t)
    try
        open(savepath, "w") do io
            print(io, "$temp\n")
        end
    catch ex
        throw(ex)
    end
end
