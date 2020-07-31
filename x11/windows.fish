if grep --ignore-case "microsoft" /proc/version &> /dev/null
    if not type -f /.dockerenv > /dev/null 2>&1
        set --export DISPLAY localhost:0.0
    end
end
