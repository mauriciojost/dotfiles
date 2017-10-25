
##################### 
### Explore files


# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# Some more ls aliases
alias l='ls -lhtr --time-style="+%Y-%m-%d %H:%M"'
alias ll='ls -lahtr --time-style="+%Y-%m-%d %H:%M"'
alias la='ls -A'

##################### 
### FIND

function qfind-by-name () {
	qassertnotempty "$1" "Arguments: <filename-pattern-to-look-for>"
	find . -name "$1" | xargs -I% readlink -e % 
}

function qgrep-in-all-files() {
	qassertnotempty "$1" "Arguments: <pattern-to-look-for>"
	grep --line-number -R "$1" .
}

function qgrep-in-all-files-case-non-sensitive() {
	qassertnotempty "$1" "Arguments: <pattern-to-look-for>"
	grep --line-number -R -i "$1" .
}

# Grep with context (showing 5 lines above and 5 lines below the match).
alias qgrep-with-context='grep -C 5'


# Grep with context (showing 5 lines above and 5 lines below the match).
alias qgrep-with-context='grep -C 5'
# Grep with context (showing 5 lines above and 5 lines below the match).

# Highlight with different colors some results
alias qhl='highlight green'
alias qhl2='highlight red'
alias qhl3='highlight yellow'
