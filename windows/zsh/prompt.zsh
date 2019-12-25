# ──────────────────────────────────────────────────────────────────────
#  Spaceship Prompt.
# ──────────────────────────────────────────────────────────────────────

fpath=("${HOME}/.zfunctions" ${fpath})
autoload -U promptinit; promptinit
prompt spaceship

SPACESHIP_CHAR_SYMBOL=":: "
SPACESHIP_PROMPT_ORDER=(
	nix
	dir
	char
)

# ──────────────────────────────────────────────────────────────────────
#  Nix Shell.
# ──────────────────────────────────────────────────────────────────────

spaceship_nix() {
	# Precondition: The `nix` section is enabled.
	[[ $SPACESHIP_NIX_SHELL_SHOW == false ]] && return

	# Precondition: We are in a nix-shell.
	[[ -z $IN_NIX_SHELL ]] && return

	echo -n "%{%F{green}%}"
	if grep -qE "(Microsoft|WSL)" /proc/version &>/dev/null; then
		# HACK: For whatever reason, at least in the terminal
		# emulators on Windows, it seems as if zsh uses the
		# number of bytes in the UTF-8 representation of Unicode
		# characters to determine their widths. This causes
		# wonky formatting, so I'm using zsh escape sequences to
		# manually specify the width of the characters.
		echo -n "\xCE%{\xBB%} "
	else
		echo -n "λ "
	fi
	echo -n "%{%f%}"

	# Invoked using `nix-shell -p [packages]`
	if [[ -n ${NIX_SHELL_PACKAGES} ]]; then
		local packageNames=""
		local packages=(${NIX_SHELL_PACKAGES})

		# Output package names. This list can get long.
		# If it seems too long, the user should consider
		# putting this inside of a Nix expression.
		echo -n "[ "
		for package in ${packages}; do
			echo -n "${package} "
		done
		echo -n "] "

	# Otherwise, invoked using nix expression file.
	else
		local cleanName=${name#interactive-}
		cleanName=${cleanName%-environment}
		echo -n "${cleanName} "
	fi

	# Print suffix.
	echo -n "%{%F{green}%}"
	if grep -qE "(Microsoft|WSL)" /proc/version &>/dev/null; then
		echo -n "\xE2%{\x86\x92%} "
	else
		echo -n "→ "
	fi
	echo -n "%{%f%}"
}
