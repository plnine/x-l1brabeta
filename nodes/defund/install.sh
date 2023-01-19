#! /bin/bash
clear
source <(curl -s https://raw.githubusercontent.com/plnine/x-l1bra/main/scripts/common.sh)
printLogo
printRed  ======================================================================= 
mainmenu() {
    echo -ne "
    Начать установку !
$(yellowprint 'DEFUND')
$(greenprint   '1)') Да
$(redprint     '2)') Нет
Введите цифру:  "
   read -r ans
    case $ans in
    1)
        yes
        ;;
    2)
        no
        source <(curl -s https://raw.githubusercontent.com/plnine/x-l1bra/main/nodes/defund/main.sh)
        ;;
   
    *)
        clear
        printLogo
        mainmenu
        ;;
    esac
}

yes(){
clear
printLogo
printRed  ======================================================================= 
echo Пошла установка
}