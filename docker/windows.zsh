if grep -qE "(Microsoft|WSL)" /proc/version &>/dev/null; then
	# Docker for Windows exposes the daemon on tcp://localhost:2375.
	# Make sure that the option is enabled in "Settings".
	export DOCKER_HOST=tcp://localhost:2375
fi
