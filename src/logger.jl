"""
write_append(path::String, content::String)

Create the file if not exist. If exist write to file.

#Argument
- path: path to write file
- content: The content to write in the file
"""
function write_append(path::String, content::String)
    msg = "Project added to log successfully."
    if !isfile(path)
        open(path, "w") do io
            print(io, "$content\n")
        end
        return msg
    end
    open(path, "a") do io
        print(io, "$content\n")
    end
    return msg
end

"""
Log a project after consolidation to the given project.

#Argument
- path: path of the log file.
- prj: The consolidated project dictionary
"""
function log_project(path::String, pj::Dict)
    log_file = "projects.log"
    log_path = joinpath(path, log_file)
    metainfo = (
        "$(pj["uid"])\t$(pj["name"])\t$(pj["full_name"])\t"
        *"$(pj["created_date"])\t$(pj["profile"])"
    )
    try
        msg = write_append(log_path, metainfo)
        println(msg)
        return msg
    catch ex
        throw(ex)
    end
end
