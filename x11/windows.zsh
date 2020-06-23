if grep -qE "(Microsoft|WSL)" /proc/version &>/dev/null; then
	# Make sure to install VcXsrv.
	export DISPLAY=localhost:0.0
fi
