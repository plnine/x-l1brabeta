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
