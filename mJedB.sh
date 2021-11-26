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
 HEAD(){ for (( a=2; a<=15; a++ ))
  do
   TPUT $a 1
 $E "\033[34m\xE2\x94\x82                                                                                              \xE2\x94\x82\033[0m";
  done
 TPUT 1 1
 $E "\033[0m\033[34m+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+\033[0m"
 TPUT 2 3
 $E "\033[1;36m *** Jed - редактор программистов ***\033[0m                          \033[34m|\033[0m";
 TPUT 4 4
 $E "\033[1;36mX опции\033[34m | \033[32mX options\033[0m";
 TPUT 5 4
 $E "\033[36mxjed Дополнительно принимает общие параметры, такие как -display, -name, -fn и -geometry\033[0m";
 TPUT 13 4
 $E "\033[36mUp \xE2\x86\x91 \xE2\x86\x93 Down Select Enter                                      \033[34m| \033[0m";
 TPUT 15 4
 $E "\033[36mДополнительные параметры см. На xterm.c\033[0m";
 MARK;TPUT 3 1
 $E "\033[0m\033[34m+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+\033[0m";UNMARK;}
  i=0; CLEAR; CIVIS;NULL=/dev/null
 FOOT(){ MARK;TPUT 16 1
 $E "\033[0m\033[34m+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+\033[0m";UNMARK;}
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
 M0(){ TPUT  6 3; $e "при сборке с поддержкой XRENDERFONT выбирает размер шрифта SIZE\033[32m -facesize SIZE -fs SIZE    \033[0m";}
 M1(){ TPUT  7 3; $e "устанавливает цвет переднего плана                             \033[32m -foreground COLOR -fg COLOR\033[0m";}
 M2(){ TPUT  8 3; $e "устанавливает цвет фона                                        \033[32m -background COLOR -bg COLOR\033[0m";}
 M3(){ TPUT  9 3; $e "устанавливает цвет переднего плана указателя мыши              \033[32m -fgMouse COLOR -mfg COLOR  \033[0m";}
 M4(){ TPUT 10 3; $e "устанавливает цвет фона указателя мыши                         \033[32m -bgMouse COLOR -mbg COLOR  \033[0m";}
 M5(){ TPUT 11 3; $e "значок запуска                                                 \033[32m -Iconic -ic                \033[0m";}
 M6(){ TPUT 12 3; $e "устанавливает заголовок окна на ИМЯ                            \033[32m -title NAME                \033[0m";}
#
 M7(){ TPUT 14 3; $e "Выход                                                          \033[32m EXIT                       \033[0m";}
LM=7
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
 0) S=M0;SC;if [[ $cur == enter ]];then R;echo " при сборке с поддержкой XRENDERFONT выбирает размер шрифта SIZE. Используйте его с параметром -fn, чтобы выбрать масштабируемый шрифт.";ES;fi;;
 1) S=M1;SC;if [[ $cur == enter ]];then R;echo " устанавливает цвет переднего плана";ES;fi;;
 2) S=M2;SC;if [[ $cur == enter ]];then R;echo " устанавливает цвет фона";ES;fi;;
 3) S=M3;SC;if [[ $cur == enter ]];then R;echo " устанавливает цвет переднего плана указателя мыши";ES;fi;;
 4) S=M4;SC;if [[ $cur == enter ]];then R;echo " устанавливает цвет фона указателя мыши";ES;fi;;
 5) S=M5;SC;if [[ $cur == enter ]];then R;echo " значок запуска";ES;fi;;
 6) S=M6;SC;if [[ $cur == enter ]];then R;echo " устанавливает заголовок окна на ИМЯ";ES;fi;;
#
 7) S=M7;SC;if [[ $cur == enter ]];then R;clear;exit 0;fi;;
 esac;POS;done
