echo ~~Hello JJ~~
export PATH="${HOME}/Documents/shell/scripts:$PATH"
export PATH="Users/sconnie2/scripts/:$PATH"
# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/sconnie2/google-cloud-sdk/path.bash.inc' ]; then . '/Users/sconnie2/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/sconnie2/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/sconnie2/google-cloud-sdk/completion.bash.inc'; fi
