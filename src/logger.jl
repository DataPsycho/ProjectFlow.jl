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
function log_project(path::String, prj::Dict)
    log_file = "projects.log"
    log_path = joinpath(path, log_file)
    metainfo = (
        "$(p["uid"])\t$(p["name"])\t$(p["full_name"])\t"
        *"$(p["created_date"])\t$(p["profile"])"
    )
    try
        msg = write_append(log_path, metainfo)
        print(msg)
        return msg
    catch ex
        throw(ex)
    end
end
