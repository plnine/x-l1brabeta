#! /bin/bash
source <(curl -s https://raw.githubusercontent.com/plnine/x-l1bra/main/scripts/common.sh)
mainmenu() {
    echo -ne "
DEFUND
(greenprint '1)') Установить
2) Обновить
3) Удалить
4) Помощь
5) Вернутся назад
0) Выйти
Введите цифру:  "
   read -r ans
    case $ans in
    1)
        install
        ;;
    2)
        update
        ;;
    3)  
    	delet
    	;;
    4)
        help
        ;;
    0)
        echo "Bye bye."
        exit 0
        ;;
    *)
        clear
        source <(curl -s https://raw.githubusercontent.com/plnine/x-l1bra/main/scripts/logo.sh)
        echo "Неправильный вариант."
        mainmenu
        ;;
    esac
}

install(){
printLogo
printLine
mainmenu
}

update(){
echo
}

delet(){
echo
}

help(){
echo
}

mainmenu