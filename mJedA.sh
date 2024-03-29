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
 HEAD(){ for (( a=2; a<=38; a++ ))
  do
   TPUT $a 1
 $E "\033[34m\xE2\x94\x82                                                                                    \xE2\x94\x82\033[0m";
  done
 TPUT 1 1
 $E "\033[0m\033[34m+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+\033[0m"
 TPUT 2 4
 $E "\033[1;36m *** Jed - редактор программистов ***\033[0m                        \033[34m|\033[0m";
 TPUT 8 4
 $E "\033[1;36mКонфигурация           \033[34m                                      | \033[32mCONFIGURATION\033[0m";
 TPUT 13 4
 $E "\033[1;36mВремя работы           \033[34m                                      | \033[32mRUN TIME     \033[0m";
 TPUT 16 4
 $E "\033[1;36mБазовое редактирование \033[34m                                      | \033[32mBasic Editing\033[0m";
 TPUT 19 4
 $E "\033[1;36mОсновные опции         \033[34m                                      | \033[32mMajor options\033[0m";
 TPUT 25 4
 $E "\033[1;36mНезначительные опции   \033[34m                                      | \033[32mMinor options\033[0m";
 TPUT 36 4
 $E "\033[32mUp \xE2\x86\x91 \xE2\x86\x93 Down Select Enter                                   \033[34m| \033[32m";
 MARK;TPUT 3 1
 $E "\033[0m\033[34m+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+\033[0m";UNMARK;}
  i=0; CLEAR; CIVIS;NULL=/dev/null
 FOOT(){ MARK;TPUT 39 1
 $E "\033[0m\033[34m+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+\033[0m";UNMARK;}
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
 M0(){ TPUT  4 3; $e "Обзор                                                              \033[32m SYNOPSIS     \033[0m";}
 M1(){ TPUT  5 3; $e "Описание                                                           \033[32m DESCRIPTION  \033[0m";}
 M2(){ TPUT  6 3; $e "Файлы настроек                                                     \033[32m FILES        \033[0m";}
 M3(){ TPUT  7 3; $e "Автор                                                              \033[32m AUTHOR       \033[0m";}
#
 M4(){ TPUT  9 3; $e "Эмуляция других редакторов                                                       ";}
 M5(){ TPUT 10 3; $e "Эмуляция Emacs                                                                   ";}
 M6(){ TPUT 11 3; $e "Эмуляция EDT                                                                     ";}
 M7(){ TPUT 12 3; $e "Эмуляция Wordstar                                                                ";}
#
 M8(){ TPUT 14 3; $e "Строка состояния и окна                                                          ";}
 M9(){ TPUT 15 3; $e "Мини-буфер                                                                       ";}
