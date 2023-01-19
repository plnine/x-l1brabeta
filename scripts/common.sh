NC="\e[0m"           # no color
CYAN="\e[1m\e[1;96m"
RED="\e[1m\e[1;91m"
GREEN="\e[1;92m"
YELLOW="\e[1;93m"
PURPLE="\e[1;95m"
BLUE="\e[1;94m"

function printLogo {
  bash <(curl -s https://raw.githubusercontent.com/plnine/x-l1bra/main/scripts/logo.sh)
}

function printLine {
  echo "======================================================================================="
}

function printCyan {
  echo -e "${CYAN}${1}${NC}"
}

function printRed {
  echo -e "${RED}${1}${NC}"
}

function printGreen {
  echo -e "${GREEN}${1}${NC}"
}

function printYellow {
  echo -e "${YELLOW}${1}${NC}"
}
function printPurple {
  echo -e "${PURPLE}${1}${NC}"
}

function printBlue {
  echo -e "${BLUE}${1}${NC}"
}

function addToPath {
  source $HOME/.bash_profile
  PATH_EXIST=$(grep ${1} $HOME/.bash_profile)
  if [ -z "$PATH_EXIST" ]; then
    echo "export PATH=$PATH:${1}" >>$HOME/.bash_profile
  fi
}

### Colors ##
ESC=$(printf '\033') RESET="${ESC}[0m" BLACK="${ESC}[30m" RED="${ESC}[31m"
GREEN="${ESC}[32m" YELLOW="${ESC}[33m" BLUE="${ESC}[34m" MAGENTA="${ESC}[35m"
CYAN="${ESC}[36m" WHITE="${ESC}[37m" DEFAULT="${ESC}[39m"

### Color Functions ##

greenprint() { printf "${GREEN}%s${RESET}\n" "$1"; }
blueprint() { printf "${BLUE}%s${RESET}\n" "$1"; }
redprint() { printf "${RED}%s${RESET}\n" "$1"; }
yellowprint() { printf "${YELLOW}%s${RESET}\n" "$1"; }
magentaprint() { printf "${MAGENTA}%s${RESET}\n" "$1"; }
cyanprint() { printf "${CYAN}%s${RESET}\n" "$1"; }