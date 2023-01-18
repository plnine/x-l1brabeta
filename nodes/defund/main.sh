#! /bin/bash

mainmenu() {
    echo -ne "
DEFUND
1) Установить
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
    	:;
    4)
        help
        :;
    0)
        echo "Bye bye."
        exit 0
        ;;
    *)
        echo "Неправильный вариант."
        mainmenu
        ;;
    esac
}

install(){

}

update(){

}

delet(){

}

help(){

}

mainmenu