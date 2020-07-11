
"""
function make_dir(path::String)

Check if the following directory exist or not.

# Argument
- path: Full directory path.
"""

function make_dir(path::String)
    if !isdir(path)
        mkdir(path)
    end
end
