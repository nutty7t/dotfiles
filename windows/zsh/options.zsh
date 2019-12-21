# See `http://zsh.sourceforge.net/Doc/Release/Options.html`.

# ──────────────────────────────────────────────────────────────────────
#  16.2.1 Changing Directories
# ──────────────────────────────────────────────────────────────────────

# If a command is issued that can't be executed as a normal command, and
# the command is the name of a directory, perform the `cd` command to
# that directory.
setopt auto_cd

# Make `cd` push the old directory onto the directory stack.
# Use `popd` to pop directories off of the stack.
setopt auto_pushd

# Don't push multiple copies of the same directory to the stack.
setopt pushd_ignore_dups

# If the argument to a `cd` command (or an implied `cd` with the
# `AUTO_CD` option set) is not a directory, and does not begin with a
# slash, try to expand the expression as if it were preceded by a `~`.
setopt cdable_vars

# ──────────────────────────────────────────────────────────────────────
#  16.2.2 Completion
# ──────────────────────────────────────────────────────────────────────

# Enable menu-style autocompletion.
zstyle ':completion:*' menu select

# Shift+Tab to go backwards in menu.
bindkey '^[[Z' reverse-menu-complete

# If a completion is performed with the cursor within a word, and a full
# completion is inserted, the cursor is moved to the end of the word.
setopt always_to_end

# Automatically list choices on an ambiguous completion.
setopt auto_list

# Automatically use menu completion after the second consecutive request
# for completion, for example by pressing the tab key repeatedly.
setopt auto_menu

# If unset, the cursor is set to the end of the word if completion is
# started. Otherwise it stays there and completion is done from both
# ends.
setopt complete_in_word

# ──────────────────────────────────────────────────────────────────────
#  16.2.3 Expansion and Globbing
# ──────────────────────────────────────────────────────────────────────

# Treat the `#`, `~` and `^` characters as part of patterns for filename
# generation, etc.
setopt extended_glob

# ──────────────────────────────────────────────────────────────────────
#  16.2.4 Extended History
# ──────────────────────────────────────────────────────────────────────

# Save each command’s beginning timestamp (in seconds since the epoch)
# and the duration (in seconds) to the history file.
setopt extended_history

# ──────────────────────────────────────────────────────────────────────
#  16.2.6 Input/Output
# ──────────────────────────────────────────────────────────────────────

# Allow comments -- even in interactive shells.
setopt interactive_comments
