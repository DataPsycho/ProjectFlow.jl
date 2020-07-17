using Printf: @sprintf

const TEMPLATE_TEXT = """# Project Name:
# Regular Imports
using ProjectFlow

p = Project(
    id="\$i",
    name="\$n",
    template="\$t",
    profile="\$p"
)

datalake, idata, iviz = build(p)
"""

function str_replacer(s::String, c::String, t::String)
    text = replace(t, "\$$s" => "$c")
    return text
end

function cache_teplate():
