# задаём переменные
DIR1=1c 
DIR2=auto
THIS=$(pwd) #путь до текущей директории

echo Введите номер группы:
    read NUMBER
    echo ======================
    are=$(find $THIS/ -name $NUMBER-attendance) 

    echo Выберите предмет # Выбор действия
        echo 1 - $DIR1
        echo 2 - $DIR2
    #Копируем исходный файл, чтобы можно было его изменять
    test $F == 1 && cp $THIS/$DIR1/$NUMBER-attendance $THIS/ || cp $THIS/$DIR2/$NUMBER-attendance $THIS/ 
    min=100
    max=0
    sed -i 's/[[:space:]]/:/' $THIS/$NUMBER-attendance #Заменяем все пробелы на :
     #Считываем содержимое каждой строки в отедельную переменную в fam запись фамилий в att - запись посещаемости 010101010
    while IFS=: read -r fam att;
            do
                i=0
                kol=0
                while [ $i -lt ${#att} ] #Итерируемся по содержимому переменной
                do 
                    test ${att:i:1} == '1' && ((kol++)) #Считаем количество посещенных занятий
                    ((i++))
                done
                test $kol -le 9 && sed -i "s/.*$fam.*/0$kol:&/" $THIS/$NUMBER-attendance || sed -i "s/.*$fam.*/$kol:&/" $THIS/$NUMBER-attendance #Добавляем в начале каждой строки количество занятий, которые посетил студент
            done < $THIS/$NUMBER-attendance 

    $SHELL