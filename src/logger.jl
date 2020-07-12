using ProjectFlow: Project, consolidate, ROOT_DIR

function write_append(p::String, c::String)
    msg = "Project added to log successfully 😃!"
    if !isfile(p)
        open(p, "w") do io
            print(io, "$c\n")
        end
        return print(msg)
    end
    open(p, "a") do io
        print(io, "$c\n")
    end
    return println(msg)
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
        write_append(log_path, metainfo)
    catch ex
        throw(ex)
    end
end
