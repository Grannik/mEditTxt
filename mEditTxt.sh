#!/bin/bash
 E='echo -e';e='echo -en';trap "R;exit" 2
 ESC=$( $e "\e")
 TPUT(){ $e "\e[${1};${2}H" ;}
 CLEAR(){ $e "\ec";}
# 25 возможно это
 CIVIS(){ $e "\e[?25l";}
# это цвет текста списка перед курсором при значении 0 в переменной  UNMARK(){ $e "\e[0m";}
 MARK(){ $e "\e[1;90m";}
# 0 это цвет заднего фона списка
 UNMARK(){ $e "\e[0m";}
# ~~~~~~~~ Эти строки задают цвет фона ~~~~~~~~
 R(){ CLEAR ;stty sane;CLEAR;};
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 HEAD(){ for (( a=2; a<=19; a++ ))
  do
   TPUT $a 1
 $E "\033[34m\xE2\x94\x82                                        \xE2\x94\x82\033[0m";
  done
TPUT 1 1
 $E "\033[34m+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+\033[0m"
TPUT 2 3
 $E "\033[1;36m*** Консольные текстовые редакторы ***\033[0m";
TPUT 18 4
 $E "\033[36mUp \xE2\x86\x91 \xE2\x86\x93 Down Select Enter\033[0m";
 MARK;TPUT 3 1
 $E "\033[34m+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+\033[0m" ;UNMARK;}
  i=0; CLEAR; CIVIS;NULL=/dev/null
 FOOT(){ MARK;TPUT 20 1
 $E "\033[0m\033[34m+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+\033[0m";UNMARK;}
# это управляет кнопками ввер/хвниз
 i=0; CLEAR; CIVIS;NULL=/dev/null
