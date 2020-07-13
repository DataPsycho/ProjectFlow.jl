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

function log_project(path::String, prj::Project)
    log_file = "projects.log"
    log_path = joinpath(path, log_file)
    p = consolidate(prj)
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
