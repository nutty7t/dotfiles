function fish_prompt
	echo
	nix_shell_prompt

	set_color green
	printf '%s' (prompt_pwd)
	set_color normal

	set_color blue
	printf ' :: '
	set_color normal
end

function nix_shell_prompt
	if not set --query IN_NIX_SHELL
		return
	end

	# pure or impure shell?
	set_color blue
	if test (string length 'λ') = 1
			printf 'λ'
			if test $IN_NIX_SHELL = 'pure'
				printf 'ₚ'
			end
			printf ' '
	else
		printf '[%s] ' $IN_NIX_SHELL
	end
	set_color normal

	# invoked with specified packages or a derivation?
	set_color red
	if test $name = 'shell'
		printf '{ %s }' (printPackageNames $buildInputs)
	else
		printf '%s' $name
	end
	set_color normal

	set_color blue
	printf ' -> '
	set_color normal
end

function printPackageNames
	set pattern '(?<=/nix/store/[a-z0-9]{32}-).*(?=-[0-9\.]+)'
	set packages (echo $argv | string split ' ' | grep -oP $pattern | string join ' ')
	printf '%s' $packages
end
