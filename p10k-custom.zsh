# Professional Powerlevel10k Configuration
# NOTE: Do NOT override LEFT/RIGHT_PROMPT_ELEMENTS here.
# Those must be set in ~/.p10k.zsh directly because p10k reload re-sources that file.

# Custom name segment styling
typeset -g POWERLEVEL9K_MY_NAME_FOREGROUND=7       # White text (for contrast)
typeset -g POWERLEVEL9K_MY_NAME_BACKGROUND=4       # Dark blue background

# Time format - 12 hour format with AM/PM (HH:MM:SS AM/PM)
typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%I:%M:%S %p}'
typeset -g POWERLEVEL9K_TIME_FOREGROUND=0          # Black
typeset -g POWERLEVEL9K_TIME_BACKGROUND=7          # Light gray/white
typeset -g POWERLEVEL9K_TIME_PREFIX='at '

# Status colors
typeset -g POWERLEVEL9K_STATUS_OK_FOREGROUND=2     # Green
typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND=1  # Red

# Git colors
typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=2     # Green
typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=3  # Yellow
typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=6 # Cyan

# Hide command execution time for fast commands
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=3
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=0