#
M10(){ TPUT 17 3; $e "Редактирование с помощью JED                                                     ";}
M11(){ TPUT 18 3; $e "Горячие клавиши                                                                  ";}
#
M12(){ TPUT 20 3; $e "печатает переменные версии и времени компиляции                    \033[32m --version    \033[0m";}
M13(){ TPUT 21 3; $e "печатает информацию об использовании                               \033[32m --help       \033[0m";}
M14(){ TPUT 22 3; $e "запускает Jed в безопасном режиме                                  \033[32m --secure     \033[0m";}
M15(){ TPUT 23 3; $e "запустить Jed в пакетном режиме                                    \033[32m --batch      \033[0m";}
M16(){ TPUT 24 3; $e "это режим, подобный --batch, но jed не оценивает файлы запуска     \033[32m --script     \033[0m";}
#
M17(){ TPUT 26 3; $e "не загружайте файл .jedrc                                          \033[32m -n           \033[0m";}
M18(){ TPUT 27 3; $e "загрузить файл как пользовательский файл конфигурации вместо .jedrc\033[32m -a 'file'    \033[0m";}
M19(){ TPUT 28 3; $e "Установите режим эмуляции                                          \033[32m -e           \033[0m";}
M20(){ TPUT 29 3; $e "goto line n в буфере                                               \033[32m + 'n'        \033[0m";}
M21(){ TPUT 30 3; $e "goto line n в буфере                                               \033[32m -g 'n'       \033[0m";}
M22(){ TPUT 31 3; $e "загрузить файл как код S-Lang                                      \033[32m -l 'file'    \033[0m";}
M23(){ TPUT 32 3; $e "выполнить функцию S-Lang с именем function                         \033[32m -f 'function'\033[0m";}
M24(){ TPUT 33 3; $e "поиск строки вперед                                                \033[32m -s 'string'  \033[0m";}
M25(){ TPUT 34 3; $e "разделенное окно                                                   \033[32m  -2          \033[0m";}
M26(){ TPUT 35 3; $e "вставить файл в текущий буфер                                      \033[32m -i 'file'    \033[0m";}
#
M27(){ TPUT 37 3; $e "Далее                                                              \033[32m Onward       \033[0m";}
M28(){ TPUT 38 3; $e "Выход                                                              \033[32m EXIT         \033[0m";}
LM=28
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
 0) S=M0;SC;if [[ $cur == enter ]];then R;echo "  jed --version
  jed-script --version
 xjed --version
  jed [--secure] [--batch|--script|--help] [options] file ...
  jed-script [--secure] script file [script options] ...
 xjed [--secure] [X options] [--batch|--script|--help] [options] file ...";ES;fi;;
 1) S=M1;SC;if [[ $cur == enter ]];then R;echo "  Функции: Цветовая подсветка синтаксиса. Эмуляция редакторов Emacs, EDT, Wordstar и Brief. Возможность расширения на языке, напоминающем C. Полностью настраиваемoe
 pедактирование. Файлы TeX с редактированием в стиле AUC-TeX (поддержка BiBTeX тоже). Складная подставка и многое другое ... Полную документацию см.
 В информационных файлах GNU, это руководство содержит только краткое руководство.";ES;fi;;
 2) S=M2;SC;if [[ $cur == enter ]];then R;echo " файлы сленга jed по умолчанию (такие пакеты, как jed-extra, могут определять дополнительные каталоги библиотеки сленга): JED_ROOT/lib/ *. Sl
 файл запуска по умолчанию:                                                                                               JED_ROOT/lib/site.sl
 Общесистемные файлы конфигурации (это особая функция Debian):                                                            /etc/jed.d/*.sl
 Файл конфигурации для каждого пользователя:                                                                              ~/.jedrc
 или:                                                                                                                     ~/.jed/jed.rc
 на файл конфигурации пользователя, если существует Jed_Home_Directory:                                                   ~/.jed/.";ES;fi;;
 3) S=M3;SC;if [[ $cur == enter ]];then R;echo " Автор Jed Джон Э. Дэвис                          davis@space.mit.edu
 Этот документ на nroff перевел Борис Д. Белецкий borik@isracom.co.il";ES;fi;;
 4) S=M4;SC;if [[ $cur == enter ]];then R;echo "  Способность JED создавать новые функции с использованием языка программирования S-Lang, а также позволять пользователю выбирать привязки клавиш, делает эмуляцию
 возможны другие редакторы. В настоящее время JED обеспечивает разумную эмуляцию редакторов Emacs, EDT и Wordstar.";ES;fi;;
 5) S=M5;SC;if [[ $cur == enter ]];then R;echo "  Эмуляция Emacs обеспечивается кодом S-Lang в emacs.sl. Эмулируются основные функции Emacs; у большинства пользователей Emacs не должно возникнуть проблем с JED.
 Чтобы включить эмуляцию Emacs в JED, убедитесь, что строка:
 () = evalfile (\"emacs\");
 находится в вашем стартовом файле jed.rc (.jedrc). JED распространяется с этой строкой, уже присутствующей в файле jed.rc по умолчанию.";ES;fi;;
 6) S=M6;SC;if [[ $cur == enter ]];then R;echo "  Для эмуляции EDT должен быть загружен edt.sl. Это достигается за счет того, что строка:
 () = evalfile (\"edt\");
 присутствует в файле запуска jed.rc (.jedrc).";ES;fi;;
 7) S=M7;SC;if [[ $cur == enter ]];then R;echo "  wordstar.sl содержит код S-Lang для эмуляции Wordstar в JED. Добавление строки
 () = evalfile (\"wordstar\");
 в файл запуска jed.rc (.jedrc) включит эмуляцию JED Wordstar.";ES;fi;;
 8) S=M8;SC;if [[ $cur == enter ]];then R;echo "   JED поддерживает несколько окон. Каждое окно может содержать один и тот же буфер или разные буферы. Строка состояния отображается сразу под каждым окном.
 Строка состояния содержит такую информацию, как номер версии JED, имя буфера, режим и т. Д. Обратите внимание на следующие индикаторы:
  **       буфер был изменен с момента последнего сохранения.
  %%       буфер доступен только для чтения.
  м        Отметить установленный индикатор. Это означает, что регион определяется.
  d        Индикатор файла изменен на диске. Это указывает на то, что файл, связанный с буфером, новее, чем сам буфер.
  s        точечный индикатор.
  +        Для буфера разрешена отмена.
  [Narrow] Буфер сужен до области ЛИНИЙ.
  [Macro]  Макрос определяется.";ES;fi;;
 9) S=M9;SC;if [[ $cur == enter ]];then R;echo "  Мини-буфер состоит из одной строки, расположенной в нижней части экрана. Большая часть диалога между пользователем и JED происходит в этом буфере. Например, когда
 вы ищете строку, JED предложит вам ввести строку в мини-буфере.
  Мини-буфер также обеспечивает прямую ссылку на интерпретатор S-Lang. Чтобы получить доступ к интерпретатору, нажмите Ctrl-X Esc, и на экране появится приглашение
 S-Lang.
  Мини-буфер. Введите любое допустимое выражение S-Lang для оценки интерпретатором.
  Можно вызвать данные, ранее введенные в мини-буфер, с помощью клавиш со стрелками вверх и вниз. Это позволяет использовать и редактировать предыдущие выражения в
 удобной и эффективной манере.";ES;fi;;
#
10) S=M10;SC;if [[ $cur == enter ]];then R;echo "   Редактировать с помощью JED довольно просто - большинство ключей просто вставляются сами. Перемещение по буферу обычно осуществляется с помощью клавиш со стрелками
 или страницы вверх и страницы клавиши вниз. Если загружен edt.sl, то клавиатуры на терминалах VTxxx также работают. Здесь затронуты только основные моменты
 (операции вырезания / вставки не выполняются считается изюминкой). В дальнейшем любой символ с префиксом ^ обозначает управляющий символ. На клавиатурах без явного
 Escape клавиша Ctrl- [, скорее всего, сгенерирует и escape-символ.
   Аргумент префикса для команды может быть сгенерирован первым нажатием клавиши Esc, затем вводом числа с последующим нажатием нужной клавиши. Обычно Префиксный
 аргумент используется просто для повторения. Например, чтобы переместиться на 40 символов вправо, нужно нажать Esc 4 0, а затем сразу вправо Стрелка. Это
 иллюстрирует использование аргумента повторения для повторения. Однако аргумент префикса может использоваться и другими способами. Например, чтобы начать определение
 области, нужно нажать клавишу Ctrl- @. Это устанавливает отметку и начинает выделение. Нажатие клавиши Ctrl- @ с аргументом префикса прервет действие определения
 региона и отметит отметку.";ES;fi;;
11) S=M11;SC;if [[ $cur == enter ]];then R;echo -e "
  В следующем списке полезных сочетаний клавиш предполагается, что загружен файл emacs.sl.
  Jed - редактор меню-ориентированный, что делает его, более привычным для пользователя, пришедшего из мира DOS-Windows. при запуске можно видеть строку меню
 достаточно стандартного вида - с пунктами File, Edit, Search, Buffers, Windows, System, Help комбинации Jed: M — Meta (обычно — Alt):
 Ctrl- _       Отменить (Control-подчеркивание, также Ctrl-X u ').
 Esc q         Переформатировать абзац (режим переноса). Используется с аргументом префикса. также будет выравнивать абзац.
 Esc n         узкий абзац (режим переноса). Использование с аргументом префикса также оправдывает абзац.
 Esc;          Сделать языковой комментарий (Fortran и C)
 Esc \\        Обрезать пробелы вокруг точки
 Esc!          Выполнить команду оболочки
 Esc $         Слово Ispell
 \`            quoted_insert --- вставить следующий символ как есть (клавиша обратной кавычки)
 Esc s         Центральная линия.
 Esc u         Слово в верхнем регистре.
 Esc d         Слово в нижнем регистре.
 Esc c         Слово пишите с заглавной буквы.
 Esc x         Получить приглашение минибуфера M-x с завершением команды
 Esc.          Найти тег
 M-Shift-w Копировать
 C-y       Вставить
+----------------------------+-----------------------------------------------------------------------------------------------------------------+
| Сочетания клавиш           | Объяснение действия                                                                                             |
| Первичное      | Вторичное |                                                                                                                 |
|\033[32m Ctrl X        \033[0m | \033[32mCtrl B \033[0m   | всплывает список буферов                                                                                        |
|\033[32m Ctrl X        \033[0m | \033[32mCtrl C \033[0m   | выйти из JED                                                                                                    |
|\033[32m Ctrl X        \033[0m | \033[32mCtrl F \033[0m   | Открыть файл                                                                                                    |
|\033[32m Ctrl X        \033[0m | \033[32m?      \033[0m   |  Показать информацию о строке / столбце.                                                                        |
|\033[32m Ctrl X        \033[0m | \033[32m0      \033[0m   | Удалить текущее окно                                                                                            |
|\033[32m Ctrl X        \033[0m | \033[32m1      \033[0m   | Вернут вид одного окна                                                                                          |
|\033[32m Ctrl X        \033[0m | \033[32m2      \033[0m   | Разделить окно                                                                                                  |
|\033[32m Ctrl X        \033[0m | \033[32mO      \033[0m   | Перейти в другое окно                                                                                           |
|\033[32m Ctrl X        \033[0m | \033[32mA      \033[0m   | Перейти к началу строки                                                                                         |
|\033[32m Ctrl X        \033[0m | \033[32mE      \033[0m   | Перейти к концу строки                                                                                          |
|\033[32m Ctrl X        \033[0m | \033[32mK      \033[0m   | убить буфер и Закрыть файл                                                                                      |
|\033[32m Ctrl X        \033[0m | \033[32mS      \033[0m   | сэкономить несколько буферов                                                                                    |
|\033[32m Ctrl X        \033[0m | \033[32mEsc    \033[0m   | Получите приглашение «S-Lang» для интерфейса с интерпретатором S-Lang.                                          |
|\033[32m Ctrl @        \033[0m |           | Установить отметку (начать определение региона). Использование с аргументом префикса отменяет действие региона. |
|\033[32m Ctrl H        \033[0m |           | Вызвать систему справки                                                                                         |
|\033[32m Ctrl L        \033[0m |           | Перерисовать экран.                                                                                             |
|\033[32m Ctrl Пробел   \033[0m |           | Установить начало выделения (C-Пробел отменяет область выделения)                                               |
|\033[32m Ctrl Shift w  \033[0m |           | Вырезать                                                                                                        |";ES;fi;;
#
12) S=M12;SC;if [[ $cur == enter ]];then R;echo " печатает переменные версии и времени компиляции.";ES;fi;;
13) S=M13;SC;if [[ $cur == enter ]];then R;echo " печатает информацию об использовании";ES;fi;;
14) S=M14;SC;if [[ $cur == enter ]];then R;echo " запускает Jed в безопасном режиме, например вы не можете запускать какие-либо внешние команды с помощью system() или run_shell_cmd()";ES;fi;;
15) S=M15;SC;if [[ $cur == enter ]];then R;echo " запустить Jed в пакетном режиме. Это неинтерактивный режим.";ES;fi;;
16) S=M16;SC;if [[ $cur == enter ]];then R;echo "  Это режим, подобный --batch, но jed не оценивает файлы запуска. Он ведет себя как slsh. Вы должны предоставить файл, который должен быть оценен как второй аргумент.
 Это то же самое, что и вызов jed-скрипта.";ES;fi;;
#
17) S=M17;SC;if [[ $cur == enter ]];then R;echo " не загружайте файл .jedrc";ES;fi;;
18) S=M18;SC;if [[ $cur == enter ]];then R;echo " загрузить файл как пользовательский файл конфигурации вместо .jedrc";ES;fi;;
19) S=M19;SC;if [[ $cur == enter ]];then R;echo " Установите режим эмуляции. По умолчанию в Debian используется emacs. Другие допустимые варианты: vi, cua, ide.";ES;fi;;
20) S=M20;SC;if [[ $cur == enter ]];then R;echo "  goto line n в буфере (обратите внимание, что для того, чтобы эта опция вступила в силу, if должно появиться перед именем файла в командной строке,
 например 'jed +3 файл')";ES;fi;;
21) S=M21;SC;if [[ $cur == enter ]];then R;echo "  goto line n в буфере (обратите внимание, что для того, чтобы эта опция вступила в силу, if должно появиться после имени файла в командной строке,
 например 'jed file -g 3')";ES;fi;;
22) S=M22;SC;if [[ $cur == enter ]];then R;echo " загрузить файл как код S-Lang";ES;fi;;
23) S=M23;SC;if [[ $cur == enter ]];then R;echo " выполнить функцию S-Lang с именем function";ES;fi;;
24) S=M24;SC;if [[ $cur == enter ]];then R;echo " поиск строки вперед";ES;fi;;
25) S=M25;SC;if [[ $cur == enter ]];then R;echo " разделенное окно";ES;fi;;
26) S=M26;SC;if [[ $cur == enter ]];then R;echo " вставить файл в текущий буфер";ES;fi;;
#
27) S=M27;SC;if [[ $cur == enter ]];then R;./mJedB.sh;ES;fi;;
28) S=M28;SC;if [[ $cur == enter ]];then R;clear;exit 0;fi;;
 esac;POS;done
