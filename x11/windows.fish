if grep --ignore-case "microsoft" /proc/version &> /dev/null
    if not type -f /.dockerenv > /dev/null 2>&1
        set --export DISPLAY (cat /etc/resolv.conf | grep nameserver | awk '{ print $2 }'):0.0
        set --export LANG C
    end
end