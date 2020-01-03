if grep -qE "(Microsoft|WSL)" /proc/version &>/dev/null; then
	export LANG=C
fi
