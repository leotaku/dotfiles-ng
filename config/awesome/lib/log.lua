-- Code
function log(msg)
   file = io.open("/tmp/awesome_log", "a")
   io.output(file)
   io.write(msg.."\n")
   io.output(close)
end

-- Exports
return log
