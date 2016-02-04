# SET PATH

	# set PATH so it includes user's private bin if it exists
	if [ -d "$HOME/bin" ] ; then
	    PATH="$HOME/bin:$PATH"
	fi
	
# SET NVM DIR	
		
	export NVM_DIR="/home/vagrant/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm	

# VAGRANT HELPERS

	alias home='cd /home'
	alias vagrant='cd /vagrant'
	alias app=vagrant
	alias vagrant-shared='cd /home/vagrant-shared'
	alias shared=vagrant-shared
	alias xx=exit

	alias ns='npm start'
	alias nd='npm dev'

# COLORS

	# Tell ls to be colourful
	export CLICOLOR=1
	
	# Tell grep to highlight matches
	export GREP_OPTIONS='--color=auto'
	
# COLOR ALIASES

	export COLOR_RESET='\[\e[0m\]' # No Color
	export COLOR_WHITE='\[\e[1;37m\]'
	export COLOR_BLACK='\[\e[0;30m\]'
	export COLOR_BLUE='\[\e[0;34m\]'
	export COLOR_LIGHT_BLUE='\[\e[1;34m\]'
	export COLOR_GREEN='\[\e[0;32m\]'
	export COLOR_LIGHT_GREEN='\[\e[1;32m\]'
	export COLOR_CYAN='\[\e[0;36m\]'
	export COLOR_LIGHT_CYAN='\[\e[1;36m\]'
	export COLOR_RED='\[\e[0;31m\]'
	export COLOR_LIGHT_RED='\[\e[1;31m\]'
	export COLOR_PURPLE='\[\e[0;35m\]'
	export COLOR_LIGHT_PURPLE='\[\e[1;35m\]'
	export COLOR_BROWN='\[\e[0;33m\]'
	export COLOR_YELLOW='\[\e[1;33m\]'
	export COLOR_GRAY='\[\e[0;30m\]'
	export COLOR_LIGHT_GRAY='\[\e[0;37m\]'	

# PROMPT

	#source /home/vagrant-shared/dotfiles/lib/git-prompt.sh
	#source /home/vagrant-shared/dotfiles/lib/git-completion.bash
	
	export COMPUTERNAME="\h"
	export TITLEBAR="\[\e]2;\u@${COMPUTERNAME}\a\]"
	
	# GIT STATUS
	function __git_color() {				
		git_status="`git status -unormal 2>&1`"
		
		# IF THIS IS A REPO
	    if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
	    	# IF WE ARE BEHIND
	    	if [[ "$git_status" =~ behind ]]; then
	    		# echo $COLOR_RED
	    		echo 31
	    	else
		    	# IF REPO IS CAUGHT UP
		        if [[ "$git_status" =~ nothing\ to\ commit ]]; then
		            # echo $COLOR_GREEN
		            echo 32
		        #elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
		        # IF REPO HAS CHANGED
		        else
		        	# echo $COLOR_YELLOW
		            echo 33
		        fi
		    fi
	    fi
	}
	
	export GITCOLOR="\[\e[1;\$(__git_color)m\]"	
	export GITPROMPT="${GITCOLOR}\$(__git_ps1 ' [%s]')${COLOR_RESET}"	
	
	#PS1='\e[0;31m\]\u\e[0;37m\]@\[\e[0;31m\]\h \[\e[0;34m\]\w\[\e[0;33m\]$(__git_ps1 " [%s]")\[\e[m\] '
	#export PS1="[\e[0;32m]\t [\e[32;1m]\u\h:[\e[0;36m]\w[\e[0m]$ "
	
	PS1="${TITLEBAR}${COLOR_RED}\u${COLOR_WHITE}@${COLOR_RED}${COMPUTERNAME} ${COLOR_BLUE}\w${GITPROMPT} "
	
#	export #LS_COLORS='no=33:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=0131:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

# SHORTCUTS

	alias r='rm -Rf'
	alias x=exit
	alias t=touch
	alias cl=clear
	alias sym='ln -s'
	alias his=history
		
	alias pro=profile
	alias reload='source /home/vagrant-shared/.bash_profile'
	alias re=reload
	alias ff=ffind
	
	# MAKE FOLDER AND ENTER IT
	function m() {
		echo -e "\033[1m"
		echo -e "Creating $@...\033[0m"
		mkdir -p "$@" && cd "$@"
		l
	}

	alias mk='mkdir -p'

	alias config='v config'
	alias readme='vim README.md'	
	