#
 ARROW(){ IFS= read -s -n1 key 2>/dev/null >&2
           if [[ $key = $ESC ]];then 
              read -s -n1 key 2>/dev/null >&2;
              if [[ $key = \[ ]]; then
                 read -s -n1 key 2>/dev/null >&2;
                 if [[ $key = A ]]; then echo up;fi
                 if [[ $key = B ]];then echo dn;fi
              fi
           fi
           if [[ "$key" == "$($e \\x0A)" ]];then echo enter;fi;}
 M0(){ TPUT  4 3; $e "                              \033[32m ne    \033[0m";}
 M1(){ TPUT  5 3; $e "                              \033[32m nano  \033[0m";}
 M2(){ TPUT  6 3; $e "                              \033[32m vi    \033[0m";}
 M3(){ TPUT  7 3; $e "                              \033[32m vim   \033[0m";}
 M4(){ TPUT  8 3; $e "                              \033[32m dte   \033[0m";}
 M5(){ TPUT  9 3; $e "                              \033[32m jed   \033[0m";}
 M6(){ TPUT 10 3; $e "                              \033[32m joe   \033[0m";}
 M7(){ TPUT 11 3; $e "                              \033[32m pico  \033[0m";}
 M8(){ TPUT 12 3; $e "                              \033[32m cedit \033[0m";}
 M9(){ TPUT 13 3; $e "                              \033[32m emacs \033[0m";}
M10(){ TPUT 14 3; $e "                              \033[32m ed    \033[0m";}
M11(){ TPUT 15 3; $e "Показать редактор по умолчанию       ";}
M12(){ TPUT 16 3; $e "Поменять редактор по умолчанию       ";}
M13(){ TPUT 17 3; $e "\033[34mGrannik Git\033[0m                          ";}
#
M14(){ TPUT 19 3; $e "Выход                         \033[32m EXIT  \033[0m";}
LM=14
   MENU(){ for each in $(seq 0 $LM);do M${each};done;}
    POS(){ if [[ $cur == up ]];then ((i--));fi
           if [[ $cur == dn ]];then ((i++));fi
           if [[ $i -lt 0   ]];then i=$LM;fi
           if [[ $i -gt $LM ]];then i=0;fi;}
REFRESH(){ after=$((i+1)); before=$((i-1))
           if [[ $before -lt 0  ]];then before=$LM;fi
           if [[ $after -gt $LM ]];then after=0;fi
           if [[ $j -lt $i      ]];then UNMARK;M$before;else UNMARK;M$after;fi
           if [[ $after -eq 0 ]] || [ $before -eq $LM ];then
           UNMARK; M$before; M$after;fi;j=$i;UNMARK;M$before;M$after;}
   INIT(){ R;HEAD;FOOT;MENU;}
     SC(){ REFRESH;MARK;$S;$b;cur=`ARROW`;}
# Функция возвращения в меню
     ES(){ MARK;$e " ENTER = main menu ";$b;read;INIT;};INIT
  while [[ "$O" != " " ]]; do case $i in
 0) S=M0;SC;if [[ $cur == enter ]];then R;./mNe.sh;ES;fi;;
 1) S=M1;SC;if [[ $cur == enter ]];then R;./mNanoA.sh;ES;fi;;
 2) S=M2;SC;if [[ $cur == enter ]];then R;echo " Предшественник Vim";ES;fi;;
 3) S=M3;SC;if [[ $cur == enter ]];then R;echo " sudo add-apt-repository ppa:jonathonf/vim
 sudo apt update
 suo ap install vim
  Многие команды, изменяющие текст, состоят из оператора и объекта. Формат команды удаления с оператором  d  следующий:
 d объект
  Здесь:
    d      - оператор удаления.
    объект - над чем должна быть выполнена команда (перечислено ниже).
  Краткий список объектов:
    w - от курсора до конца слова, включая последующий пробел.
    e - от курсора до конца слова, НЕ включая последующий пробел.
    \$ - от курсора до конца строки.
    ^ - от курсора до начала строки.";ES;fi;;
 4) S=M4;SC;if [[ $cur == enter ]];then R;./mDte.sh;ES;fi;;
 5) S=M5;SC;if [[ $cur == enter ]];then R;echo " Jed - редактор меню-ориентированный, что делает его, казалось бы, более привычным для пользователя, пришедшего из мира DOS-Windows.
 Во всяком случае, при запуске можно видеть строку меню достаточно стандартного вида - с пунктами File, Edit, Search, Buffers, Windows, System, Help
 Вот несколько комбинаций, которые могут показаться вам полезными для начала работы с Jed. Как обычно, C — Ctrl, M — Meta (обычно — Alt).
 C-h       Вызвать систему справки
 C-x C-c   Выйти
 C-x C-f   Открыть файл
 C-x C-k   Закрыть файл
 C-x 2     Разделить окно
 C-x o     Перейти к следующему окну
 C-Пробел  Установить начало выделения (C-Пробел отменяет область выделения)
 C-Shift-w Вырезать
 M-Shift-w Копировать
 C-y       Вставить
 C-a       Перейти к началу строки
 C-e       Перейти к концу строки";ES;fi;;
 6) S=M6;SC;if [[ $cur == enter ]];then R;echo " sudo apt install joe
  Главная отличие и особенность этого редактора умение эмулировать другие редакторы, такие как Pico, Vi, Emacs. Для вызова каких нужно ввести специальную команду,
 например, редактор Pico запускается через команду jpico, после какой стандартно указываем файл с которым нужно поработать.";ES;fi;;
 7) S=M7;SC;if [[ $cur == enter ]];then R;echo "  Pico - командно-ориентированный редактор, входящий в состав почтовой системы pine. Он очень компактен, что позволяет использовать его на слабых машинах. Все
 манипуляции в нем осуществляются посредством комбинации Control+буква. Что работает и при кириллической раскладке клавиатуры. Основные клавишные комбинации
 постоянно присуствуют в нижней части экрана, не требуя чрезмерного напряжения памяти.";ES;fi;;
 8) S=M8;SC;if [[ $cur == enter ]];then R;echo " В пакет mc (файловый менеджер) входит хороший и довольно удобный mcedit
 sudo apt install mc";ES;fi;;
 9) S=M9;SC;if [[ $cur == enter ]];then R;echo "  Старейший текстовый редактор, с которого началась история свободного ПО. Впрочем, просто редактором его можно назвать весьма и весьма условно.
 Опытные пользователи Emacs говорят, что эта программа умеет всё за исключением приготовления кофе";ES;fi;;
10) S=M10;SC;if [[ $cur == enter ]];then R;echo " ed – простой редактор строк без поддержки курсора. Домашняя страница: http://www.gnu.org/software/ed/ed.html";ES;fi;;
11) S=M11;SC;if [[ $cur == enter ]];then R;echo "  Для Ubuntu:
 ls -l /etc/alternatives/editor";ES;fi;;
12) S=M12;SC;if [[ $cur == enter ]];then R;echo " Для Ubuntu:
  sudo update-alternatives --config editor
 Появиться таблица со списком установленных редакторов, который имеет свой номер. Выбираем свой любимый редактор и вводим его номер.
 Теперь выбранный вами редактор, будет редактором по умолчанию.";ES;fi;;
13) S=M13;SC;if [[ $cur == enter ]];then R;echo "
 mEditTxt Маленькая программка-туториал (пошаговое объяснение) для консольных, текстовых редакторов: vi, vim, jed, joe, pico.
 Для dte, ne и nano есть интерактивная инструкция с примерами.
 https://github.com/GrannikOleg/mEditTxt
 https://gitlab.com/GrannikOleg/medittxt
 https://notabug.org/Grannikoleg/mEditTxt
 https://sourceforge.net/projects/medittxt/
 https://bitbucket.org/grannikoleg/medittxt/src/master/
 Grannik | 2021.11.21
";ES;fi;;
#
14) S=M14;SC;if [[ $cur == enter ]];then R;clear;ls -l;exit 0;fi;;
 esac;POS;done
