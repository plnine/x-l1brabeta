#! /bin/bash

#X-l1bra  
clear && source <(curl -s https://raw.githubusercontent.com/plnine/x-l1bra/main/scripts/common.sh)
printLogo

mainmenu() {
    echo -ne "
Выберите ноду
1) Nibiru
2) Celestia
3) DeFund
0) Exit
Введите цифру:  "
    read -r ans
    case $ans in
    1)
        nibiru
        mainmenu
        ;;
    2)
    	celestia
    	mainmenu
        ;;
    3)
        defund
        mainmenu
        ;;
    0)
        echo "Bye bye."
        exit 0
        ;;
    *)
        echo "Wrong option."
        exit 1
        ;;
    esac
}

Nibiru() {
    echo -ne "
NIBIRU
1) Установить
2) Обновить
3) Удалить
3) Помощь
4) Вернутся назад
0) Выйти
Введите цифру:  "
    read -r ans
    case $ans in
    1)
        sub-submenu
        submenu
        ;;
    2)
        menu
        ;;
    0)
        echo "Bye bye."
        exit 0
        ;;
    *)
        echo "Wrong option."
        exit 1
        ;;
    esac
}

defund(){

}

mainmenu