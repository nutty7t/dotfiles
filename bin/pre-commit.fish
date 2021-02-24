#!/usr/bin/env fish

function encrypted
    grep -q "sops" $argv
end

set secrets (find . -type f -wholename "*/secrets/*")
for secret in $secrets
		if not encrypted $secret
			 echo "$secret is not encrypted"
			 false
		end
end