# DIRECTORY HELPERS

	function l() {
		echo "";
		ls -halF --color=auto $1;
		echo "";
	}

	function lr() {
		echo "";
		ls -RhalG $1;
		echo "";
	}
	
	function d() {
					
		# CONTAINS A SLASH
		if [[ "$1" = *"/"* ]]; then
			cd $1
			l
			return			
		fi

		# EXACT MATCH
		if [ -d $1 ] ; then
			cd $1
			l
			return
		fi								

		# PARTIAL MATCH
		MATCH=$(find .  -maxdepth 1 -iname "*$1*" -type d -print | head -n1)		
		
		if [ $MATCH ]; then
		 	cd $MATCH
		 	l
		 	return
		fi
		
		# COMMON FOLDER NAME PATTERNS
	
		PATTERNS=(
			".$1"
			"$1.git"
			"$1.dev"
			"$1.new"
			"$1.prod"
			"$1.master"
			"$1.dylan"
			"$1.tmp"
			"$1.bak"
			"$1.com"						
			"$1.net"						
			"$1.org"						
			"$1.co"						
			"$1.me"						
			"$1.is"
			"$1.info"
			"$1.css.mf"
			"$1.js.mf"
			"$1.html.mf"			
		)		
		
		# LOOP THROUGH PATTERNS
			
		if [ $# -ge 1 ] ; then
		
			# SEE IF PATTERN IS A MATCH
			for FOLDER in ${PATTERNS[@]}
			do
				if [ -d $FOLDER ] ; then
					cd $FOLDER
					l
					return
				fi
			done
		
		fi		
		
		# FALLBACK TO E	
		e $1
		
	}
	
	alias ~='d ~'

	alias ..='d ..'
	alias cd..='d ..'
	alias ...='d ../../'
	alias ....='d ../../../'
	alias .....='d ../../../'
	alias .4='d ../../../../'
	alias .5='d ../../../../..'
	alias ,='d /'
	
	function cd/() {
		d /
	}
	
	# OVERRIDE COMMAND-NOT-FOUND ON UBUNTU/UNIX
	function command_not_found_handle {
		d $@		
	}	
	
# SMARTFILE HELPER

	function smartfile() {
	
		PATTERNS=(
			"$2"
			"$2.js"
			"$2.json"
			"$2.ejs"
			"$2.md"
			"$2.txt"
			"$2.log"
			"$2.php"
			"$2.css"
			"$2.html"
			"$2.sh"
			"$2.haml"
			"$2.less"
			"$2.scss"
			"$2.xml"
			"$2.sample"
			"$2.mf"
			"$2.css.mf"
			"$2.js.mf"
			"$2.html.mf"
			"$2.out"					
			".$2"
		)
		
		DEFAULTS=(
			"README.md"
			"package.json"
			"index.php"
			"index.js"
			"index.ejs"
			"app.js"
			"index.haml"
			"readme.txt"
			"config"
			"post-receive"
			".gitconfig"
			".profile"
			".bash_profile"
			".bashrc"
		)
		
		# IF THERE'S AN ARG
		if [ $# -ge 2 ] ; then
	
			# IF ARG DOESN'T CONTAIN SLASH	
			if [[ "$1" != *"/"* ]]; then
		
				# SEARCH FOR PARTIAL MATCH
				MATCH=$(find . -maxdepth 1 -iname "*$2*" -print | head -n1)
				
				if [ $MATCH ]; then
				 	$1 $MATCH
				 	return
				fi
			
			fi
					
			LIST=${PATTERNS[@]}
			ORIGINAL="$2"
			
		# ELSE CHECK FOR A DEFAULT
		else
			LIST=${DEFAULTS[@]}
			ORIGINAL="File"
		fi
		
		# TRY TO ACT ON FILE
		try_files "$1" "$ORIGINAL" "${LIST[@]}"		
		
	}
	
	function try_files() {

		ACTION=${1}
		shift

		ORIGINAL=${1}
		shift

		COLLECTION=${@}
		
		for FILENAME in $COLLECTION
		do
			if [ -f $FILENAME ] ; then
				eval $ACTION $FILENAME
				return 1
			fi
		done
				
		echo "ERROR: $ORIGINAL not found!"
		return 0
					
	}	
	
# ECHO HELPER

	function e() {
		echo ""	
		echo -en "\033[1m"
		
		smartfile 'cat' $*
		
		# IF SUCCESSFUL, PRINT EXTRA LINE BREAK
		status=$?		
	    if [ $status -gt 0 ]; then
	        echo ""
	    fi
		
		echo -en "\033[0m"
		echo ""
	}
	
# VIM HELPER

	function v() {
		smartfile 'vim' $*
	}
	
# NODE ALIASES

	alias s=sails
	alias sl="sails lift"
	alias ni="npm install --save"
	alias nid="npm install --save-dev"
	alias nr="npm run"
	alias ng="sudo npm install -g"
	alias nv="node --version"
	alias nu="npm update"	
	alias gr=grunt
	alias grs='grunt serve'
	alias snl='sudo npm link'
	alias nm='d node_modules'
	alias np='npm publish ./'
	alias nd='n --debug'
	alias mo=mocha
	alias mog='mocha --grep'
	alias cc='conventional-changelog -p angular -i CHANGELOG.md -w'
	alias ccall='conventional-changelog -p angular -i CHANGELOG.md -w -r 0'
	alias rlog='rm *.log'
	alias rl=rlog	
	
# N HELPER	
	
	function n() {
		echo ""	
		echo -en "\033[1m"
		
		FILENAME=""
		
		if [ $1 ] ; then
			# ARGUMENT(S) GIVEN	
			if [[ "$1" != *.js* ]] ; then
				FILENAME="$1.js"
			elif [[ "$1" == *--* ]] ; then
				FILENAME="app.js $1"
			else
				FILENAME=$1
			fi
			shift
		elif [ -f app.js ]; then
			# NO ARGUMENTS, RUN APP.JS
			FILENAME="app.js"
		elif [ -f index.js ]; then
			# NO ARGUMENTS, RUN INDEX.JS
			FILENAME="index.js"
		fi
		
		if [[ $1 = "debug" || $1 = "--debug" ]]; then
			node-debug $FILENAME ${@}			
		elif [[ $FILENAME ]]; then
			node $FILENAME ${@}
		else
			echo "ERROR: script not found"
		fi
				
		echo -en "\033[0m"
		echo ""		
		
	}	
	
# NT HELPER

	function nt() {
		if [[ "$1" == "--all" || "$1" == "-a" ]]; then
			npm run mocha -- test/[^_]*.js
		elif [[ "$2" == "--all" || "$2" == "-a" ]]; then
			npm run mocha -- test/$1*.js
		elif [[ "$1" ]]; then
			npm run mocha -- test/$1*.js --bail
		else
			npm run mocha -- test/[^_]*.js --bail
		fi
	}
	
# GIT HELPERS

	# QUICK CHECKOUT
	alias go='git checkout'
	
	# QUICK ADD
	function ga() {
		git add $*
	}

	# ADD ALL CHANGED AND NEW FILES
	function gaa() {
		git add -A
	}
	
	# QUICK COMMIT
	function gc() {
		echo -e "\033[1m"
		git commit -m "$*"
		echo -e "" 
	}
	
	# ADD TRACKED CHANGES, THEN COMMIT
	function gac() {
		echo -e "\033[1m"
		git commit -am "$*"
		echo -e ""
	}
	
	# ADD TRACKED CHANGES, COMMIT, THEN PUSH
	function gacp() {
		echo -e "\033[1m"
		git commit -am "$*"	
		git push
		echo -e ""
	}
	
	# ADD ALL CHANGES, THEN COMMIT	
	function c() {
		echo -e "\033[1m"
		git add -A
		git commit -m "$*"
		echo -e ""
	}	

	#  ADD ALL CHANGES, COMMIT, THEN PUSH	
	function p() {
		echo -e "\033[1m"
		git add -A
		git commit -m "$*"
		git push
		echo -e ""
	}
		
	alias gp='git push'
	
	alias gpo='git push origin'
	
	alias push='git push'
	alias pull='git pull'
	
	function gpa() {
		echo -e "\033[1m"
		git add -A
		git commit -m "$*"
		git push all master	
		echo -e ""
	}
	
	function gu() {
		echo -e "\033[1m"
		git remote update
		echo -e ""		
	}
	
	function gr() {
		echo -e "\033[1m"
		git remote "$*"
		echo -e ""	
	}

	function gf() {
		echo -e "\033[1m"
		git fetch "$*"
		echo -e ""	
	}	

	function grm() {
		echo -e "\033[1m"
		git rm "$*"
		echo -e ""	
	}	

	function gmv() {
		echo -e "\033[1m"
		git mv "$*"
		echo -e ""	
	}
			
	alias u=gu
	alias gd='git diff'		
	alias gb='git branch'
	alias gm="git merge"
	alias gra='gr add'
	
	# GIT STATUS
	function gs() {
		echo -e "\033[1m"
		git status -sb
		echo -e ""
	}	

	alias g=gs
	
	function lg() {
		l
		gs
	}

	function gsd() {
		gs
		gd
	}
	
	## RESET WORKING COPY TO HEAD, DELETE ALL CHANGES
	function ghard() {
		echo -e "\033[1m"
		git reset --hard
		echo -e ""	
	}

	# UNSTAGE COMMITS
	function greset() {
		echo -e "\033[1m"
		git reset
		echo -e ""		
	}
	
	alias gitconfig="vim .gitconfig"
	alias gitignore="vim .gitignore"
	alias gconfig=gitconfig
	alias gignore=gitignore	
	
# CHANGE TO APP DIR

	cd /vagrant
	l