# Ensure that nix is sourced.
command -v nix >/dev/null || {
	. "$HOME"/.nix-profile/etc/profile.d/nix.sh
}