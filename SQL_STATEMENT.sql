########################SELECT PROJECTION####################################
SELECT PROJECTION - Вывод информации только о тех столбцах, которые нам нужны
#############################################################################

select * from employees;

select * from departments;

select * from regions;

select * from countries;

select country_id from countries;

select country_name, country_id from countries;

select first_name, last_name, salary from employees;

##############################################################################

SELECT * FROM JOB_ID;

SELECT JOB_ID FROM JOB_HISTORY;

SELECT DISTINCT JOB_ID FROM JOB_HISTORY;

SELECT DISTINCT JOB_ID, DEPARTMENT_ID FROM JOB_HISTORY;

SELECT DISTINCT EMPLOYEE_ID FROM JOB_HISTORY;

SELECT DISTINCT EMPLOYEE_ID, START_DATE, JOB_ID FROM JOB_HISTORY;

SELECT DISTINCT commission_pct FROM employees;

##############################################################################
ОБЪЕДИНЕНИЕ (КОНКАТЕНАЦИЯ)

select commission_pct, commission_pct/2 from employees;

select distinct commission_pct, commission_pct/2 from employees;

select * from job_history;

select start_date, end_date, (end_date-start_date) + 1 from job_history;

select start_date, start_date+7 from job_history;

concatenation = || - объединяет тексты

например, выводим слитную информацию имя+фамилия

select first_name||last_name from employees;

Объединим для примера имя и зарплату

select first_name||salary from employees;

select employee_id||salary from employees;

select 'My name is '||first_name||' and my surname is '||last_name 
                                                                from employees;

select 'A'||commission_pct||'B' from employees;

##############################################################################
ALIAS-альтернативное имя для столбца или целевого значения


select 'My name is '||first_name||' and my surname is '||last_name 
                                                                from employees;
В этом случае название столбца сложное. Назовем получаемый столбец name. Для
этого используем следующее выражение

select 'My name is '||first_name||' and my surname is '||last_name NAME
                                                                from employees;
ИЛИ

select 'My name is '||first_name||' and my surname is '||last_name as NAME
                                                        from employees;
                                 
Другой пример

select commission_pct from employees;

Колонка называется OMMISSION_PCT. Пусть она будет называться COMMISSION

select commission_pct commission from employees;

select first_name fn, last_name ln, commission_pct pct from employees;

Рассмотрим следующий пример. Обратим внимание на название полученного столбца

select start_date, end_date, (end_date-start_date) + 1 from job_history;

Исправим это

select start_date, end_date, (end_date-start_date) + 1 "Count of days" from job_history;

#############################################################################
Таблица DUAL

select 'abc' || 'xyz' || (90*30) as result from dual;

select * from dual;

desc dual;

select 'Hello '|| 'world!' as greeting from dual;

Выведем возраст в секундах используя dual (Таблица с одним столбцом, одной строкой)

select 25 * 365 * 24 * 60 * 60 "25 years in seconds" from dual;

Используем dual для вычисления значений

select 25+32*2 from dual;

Грамотное используем ковычки

select 'It''s my life' from dual;

select 'It"s my life' from dual;

Использование q-оператора

select q'<It's my life>' from dual;

#############################################################################
Шаблон выражения select

SELECT *|{DISTINC column(s) alias, expression(s) alias} FROM table ;

#############################################################################
homework_2

select * from employees;

select * from REGIONS;

select first_name, department_id, salary, last_name from hr.employees;

select employee_id, email, hire_date, hire_date-7 as "One week before hire date" 
                                                                from employees;
                                                                
select first_name||'('||job_id||')' as "our_employees" from employees;

select distinct first_name from employees;

select job_title from jobs;

select 'min ='||min_salary||','||' max = '||max_salary as info from jobs;

select max_salary, max_salary*2-2000 as new_salary from jobs;

select q'<Peter's dog is very clever>' from dual;

select 'Peter''s dog is very clever' from dual;

select 'count minutes in one century is '||100 * 365.25 * 24 * 60 from dual;


#############################################################################
#####################SELECT SELECTION########################################
Концепция SELECT SELECTION это выбор строк из таблиц и определение ограничений

SELECT * |{DISCINCT column(s) alias, expression(s) alias} from table
                                                            WHERE condition(s);

SELECT * FROM EMPLOYEES;
SELECT  first_name, last_name from employees where salary = 17000;

select first_name, salary from employees where last_name = 'King';

select * from employees where hire_date = '24.MAR.08';

select * from departments where location_id = 1700;

select * from employees where employee_id = manager_id + 1000/10+1;

select * from job_history where job_id='ST_CLERK';

select * from employees where first_name = last_name;

select * from employees 
where 'Dr '||first_name||' '||last_name = 'Dr Hermann Baer';

select * from employees 
where 'Dr Hermann Baer' = 'Dr '||first_name||' '||last_name;

select * from job_history where end_date = start_date + 364;


############################################################################
Операторы сравнения
=, >, <, >=, <=, !=, <>

select first_name, last_name, salary from employees where salary < 10000;

select * from employees where first_name >= 'Bruce';

select * from job_history where start_date < '01.JAN.05';


BETWEEN
select first_name, last_name, salary from employees
where salary between 4000 and 10000;

select * from job_history where start_date between '01.JAN.05' and '01.JAN.09';

select * from employees where first_name between 'A' and 'C';

select * from employees where
salary >= 4000 and salary <= 10000;

IN
select * from departments where
location_id in (1700, 2400, 1500);

select * from job_history;
desc job_history;

select * from job_history where job_id in ('IT_PROG', 'SA_REP');

select * from job_history where end_date in ('31.DEC.07', '28.JAN.08');


select * from departments where
location_id in (1700, 2400, 1500) or
location_id = 1500;


IS NULL
select * from employees where commission_pct is null;


LIKE, %, _
select * from employees where first_name = 'Steven';
select * from employees where first_name like 'S%';
% - специ символ, котоырй означает, что после буквы S может быть любое
количесвто символов
select * from employees where first_name like '%r';
select * from employees where first_name like 'A%r';

select * from employees where first_name like 'D_n';
_ - спецсимвол, который означает, что между буквами D и N может стоять
только один символ
select * from employees where first_name like 'A%d%';

select * from employees where first_name like '__n%';

select * from employees where job_id like 'ST_%';

Чтобы _ отображался как обычныый символ, необходимо использовать escape
select * from employees where job_id like 'ST\_%' escape '\';

##############################################################################
ЛОГИЧЕСКИЕ ОПЕРАТОРЫ 

select * from employees
where first_name like 'D%' and salary > 7000 and job_id = 'SA_REP';

select * from employees
where first_name like 'D%' or salary > 7000 or job_id = 'SA_REP';

select * from employees where not job_id = 'SA_MAN';
Красивая запись
select * from employees where NOT (job_id = 'SA_MAN');

select * from employees where last_name NOT like 'K%';

select * from employees where  job_id not IN ('SA_MAN', 'ST_CLERK');

select * from employees where salary NOT between 5000 and 6000;

select * from employees where commission_pct is not null;

select * from employees where commission_pct is not null 
AND last_name NOT like '%n';


Приоритетность операторов
приоритет у AND выше чем у OR

select * from employees;

select * from employees
where first_name like '__n%' and commission_pct is null;

select * from employees
where first_name like 'A%' and job_id = 'SA_REP';

Проверка заключается в том, что сначала мы запускаем скрипт без использования 
скобок и получаем результат из 15 строк. 
В случае, если приоритетность у AND действительно выше, поставив скобки и
запустив скрипт разницы не будет, вывод останется прежним.

select * from employees
where (first_name like '__n%' and commission_pct is null)
OR 
(first_name like 'A%' and job_id = 'SA_REP');

Далее мы окружаем скобками условия OR. Получаем в результате отсутствие строк 
select * from employees
where first_name like '__n%' and (commission_pct is null
OR 
first_name like 'A%') and job_id = 'SA_REP';

Рассмотрим случай, когда приоритетность работает слева направо
select * from employees
where ((first_name like '__n%' and commission_pct is null)
OR 
first_name like 'A%') and job_id = 'SA_REP';

Таким образом, сначала отрабатывают все AND и только потом запускается OR

select * from employees;
where first_name like '__n%' and (commission_pct is null
OR 
first_name like 'A%') and job_id = 'SA_REP';
select first_name, last_name, salary, department_id, job_id, commission_pct
from employees
where last_name like '%i%' and salary > employee_id * 50
OR
job_id in ('IT_PROG', 'PU_CLERK') and commission_pct is null;

############################################################################
ORDER BY помогает упорядочивать (сортировать) output

СХЕМА
SELECT *|{DISTINCT column(s) alias, expression(s) alias}
FROM table
WHERE condition(s)
ORDER BY {col(s)|expr(s)|numeric position}
{ASC|DESC}{NULLS FIRST|LAST};

EXAMPLE
select first_name, salary from employees
order by salary;

select first_name, salary from employees
where job_id = 'IT_PROG'
order by salary;

select first_name, salary, hire_date from employees
where job_id = 'IT_PROG'
order by hire_date;

select first_name, salary, hire_date from employees
where job_id = 'IT_PROG'
order by first_name;

Сортировка по возрастанию: ASC (Используется по умолчанию)
select first_name, salary, hire_date from employees
where job_id = 'IT_PROG'
order by first_name ASC;

Сортировка по убыванию: DESC
select first_name, salary, hire_date from employees
where job_id = 'IT_PROG'
order by first_name DESC;

select last_name, salary, hire_date, hire_date+salary * 2 summ
from employees
where employee_id > 120
order by summ;

select * from employees order by commission_pct desc;

Пусть значения NULL Будут в конце
select * from employees order by commission_pct desc nulls last;

Пусть значения NULL Будут в начале
select * from employees order by commission_pct asc nulls first;

когда мы используем oeder by, мы можем не прописывать имя столбца, мы можем 
указать его порядковый номер

Сортировка, например, по salary. Номер определяется из select листа
select first_name, salary from employees order by 2;


Сортировка по нескольким столбцам
select job_id, first_name, salary, hire_date
from employees
order by job_id desc, last_name, 4 desc;

##############################################################################
homework_3

select * from employees
where first_name = 'David';

select * from employees
where first_name like 'David';


select * from employees 
where job_id = 'FI_ACCOUNT';

select first_name, last_name, salary, department_id from employees
where department_id = 50
and salary > 4000;

select * from employees
where department_id = 20
or
department_id = 30;

select * from employees
where first_name like '_a%a';

select * from employees
where department_id in (50, 80) 
and commission_pct is not null
order by email ASC;

select * from employees
where (department_id = 50 or department_id = 80)
and commission_pct is not null
order by email ASC;

select * from employees
where first_name like '%n%n%';

select * from employees
where LENGTH(first_name) > 4
order by department_id desc nulls last;

select * from employees 
where salary between 3000 and 7000
and commission_pct is null
and job_id in ('PU_CLERK', 'ST_MAN', 'ST_CLERK');

select * from employees
where first_name like '\%' escape '\';

select * from employees;
select job_id, first_name, salary from employees
where employee_id >= 120
and job_id != 'IT_PROG'
order by job_id ASC, first_name desc;

##############################################################################
##############################################################################
FUNCTIONS
Бывают
        - Single-row,
        - Multiple-row
        
        
Single-row: Character functions
Функции, которые работают с тексом: 

select * from employees;
select first_name, LOWER(first_name) from employees;

___________________________________________________
LOWER() - Функция работает с буквами. Приводит все к нижнему регистру

select * from employees where LOWER(first_name) = 'david';
select * from employees where LOWER(first_name) like '%en%';

select LOWER(2+2*2) from dual;
select LOWER('HELLO'||'HOW OLD ARE YOU?'||25) from dual;

___________________________________________________
UPPER() - Функция работает с буквами. Приводит все к верхнему регистру


select * from employees where UPPER(first_name) like '%EN%';
select * from employees where UPPER(first_name) = 'DAVID';

___________________________________________________
INITCAP(S) -В каждом слове текста, первую букву делает большой, 
                                                        остальные маленькими

select INITCAP('HELLO'||' HOW OLD ARE YOU? '||25) from dual;
select INITCAP('hello'||' how old are you? '||25) from dual;

SELECT INITCAP('NAME IS '||FIRST_NAME||' AND SURNAME IS '||LAST_NAME) FULL_NAME 
FROM EMPLOYEES;

____________________________________________________
CONCAT(s,s) -функция конкатенации. Принимает две строки. Выполняет то же самое,
что и ||

select concat('Hello ',' How are you?') from dual;
То же самое
select 'Hello '||'How are you?' from dual;

select concat(salary*2, hire_date) from employees;
____________________________________________________
Функция, которая возвращает текущую дату
select SYSDATE from dual; 
____________________________________________________

select concat('today is ', SYSDATE) from dual;
select concat('today is ', concat('current date ', SYSDATE)) from dual;


____________________________________________________
LENGTH() -функция, которая измеряент длину строки

select first_name, length(first_name) DLINA from employees;
select LENGTH('Alex Vasilev') from dual;

select country_name from countries where length(country_name) > 8;

select country_name from countries order by length(country_name);


___________________________________________________________
Функции LPAD(s,n,p) и RPAD(s,n,p)
L - left, R - right
Функции добавляют новые символы слева и справа строки

select LPAD('Alex', 7, '#') from dual;
select RPAD('Alex', 7, '#') from dual;
select first_name, LPAD(first_name, 25, '$') from employees;

select first_name, LPAD(first_name, 25, '$'), 
RPAD(first_name, 25, '$')
from employees;

select RPAD(first_name, 15, ' ')||LPAD(salary, 8, ' ') from employees;


_________________________________________________
Trim -ф, которая удаляет символ в начале или в конце текста
В основном используется для удаления лишних пробелов Сначала и Сконца строки
TRIM({trailing|leading|both} trimstring from s)

Удаление с конца
select TRIM(trailing 'q' from 'Alex qqqqqqqqq') from dual;
Удаление с начала
select TRIM(leading 'u' from 'uuuuuuuuuAlex') from dual;
Удаление с обоих концов
select TRIM(both 'u' from 'uuuuuuuuuAlexuuuuuu') from dual;
select TRIM('u' from 'uuuuuuuuuAlexuuuuuu') from dual;
Удаление пробелов - можно отдельно не указывать пробел. Достаточно указать 
корректируемую строку
select TRIM(' ' from '       Alex         ') from dual;
select TRIM('       Alex         ') from dual;



____________________________________________________________________________
CHARACTER FUNCTIONS

___________________________________________________________________________
instr(s, search string, start position Nth occurrence)

Где 
s - это строка, текст
search string - искомый текст
start position - позиция, для начала работы
Nth occurrence - N-ое появление


select * from employees;
select * from employees where instr(job_id, 'PROG')=4;

'=4' это позиция, с которой мы начинаем искать наш 'PROG'
в колонке JOB_ID мы можем иметь IT_PROG
В данном случае PROG начинается с 4 позиции

select * from employees where instr(hire_date, 'MAY')=4;
select * from employees where instr(SALARY, '2')=2;

Следующий пример:
SELECT INSTR('ALEKSEI VASILEV', 'V') FROM DUAL;

Далее рассмотрим start position и Nth occurrence
SELECT INSTR('ALEKSEI VASILEV', 'A', 2, 1) FROM DUAL;

Первая 2 означает, что поиск начинается со второй позиции, то есть поиск будет 
в LEKSEI VASILEV
По умолчанию, мы ищем первое значение, в примере мы найдем первую "А", но
мы можем прописать, чтобы искался номер этого значения, который идет по счету 
вторым, третьим и тд. Для этого мы указываем второй числовой параметр. В нашем
случае это 1


___________________________________________________________________________
SUBSTR(s, start position, number of characters)

Где
s - это строка, текст
search string - искомый текст
number of characters - количество символов


select * from employees;
select email, SUBSTR(email, 4) from employees;
select email, SUBSTR(email, 4, 2) from employees;
select SUBSTR('Hello! How are you?', 7, 8) from dual;

Если использовать отрицательное число, то отсчет будет не слева направо,
а справа налево
select SUBSTR('Hello! How are you?', -9) from dual;


select salary, SUBSTR(hire_date, 2, 3) from employees;


__________________________________________________________________________
REPLACE(s, search item, replacement item)- замена
Где
search item - искомый элемент
replacement item - заменяющий элемент

SELECT REPLACE('HELLO! HOW ARE YOU? WHATS NEW?', 'O', 'AAAA') FROM DUAL;

Если нет информации, на что происходит замена, происходит удаление
SELECT REPLACE('HELLO! HOW ARE YOU? WHATS NEW?', 'O') FROM DUAL;

select salary, REPLACE(salary, '1', '9') from employees;


___________________________________________________________________________
NUMERIC FUNCTIONS

ROUND(n, precision)
ГДЕ
n - число
precision - точность


select ROUND(3.14) from dual;
select ROUND(3.14728, 1) from dual;
select ROUND(3.14728, 2) from dual;
select ROUND(3.14728, 3) from dual;
select ROUND(3.14728, 4) from dual;

select salary*3.1415 from employees;
select salary*3.1415, ROUND(salary*3.1415) from employees;


select ROUND(356826, -1) from dual;
select ROUND(356826, -2) from dual;
select ROUND(356826, -3) from dual;

select SYSDATE - hire_date from employees;
select first_name, ROUND(SYSDATE - hire_date) bonus from employees;


__________________________________________________________________________
TRUNC(n, precision)
ROUND ОКРУГЛЯЕТ В БОЛЬШУЮ СТОРОНУ, А TRUNC ПРОСТО ОТСЕКАЕТ

select ROUND(3.56798, 3) from dual;
select TRUNC(3.56798, 3) from dual;

select TRUNC(356826, -2) from dual;

select first_name, ROUND(SYSDATE - hire_date) bonus,
TRUNC(SYSDATE - hire_date) BONUS2 from employees;

__________________________________________________________________________
MOD(dividend, divisor)
devidend - делимое
divisor - делитель

MOD определяет остаток от деления

select MOD(7, 3) from dual;
select MOD(3.2, 2.1) from dual;

select * from employees where mod(employee_id, 2) = 0;

select employee_id, first_name, last_name, MOD(employee_id, 3)+1 Team
from employees;



__________________________________________________________________________
DATE FUNCTIONS

__________________________________________________________________________
SYSDATE
select * from JOB_HISTORY;
select * from nls_session_parameters where parameter='NLS_DATE_FORMAT';

select SYSDATE from dual;
SYSDATE возвращает дату нашего database сервера!
сложение, умножение и деление дат запрещено

select sysdate, sysdate-5, sysdate+5, sysdate+5.5 from dual;

select TO_CHAR(sysdate, 'DD-MM-RR hh24:mi:ss') from dual;

select * from employees;

select sysdate-hire_date from employees;


__________________________________________________________________________
MONTHS_BETWEEN(end_date, start_date)

Возвращает количество месяцев между датами
Где 
start_date - дата "с",
end_date - дата "по"




select * from job_history;
select employee_id, MONTHS_BETWEEN(end_date, start_date) from job_history;

select MONTHS_BETWEEN('30.MAR.22', '29.MAR.22') from dual;
select MONTHS_BETWEEN('30.MAR.22', '29.MAR.22')*31 from dual;

__________________________________________________________________________
ADD_MONTHS(date, number_of_months)
date - дата
Number_of_months - количество месяцев, которые мы будем добавлять в датах

select * from job_history;
select end_date, ADD_MONTHS(end_date, 4) from job_history;
select end_date, ADD_MONTHS(end_date, -4) from job_history;
select ADD_MONTHS('30.SEP.22', 1) from dual;
select ADD_MONTHS('31.DEC.22', 2) from dual;

Ищем сотрудников, которые на текущий период проработали более 5 месяцев
select * from employees where MONTHS_BETWEEN('01.JAN.10', hire_date) > 60;

__________________________________________________________________________
NEXT_DAY
Функция позволяет найти ближайшую дату интересующего дня недели
Например, нас интересует дата следующего понедельника
select NEXT_DAY(sysdate, 1) from dual;

select * from sys.nls_session_parameters;

select NEXT_DAY(sysdate, 'WEDNESDAY') from dual;

select  NEXT_DAY('31.DEC.22', 'MONDAY')-7 from dual;

__________________________________________________________________________
LAST_DAY(date, day_of_the_week)
Функция показывает последний день месяца

select LAST_DAY(sysdate) from dual;
select hire_date, last_day(hire_date)-hire_date has_worked from employees;


__________________________________________________________________________
Для date ROUND(date, date precision format)

date - дата
date precision format - точность округления

Вес - СС
Год - YYYY
Четверть - Q
Месяц - ММ
Неделя - W
День - DD
Час - HH
Минута - MI


select hire_date from employees where employee_id IN (120, 121);

select hire_date, ROUND(hire_date, 'YYYY') from employees 
                                                where employee_id IN (120, 121);
                                                
select hire_date, ROUND(hire_date, 'MM') from employees 
                                                where employee_id IN (120, 121);


Если не указывать параметр округления, по умолчанию оно будет до дня                                             
select hire_date, ROUND(hire_date) from employees 
                                                where employee_id IN (120, 121);
                                                
___________________________________________________________________________
Для date TRUNC(date, date precision format)

select hire_date, TRUNC(hire_date, 'CC') from employees 
                                                where employee_id IN (120, 121);

select hire_date, TRUNC(hire_date, 'MM') from employees 
                                                where employee_id IN (120, 121);
                                                
                                                
#############################################################################
homework_4

select * from employees;
select * from employees
where LENGTH(first_name) > 10;

select * from employees 
where MOD(salary, 1000) = 0;

DESC employees;

select first_name, phone_number, SUBSTR(phone_number, 0, 3)  from employees
where phone_number like '___.___.____';

select first_name from employees
where SUBSTR(first_name, -1) = 'm' and LENGTH(first_name) > 5;

select NEXT_DAY(sysdate, 6) FROM DUAL;

select * from employees;
where  sysdate -  from dual;

select * from employees
where MONTHS_BETWEEN(sysdate, hire_date) > 150;

select first_name, REPLACE(phone_number, '.', '-') from employees;

select UPPER(first_name), LOWER(email), INITCAP(job_id) from employees;

select CONCAT(first_name, salary) from employees;

select hire_date, ROUND(hire_date, 'MM'), ROUND(hire_date, 'YYYY')
from employees;
или
select hire_date, ROUND(hire_date, 'MM'), TRUNC(hire_date, 'YYYY')
from employees;

select rpad(first_name, 10, '$'), lpad(last_name, 15, '!') from employees;

SELECT INSTR('ALEKSEI VASILEV', 'A', 2) FROM DUAL;

SELECT first_name, INSTR(first_name, 'a', 1, 2) from employees;

select '!!!HELLO!!!MY FRIEND!!!', TRIM(both '!' from '!!!HELLO!!!MY FRIEND!!!')
from dual;

select salary, salary*3.145, round(salary*3.145, 0), 
trunc(salary*3.145, -3)/1000
from employees;

select hire_date, ADD_MONTHS(hire_date, 6), LAST_DAY(hire_date) from employees;


#############################################################################
#############################################################################

CONVERSION FUNCTIONS

Это функции, которые позволяют конвертировать данные из одного типа в другой

TO_CHAR
TO_DATE
TO_NUMBER

select LENGTH(123) from dual;
select * from countries;
insert into countries values ('ZZ', '10', 1);
select * from countries where country_name = 10; не срабатывает
select LENGTH(SYSDATE) from dual;
select add_months('05-JUN-22', 3) from dual;

select next_day('06-APR-22', 1) from dual;
В американском стандарте первым днем является не понедельник, а воскресенье

select next_day('06-APR-22', 'MON') from dual;

___________________________________________________________________________
TO_CHAR

Перевод числа в текст или даты в текст

-TO_CHAR(number to char)

TO_CHAR(number, format mask, nls_parameters) = T

Конвертация числа в текст, используя эту функцию означает взять число и сделать
из него текст в том виде, в каком указан наш формат, если такой имеется

select TO_CHAR(18) from dual;

select * from countries;
insert into countries values ('ZZ', '10', 1);
select * from countries where country_name = TO_CHAR(10);


select TO_CHAR(18, '99999') from dual;
select TO_CHAR(181818, '99999') from dual;

select TO_CHAR(18, '099999') from dual;
select TO_CHAR(181818, '099999') from dual;
select TO_CHAR(1818, '099999') from dual;

select TO_CHAR(18.35, '099999.999') from dual;

select TO_CHAR(18.35, '099999D999') from dual;

select TO_CHAR(1234567, '99,999,999') from dual;
select TO_CHAR(12345671919, '99,999,999') from dual;

select TO_CHAR(1234567, '99G999G999') from dual;

select TO_CHAR(18, '$9999') from dual;
select TO_CHAR(18, '$09999') from dual;

select TO_CHAR(18, 'L09999') from dual;

select TO_CHAR(18, '999MI') from dual;
select TO_CHAR(-18, '999MI') from dual;
select TO_CHAR(-18, 'MI999') from dual; Выходит ошибка

select TO_CHAR(-18, '0999PR') from dual;
select TO_CHAR(18, '0999PR') from dual;

select TO_CHAR(-18, 'S099') from dual;

select first_name, salary*1.111, 
TO_CHAR(salary*1.111, '$999,999.99'),
TO_CHAR(salary*1.111, '$9,999.99')
from employees;


-TO_CHAR(date  to char)
TO_CHAR(number, format mask, nls_parameters) = T

select TO_CHAR('31-JUL-85') from dual;

Конвертация даты в текст, используя указанную функцию означает взять дату и 
сделать из нее текст в том виде, в каком указан наш формат, если такой 
имеется

select TO_CHAR('31-JUL-85', 'Y') from dual; Ошибка

select TO_CHAR(SYSDATE, 'Y') from dual; 

select TO_CHAR(SYSDATE, 'YY') from dual; 

select TO_CHAR(SYSDATE, 'YYY') from dual; 

select TO_CHAR(SYSDATE, 'YYYY') from dual; 

select TO_CHAR(SYSDATE, 'RR') from dual; 

select TO_CHAR(SYSDATE, 'YEAR') from dual; 
select TO_CHAR(SYSDATE, 'year') from dual; 
select TO_CHAR(SYSDATE, 'Year') from dual; 

select TO_CHAR(SYSDATE, 'mm') from dual; 
select TO_CHAR(SYSDATE, 'MON') from dual; 
select TO_CHAR(SYSDATE, 'MONTH') from dual; 
select TO_CHAR(SYSDATE, 'month') from dual; 

select hire_date, TO_CHAR(hire_date, 'Month') from employees;
select hire_date, TO_CHAR(hire_date, 'Month', 'NLS_DATE_LANGUAGE = RUSSIAN')
from employees;

select hire_date, TO_CHAR(hire_date, 'Month')||'HELLO' from employees;
select hire_date, TO_CHAR(hire_date, 'fmMonth')||'HELLO' from employees;

select first_name, hire_date 
from employees where TO_CHAR(hire_date, 'fmMonth') = 'August';

select TO_CHAR(SYSDATE, 'd') from dual; 

select TO_CHAR(SYSDATE, 'dd') from dual; 

select TO_CHAR(SYSDATE, 'ddd') from dual; 

select TO_CHAR(SYSDATE, 'dy') from dual; 
select TO_CHAR(SYSDATE, 'Dy') from dual; 
select TO_CHAR(SYSDATE, 'DY') from dual; 
select TO_CHAR(SYSDATE, 'DY') from dual; 
select TO_CHAR(SYSDATE, 'DAY') from dual; 

select TO_CHAR(SYSDATE, 'w') from dual; 
select TO_CHAR(SYSDATE, 'ww') from dual; 

select TO_CHAR(SYSDATE, 'Q') from dual; 

select TO_CHAR(SYSDATE, 'CC') from dual; 


select TO_CHAR(SYSDATE, 'A.M.') from dual; 
select TO_CHAR(SYSDATE, 'P.M.') from dual; 

select TO_CHAR(SYSDATE, 'HH') from dual; 
select TO_CHAR(SYSDATE, 'HH:MI') from dual; 
select TO_CHAR(SYSDATE, 'HH24') from dual; 

select TO_CHAR(SYSDATE, 'MI') from dual; 

select TO_CHAR(SYSDATE, 'SS') from dual; 

select TO_CHAR(SYSDATE, 'SSSSS') from dual; 

select TO_CHAR(SYSDATE, 'DAY!Mon?yyy') from dual; 

select TO_CHAR(SYSDATE, '"quarter"q"of"year""') from dual; 
select TO_CHAR(SYSDATE, '"quarter "q" of "year" "') from dual; 

select TO_CHAR(SYSDATE, 'DDth " of "mm') from dual; 

select TO_CHAR(SYSDATE, 'yyyysp mmsp ssssssp') from dual; 

select TO_CHAR(SYSDATE, 'yyyysp') from dual; 

select TO_CHAR(SYSDATE, 'MIthsp') from dual; 

select 'my colleague with ID = '||employee_id||' and job ID = '||job_id||
' joined us on '|| TO_CHAR(hire_date, 'fmDay "the "ddTH "of " fmMonth YYYY')
from employees;


___________________________________________________________________________
TO_DATE

Конвертирует текст в дату

TO_DATE(text, format mask, nls_parameters)=D

select TO_CHAR(TO_DATE('08!MAR?19'), 'dd-mon-yyyy hh24:mi:ss') from dual; 

select TO_DATE('08!MAR?2019') from dual;

Конвертация текста в дату, используя функцию TO_DATE означает взять текст
и объяснить в своем формате, где и как содержится информация о элементах даты
в вашем тексте 

select TO_DATE('18:40 2019!17-Sep', 'HH24:mi yyyy!dd-Mon') from dual;
select TO_DATE('18:40 2019!Sep', 'HH24:mi yyyy!Mon') from dual;

select TO_CHAR(
TO_DATE('28-Sep-19 15:16:17', 'dd-Mon-RR hh24:mi:ss'), 'dd-Mon-RR hh24:mi:ss')
from dual;

select TO_CHAR(
TO_DATE('28-Sep-19 15:16:17', 'dd-Mon-RR hh24:mi:ss'), 'hh24:mi:ss')
from dual;

select TO_DATE('18-SEP-10', 'fxDD-MON-YYYY') from dual;
fx подразумевает, что формат 'fxDD-MON-YYYY' будет соответствовать точь 
в точь '18-SEP-10', иначе не получится создать из текста дату


Плохая практика
select * from employees
where hire_date > '01.JAN.05';

Хорошая практика
select * from employees
where hire_date > TO_DATE('01-JAN-05','dd-MON-RR');

select TO_CHAR('18-SEP-10', 'Month') from dual;

select TO_CHAR(TO_DATE('18-SEP-10', 'DD-MON-RR'), 'Month') from dual;


select TO_CHAR(TO_DATE('15?1987.7.18.19/09', 'hh24?YYYY.MI.SS.DD/mm'),
'dd-MON-yyyy hh24:mi:ss') alias from dual;


___________________________________________________________________________
TO_NUMBER

TO_NUMBER(text, format mask, nls_parameters)=N

select TO_NUMBER('4555.77') from dual;
select TO_NUMBER('4,555.77') from dual;

select TO_NUMBER('$4555.77', '$99999999999999.999') from dual;

Конвертация текста в число, используя функцию TO_NUMBER означает взять текст и
объяснить в своем формате, где и как содержится информация о элементах числа в
вашем тексте.


select TO_NUMBER('4,555.77', '999,999.99') from dual;

select TO_NUMBER('<4,555.77>', '99999.999PR') from dual; 

select TO_CHAR(3.17, '99.9') from dual; здесь 3.17 это число, которое округляется
select TO_NUMBER(3.17, '99.9') from dual; здесь 3.17 это текст, который не окр


#############################################################################
#############################################################################

Nested functions

ПРИМЕР ИЗ ПОЗАПРОШЛОГО УРОКА
select TO_CHAR(TO_DATE('15?1987.7.18.19/09', 'hh24?YYYY.MI.SS.DD/mm'),
'dd-MON-yyyy hh24:mi:ss') alias from dual;

select LENGTH(UPPER(SYSDATE)) from dual;
select SUBSTR(sysdate, 4) from dual;

select first_name, LENGTH(first_name), ROUND(123.456789123456,
LENGTH(first_name))
from employees;

select first_name, employee_id, LENGTH(employee_id),
SUBSTR(first_name, LENGTH(employee_id)),
LENGTH(SUBSTR(first_name, LENGTH(employee_id)))
from employees;

select TO_DATE('18-09-87', 'DD-MM-RR'),
TO_CHAR(TO_DATE('18-09-87', 'DD-MM-RR'), 'DAY'),
LENGTH(TO_CHAR(TO_DATE('18-09-87', 'DD-MM-RR'), 'fmDAY'))
from dual;

'fmDAY' -  fm для того, чтобы избавиться от лишних пробелов

select first_name, last_name, phone_number,
TO_NUMBER(SUBSTR(phone_number, INSTR(phone_number, '.') + 1), '999.9999') * 10000
form_number
from employees
where employee_id < 130;

#############################################################################
#############################################################################

GENERAL FUNCTIONS

NVL

NVL(value, ifnull)

select NVL(18, 19) from dual;

NVL проверяет первый параметр (в примере это 18), если он не null, 
то возвращается этот параметр, а если он null, то возвращается 
второй параметр (В нашем примере это 19)

select first_name, NVL(commission_pct, 0)
from employees;

select first_name, NVL(SUBSTR(first_name, 6), 'name is too short')
from employees;

select first_name, commission_pct, NVL(salary*commission_pct, 0) + 500 bonus
from employees;

___________________________________________________________________________
NVL2

NVL2(value,  ifnotnull, ifnull)


select NVL2(17, 18, 19) from dual;
select NVL2(null, 18, 19) from dual;

select first_name, NVL2(commission_pct, commission_pct, 0)
from employees;

select first_name, NVL2(commission_pct, 'there is commission_pct',
'there is not commission_pct')
from employees;

___________________________________________________________________________
NULLIF(value1, value2)

Эта функция возвращает null если value1 = value2
возвращает первый параметр, если value1 != value2

select NULLIF(18, 18) from dual;
select NULLIF(17, 18) from dual;

select NULLIF(18, 1||8) from dual;
select NULLIF(1||8, 18) from dual;
select NULLIF('18', 18) from dual;

select NULLIF('18-SEP-87', '18/SEP/87') from dual;
select NULLIF(TO_DATE('18-SEP-87'), TO_DATE('18/SEP/87')) from dual;

select *
from countries;

select country_id, country_name,
NVL2(NULLIF(country_id, UPPER(SUBSTR(country_name, 1, 2))), 'no match found', 
'match found') match
from countries;

___________________________________________________________________________
COALESCE(value1, value2, ..., valueN)

Функция COALESCE принимает минимум два параметра, максимум сколько угодно.
Функция возвращает первое значение, которое не NULL.

select COALESCE(1, null, 2) from dual;

select COALESCE(null, null, 'ok', 'hello') from dual;
select COALESCE(null, null, null, null) from dual;
select COALESCE(17, 18) from dual;

COALESCE(value1, value2) = NVL(value1, value2)

COALESCE(value1, value2, value3) = NVL(value1, NVL(value2, value3))

select first_name, commission_pct, manager_id, salary,
COALESCE(commission_pct, manager_id, salary) info
from employees;

____________________________________________________________________________
DECODE

DECODE(expr, comp1, iftrueq, comp2, iftrue2,..,compN, iftrueN, iffalse)

select DECODE(3*4, 12, 'twelve') from dual;

Если второй параметр равен первому параметру, то мы выводим третий параметр

select DECODE(3*4, 13, 'twelve') from dual;


select DECODE(3*4, 13, 'thirteen', 14, 'fourteen', 12, 'twelve')
from dual;

select DECODE(null, 5, 'ok', null, 'koko') from dual;

select DECODE(2+2*2, 5, 'five', 12/2, 'six', 6, 'six2') from dual;

select first_name, commission_pct,
DECODE(commission_pct, null, 'do not have commission',
0.1, 'no much commission', 0.4, 'a lot of commission', 'standart commission') 
from employees where employee_id between 140 and 180;

____________________________________________________________________________
CASE simple

select 
CASE 3*4
WHEN 12 THEN 'twelve'
END
from dual;

select 
CASE 3*4
WHEN 11 THEN 'eleven'
WHEN 24/2 THEN 'twelve'
WHEN 12 THEN 'twelve1'
ELSE 'MILLION'
END
from dual;


select first_name,
CASE LENGTH(first_name)
WHEN 4 THEN 'Very small name'
WHEN 5 THEN 'Small name'
WHEN 6 THEN 'Middle length name'
WHEN 7 THEN 'Long length name'
WHEN 8 THEN 'Very lomg length name'
ELSE 'The length is not undefined'
END
from employees;


_____________________________________________________________________________
CASE searched

select 
CASE 
WHEN 3*4=12 THEN 'Twelve'
END
from dual;


select 
CASE 
WHEN 3*4=11 THEN 'eleven'
WHEN 3*4=24/2 THEN 'twelve'
WHEN 3*4=12 THEN 'twelve1'
ELSE 'MILLION'
END AS "CASE STATEMENT"
from dual;

select first_name,
CASE 
WHEN LENGTH(first_name)=4 THEN 'Very small name'
WHEN LENGTH(first_name)=5 THEN 'Small name'
WHEN LENGTH(first_name)=6 THEN 'Middle length name'
WHEN LENGTH(first_name)=7 THEN 'Long length name'
WHEN LENGTH(first_name)=8 THEN 'Very lomg length name'
ELSE 'The length is not undefined'
END
from employees;

select first_name, salary, commission_pct,
CASE
WHEN length(first_name)<=5 THEN 'first variant'
WHEN salary*10 > 100000  THEN 'second variant'
WHEN commission_pct is not null THEN 'third variant'
ELSE 'No variant'
END as "Case statement"
from employees;


#############################################################################
homework_5

select *
from employees
where INSTR(UPPER(first_name), 'B')>0;


select *
from employees
where INSTR(UPPER(first_name), 'A', 1, 2)>0;

Указываем, что начинаем поиск с первого символа и ищем второе совпадение

select SUBSTR(department_name, INSTR(department_name, ' ', -1)) as "first word"
from departments
where INSTR(department_name, ' ')>0;

                                                 
select first_name, SUBSTR(first_name, 2, length(first_name)-2) from employees;


select * 
from employees
where length(substr(job_id, instr(job_id, '_')+1))>=3
and
substr(job_id, instr(job_id, '_')+1) != 'CLERK';

select *
from employees
where hire_date = trunc(hire_date, 'mm');

select *
from employees
where trunc(hire_date,'YYYY') = to_date('01.JAN.2008', 'dd-MON-RR');

select 
to_char(sysdate+1,'"Tomorrow is "ddspth" day of "fmMonth')
from dual;

select first_name, last_name, to_char(hire_date, 'ddth" of "month, fmyyyy')
hire_date
from employees;

select 
first_name,
last_name,
salary,
to_char(salary*1.2, '$999,999.00') new_salary
from employees;


select 
sysdate,
sysdate+1/(24*60*60) plus_second,
sysdate+1/(24*60)    plus_minute,
sysdate+1/24         plus_hour,
sysdate+1            plus_day,
sysdate+30           plus_month,
sysdate+365          plus_year
from dual;

select first_name, last_name, salary old_salary,
salary + to_number('$12,345.55', '$99,999.99')
from employees;

select first_name, hire_date, to_char(hire_date, 'day') hire_day,
months_between(
to_date('SEP, 18:45:00 18 2009', 'Mon, hh24:mi:ss dd yyyy'), hire_date)
from employees;

select first_name, salary,commission_pct,
to_char(salary + salary * NVL(commission_pct, 0), '$999,999.99') full_salary
from employees;

ПЕРВЫЙ ВАРИАНТ
select first_name, last_name,
CASE LENGTH(first_name)-LENGTH(last_name)
WHEN 0 THEN 'same length'
ELSE 'different length'
END
from employees;

ВТОРОЙ ВАРИАНТ
select first_name, last_name,
NVL2(NULLIF(LENGTH(FIRST_NAME), LENGTH(LAST_NAME)),
'DIFFERENT LENGTH', 'SAME LENGTH') EQUALITY
from employees;


select first_name, commission_pct, 
NVL2(commission_pct, 'Yes', 'No')
from employees;

ПЕРВЫЙ СПОСОБ
select first_name, last_name,
NVL(commission_pct, NVL(manager_id, salary)) result
from employees;

ВТОРОЙ СПОСОБ
select first_name, last_name, COALESCE(commission_pct, manager_id, salary) info
from employees;

select first_name, last_name, salary,
CASE 
    WHEN salary < 5000 THEN 'LOW LEVEL'
    WHEN salary >= 5000 AND salary < 10000 THEN 'MIDDLE LEVEL'
    WHEN salary >= 10000 THEN 'HIGH LEVEL'
END as "payroll_analytics"
from employees;

select country_name,
       decode(region_id,
                1, 'Europe',
                2, 'America',
                3, 'Asia',
                4, 'Africa',
                'Unknown')
                region
from countries;

select country_name,
CASE region_id
    WHEN 1 THEN 'Europe'
    WHEN 2 THEN 'America'
    WHEN 3 THEN 'Asia'
    WHEN 4 THEN 'Africa'
    ELSE 'Unknown'
END as "region"
from countries;
    
SELECT FIRST_NAME, LAST_NAME, SALARY,
CASE
    WHEN SALARY < 10000 AND COMMISSION_PCT IS NULL THEN 'BAD'
    WHEN SALARY between 10000 AND 15000
    OR COMMISSION_PCT IS NOT NULL THEN 'NORMAL'
    WHEN SALARY >= 15000 THEN 'GOOD'
END AS "INCOME_STATISTICS"
FROM EMPLOYEES;


############################################################################
############################################################################
Multiple row functions
GROUP FUNCTIONS

- COUNT
- SUM
- AVG
- MAX
- MIN

____________________________________________________________________________
COUNT

COUNT({*|DISTINCT|ALL}expression)

select COUNT(*) from employees;
Считает количество всех строчек

select COUNT(*) from employees
where salary > 5000;

select COUNT(salary) from employees;

select COUNT(commission_pct) from employees;
select COUNT(NVL(commission_pct,0)) from employees;

select COUNT(ALL first_name) from employees;

select COUNT(DISTINCT commission_pct) from employees;
Считает количество уникальных значений

select COUNT(DISTINCT first_name) from employees;
Читается как выведи количество уникальных имен из таблицы employees

select COUNT(first_name) as "all count", COUNT(DISTINCT first_name) 
from employees;

select COUNT(*), COUNT(commission_pct) as "all count",
COUNT(DISTINCT commission_pct) as "uniqe count"
from employees;


select COUNT(DISTINCT NVL(commission_pct, 0)) as "uniqe count"
from employees;

select first_name, last_name, first_name||' '||last_name from employees;

select COUNT('abc') from employees;
select COUNT(7) from employees;

____________________________________________________________________________
SUM

SUM({DISTINCT|ALL} expression)

select SUM(salary) from employees;
select SUM(ALL salary) from employees;

Функция игнорирует значения null

select SUM(commission_pct), SUM(DISTINCT commission_pct) from employees;
select SUM(salary), SUM(DISTINCT salary) from employees;

select SUM(7), SUM('7') from employees;

select ROUND(SUM(sysdate-hire_date)/365) from employees;

select ROUND(SUM(LENGTH(first_name))/COUNT(*)) from employees;

____________________________________________________________________________
AVG = AVERAGE

AVG({DISTINCT|ALL} expression)


select AVG(salary) from employees;

select SUM(salary)/COUNT(salary) from employees;

select AVG(salary) from employees
where job_id='IT_PROG';

select AVG(salary), AVG(DISTINCT salary) from employees;

select AVG(commission_pct), AVG(DISTINCT commission_pct) from employees;

select AVG(sysdate-hire_date)/365 from employees;

select AVG(commission_pct) from employees;
Значение не до конца корректно, так как игнорируются значения null
Поэтому корректная запись будет в следующем виде

select AVG(NVL(commission_pct, 0)) from employees;

____________________________________________________________________________
MIN&MAX

MIN({DISTINCT||ALL}expression)
MAX({DISTINCT||ALL}expression)

SELECT MIN(salary), MAX(salary) from employees
where department_id = 50;

SELECT MIN(hire_date), MAX(hire_date) from employees
where department_id = 50;

SELECT MIN(last_name), MAX(last_name) from employees
where department_id = 50;

select COUNT(salary), SUM(salary), AVG(salary), MAX(salary), MIN(salary)
from employees;

select MAX(length(first_name)), MIN(length(first_name)) from employees;


____________________________________________________________________________
GROUP BY

--SELECT *|{DISTINCT column(s) alias, expression(s) alias, group_f-on(s)
--(col|expr alias),}
--FROM table
--WHERE condition(s)
--GROUP BY {col(s)|expr(s)}
--ORDER BY {col(s)|expr(s)|numeric position}
--{ASC|DESC}{NULLS FIRST|LAST}

СМЫСЛ:
ВЫВЕДИ ТАКУЮ ИНФОРМАЦИЮ ИЗ ТАКОЙ ТАБЛИЦЫ, ГДЕ ВЫПОЛНЯЮТСЯ ТАКИЕ УСЛОВИЯ,
СГРУППИРУЙ ЭТУ ИНФОРМАЦИЮ ПО ТАКОМУ-ТО АТРИБУТУ И ОТСОРТИРУЙ В ТАКОМ ПОРЯДКЕ

select department_id, count(*), MIN(salary) 
from employees
group by department_id
order by 1, 2;

select job_id, MIN(salary), MAX(salary), ROUND(AVG(salary)) avg_salary
from employees
where length(first_name) > 4 and salary > 500
group by job_id
order by job_id, avg_salary;

select max(hire_date), min(first_name), count(*), avg(salary), sum(employee_id)
from employees group by department_id;

select TO_CHAR(hire_date, 'MONTH'), count(*)
from employees
group by TO_CHAR(hire_date, 'MONTH');

select location_id, count(*)
from departments
group by location_id;

select department_id, count(*)
from employees
group by department_id
order by department_id;

select job_id, count(*)
from employees
group by job_id
order by job_id;

Группировка по нескольким атрибутам

select department_id, job_id, count(*)
from employees
group by department_id, job_id
order by department_id, job_id;

select department_id, manager_id, count(*)
from employees
group by department_id, manager_id
order by department_id, manager_id;

select job_id, TO_CHAR(hire_date, 'yyyy') as "YEAR", sum(salary)
from employees
where job_id IN ('ST_CLERK', 'SA_REP', 'SH_CLERK') and employee_id > 115
group by job_id, TO_CHAR(hire_date, 'yyyy');

select job_id, TO_CHAR(hire_date, 'yyyy') as "YEAR",
count(*), sum(salary)
from employees
where job_id IN ('ST_CLERK', 'SA_REP', 'SH_CLERK') and employee_id > 115
group by job_id, TO_CHAR(hire_date, 'yyyy');


___________________________________________________________________________
HAVING

select * from employees
where salary > 10000;

select department_id, count(*) from employees
where count(*) > 3
group by department_id
order by department_id;
Вернет ошибку, так как не возможно приминить групповую функцию count в where
Вместо where нужно использовать having

select department_id, count(*) from employees
group by department_id
HAVING count(*) > 3
order by department_id;

--SELECT *|{DISTINCT column(s) alias, expression(s) alias, group_f-on(s)
--(col|expr alias),}
--FROM table
--WHERE condition(s)
--GROUP BY {col(s)|expr(s)}
--HAVING condition(s)
--ORDER BY {col(s)|expr(s)|numeric position}
--{ASC|DESC}{NULLS FIRST|LAST}

select department_id, count(*) from employees
where LENGTH(first_name)>4
group by department_id
HAVING count(*) > 3
order by department_id;

Если where отсеивает строки, то having отсеивает целые группы

select department_id, count(*), ROUND(AVG(salary))
from employees
where LENGTH(first_name)>4
group by department_id
HAVING count(*) > 3 AND ROUND(AVG(salary)) > 5000 
order by department_id;


_____________________________________________________________________________
NESTED GROUP FUNCTIONS

select department_id, AVG(salary) from employees 
group by department_id;

select SUM(AVG(salary)) from employees 
group by department_id;

select SUM(AVG(salary)) from employees 
group by department_id;


single-row функции могут быть вложены настолько глубоко, насколько это возможно,
multiply-row функции могут быть вложены максимум на глубину, равную двум

select MAX(SUM(AVG(salary))) from employees 
group by department_id;

select ROUND(SUM(AVG(LENGTH(UPPER((last_name))))))
from employees
group_by department_id;


#############################################################################
homework_6

select
department_id,
min(salary) MIN_SALARY,
max(salary) MAX_SALARY,
min(hire_date) EARLIEST_HIRE_DATE,
max(hire_date) LATEST_HIRE_DATE,
count(*)
from employees
group by department_id
order by department_id DESC;

select
substr(first_name, 1, 1) as "FIRST_WORD",
count(substr(first_name, 1, 1)) as "AMOUNT"
from employees
group by substr(first_name, 1, 1)
having count(substr(first_name, 1, 1)) > 1; 

select department_id, salary, count(*)
from employees
group by department_id, salary
order by department_id;

select to_char(hire_date, 'Day'), count(*)
from employees
group by to_char(hire_date, 'Day');

select department_id
from employees
group by department_id
having count(*) > 30 and
sum(salary) > 300000
order by department_id;

select region_id
from countries
group by region_id
having sum(length(country_name)) > 50;

select job_id, avg(salary)
from employees
group by job_id;

select department_id
from employees
group by department_id
having count(distinct(job_id)) > 1
order by department_id;

select department_id, job_id, max(salary), min(salary)
from employees
group by department_id, job_id
having avg(salary) > 10000;

select manager_id, trunc(avg(salary))
from employees
where commission_pct is NULL
group by manager_id
having avg(salary) between 6000 and 9000
order by manager_id;

select round(max(avg(salary)),-3)
from employees
group by department_id;


############################################################################
############################################################################
JOIN

-INNER (NATURAL) JOIN
-OUTER JOIN
-CROSS JOIN

-EQUIJOIN
-NONEQUIJOIN

select * from employees;
select * from departments;


select employees.salary, employees.first_name from employees;
select e.salary, e.first_name from employees e;

############################################################################
INNER(NATURAL) JOIN

SELECT column(s)
FROM table_1
NATURAL JOIN
table_2;

select * from regions;
select * from countries;

select * from regions 
NATURAL JOIN countries;

select c.country_name, c.country_id, r.region_name, region_id
from regions r NATURAL JOIN countries c;

select * from employees where department_id = 90 AND manager_id = 100;
select * from departments where department_id = 90 AND manager_id = 100;

select first_name, last_name, salary, department_name, department_id, manager_id
from employees NATURAL JOIN departments;

select * from employees natural join countries;

select * from employees;
select * from job_history;

select * from employees natural join job_history;

select country_name, country_id, region_name, region_id
from regions NATURAL JOIN countries
where region_name = 'Europe';

___________________________________________________________________________
NATURAL JOIN with USING

SELECT column(s)
FROM table_1
JOIN
table_2
USING (column(s));

Используя какие столбцы мы хотим объединить таблицы

select first_name, last_name, salary, department_name, department_id, manager_id
from employees NATURAL JOIN departments;

select first_name, last_name, salary, department_name,
e.manager_id emp_manager, d.manager_id dep_manager,
department_id
from employees e JOIN departments d USING (department_id);

select * from regions;
select * from countries;
select * from regions join countries using (region_id);
результат тот же, что и 
select * from regions natural join countries;

select * from job_history;


select first_name, last_name, jh.job_id, start_date, end_date
from employees join job_history jh using (employee_id);

select first_name, last_name, jh.job_id, start_date, end_date
from employees join job_history jh using (employee_id, department_id);

____________________________________________________________________________
NATURAL JOIN WITH ON

SELECT column(s)
FROM table_1
JOIN table_2
ON (column1 = column2)

select first_name, last_name, jh.job_id, start_date, end_date
from employees join job_history jh using (employee_id);

select first_name, last_name, jh.job_id, start_date, end_date
from employees join job_history jh on (employees.employee_id = jh.employee_id);

select first_name, last_name, jh.job_id, start_date, end_date,
employees.employee_id, jh.employee_id
from employees join job_history jh on (employees.employee_id = jh.employee_id);

select * from regions;
select * from departments;

select * from departments JOIN regions ON
(region_id = department_id);

select * from departments JOIN regions ON
(region_id*10 = department_id);


select first_name, last_name, jh.job_id, start_date, end_date
from employees e join job_history jh on
(e.employee_id = jh.employee_id and e.department_id = jh.department_id);
То же самое, что и
select first_name, last_name, jh.job_id, start_date, end_date
from employees join job_history jh using (employee_id, department_id);

select * from departments;
select * from employees;
select first_name, department_name from employees JOIN departments
ON (employees.employee_id = departments.manager_id);


____________________________________________________________________________
Примеры на объединение более двух таблиц

select * from regions;
select * from countries;
select * from locations;
select * from locations NATURAL JOIN countries NATURAL JOIN regions;

select * from locations join countries using(country_id)
JOIN regions USING (region_id);

select first_name, last_name, jh.job_id, start_date, end_date, department_name
from employees e 
join job_history jh on(e.employee_id = jh.employee_id)
join departments d on (jh.department_id = d.department_id);

select first_name, last_name, jh.job_id, start_date, end_date, department_name
from employees e 
join job_history jh using(employee_id)
join departments d on (jh.department_id = d.department_id);

select department_name, min(salary), max(salary)
from employees e join departments d on (e.department_id = d.department_id)
group by department_name
order by min(salary), max(salary) DESC;

____________________________________________________________________________
NONEQUIJOIN with ON

до этого были рассмотреты EQUIJOIN, где мы сравнивали
столбцы и приравнивали их друг к другу

NONEQUIJOIN - объединение таблиц с помощью неравенств

SELECT column(s)
FROM table_1
JOIN
table_2
ON (column1 {оператор неравенства} column2);

select * from jobs;

select first_name, salary, min_salary, max_salary
from employees e join jobs  j on
(e.job_id = j.job_id and salary*2 < max_salary);


select first_name, salary, min_salary, max_salary
from employees e join jobs  j on
(e.job_id = j.job_id and salary = max_salary);

select first_name, salary, min_salary, max_salary
from employees e join jobs  j on
(e.job_id = j.job_id and salary < max_salary);

select first_name, salary, min_salary, max_salary
from employees e join jobs  j on
(e.job_id = j.job_id and
salary between min_salary + 2000 and max_salary-3000);

___________________________________________________________________________
SELF JOIN

select employee_id, first_name, manager_id from employees;

select emp1.employee_id, emp1.first_name, emp1.manager_id,
emp2.first_name manager_name
from employees emp1 join employees emp2 on (emp1.manager_id = emp2.employee_id);

select emp2.first_name manager_name, count(*)
from employees emp1 join employees emp2 on (emp1.manager_id = emp2.employee_id)
group by emp2.first_name
order by count(*);

____________________________________________________________________________
OUTER JOIN

LEFT OUTER JOIN

SELECT column(s) FROM
table_1 LEFT JOIN table_2
ON (column1 = column2);

select first_name, last_name, salary, department_name
from employees e 
join departments d 
on (e.department_id = d.department_id);
Выводятся только те строки, которые удовлетворяют указанным условиям.
Если мы мы применим LEFT OUTER JOIN;

select first_name, last_name, salary, department_name
from employees e 
left outer join departments d 
on (e.department_id = d.department_id);
Получаем дополнительную строку, где указан работник, у которого нет департамента
То есть получили данные из левой таблицы, которые не удовлетворяют указанным
условиям

Еще один пример
select first_name, last_name, salary, department_name
from departments d
left outer join  employees e 
on (e.department_id = d.department_id);

select first_name, last_name, salary, department_name
from departments d
left outer join  employees e 
on (e.department_id = d.department_id)
where department_name like '%i%';

select first_name, salary, min_salary, max_salary
from employees e
left outer join jobs j
on (e.job_id = j.job_id and salary*2<max_salary);
Будут выводиться все 107 сотрудников, так как мы использовали 
LEFT OUTER JOIN. При этом, у сотрудников, которые не удовлетворяют условиям,
данные из правой таблицы будут null

select * from locations;

select postal_code, city, department_name
from locations l 
join departments d
on (d.location_id = l.location_id);

select postal_code, city, department_name
from locations l 
left outer join departments d
on (d.location_id = l.location_id);

select department_name, d.department_id, first_name
from departments d
left outer join employees e
on (e.department_id = d.department_id)
where first_name is null;

___________________________________________________________________________
RIGTH OUTER JOIN

SELECT column(s) FROM
table_1 RIGHT OUTER JOIN table_2
ON (column1 = column2);
Все работает так же как и с left outer join, только в правую сторону

select first_name, last_name, salary, department_name
from employees e 
right outer join departments d 
on (e.department_id = d.department_id);
Теперь дополняется не один работник из левой таблицы,
а департаменты из правой таблицы

Запись с using
select first_name, last_name, salary, department_name
from employees e 
right outer join departments d 
using (department_id);

select * from countries;
select * from locations;

select country_name, city, street_address
from locations l
right outer join countries c
on (l.country_id = c.country_id);

____________________________________________________________________________
FULL OUTER JOIN

SELECT column(s) FROM
table_1 FULL OUTER JOIN table_2
ON (column1 = column2);

На примере, помимо строк, для которых выражение это True, будут выводиться 
работники, у которых нет департамента (он один из левой таблицы) и будут
выводиться департаменты, у которых нет работников (из правой таблицы)

select first_name, last_name, salary, department_name
from employees e 
full outer join departments d
on (e.department_id = d.department_id);

Для красивого вывода сделаем следующее:
select NVL(first_name, 'no employee'), NVL(last_name, 'no employee'),
NVL(salary, 0), NVL(department_name, 'no department')
from employees e 
full outer join departments d
on (e.department_id = d.department_id);


_____________________________________________________________________________
CROSS JOIN

SELECT column(s)
FROM table_1
CROSS JOIN
table_2;
Каждая строка из первой таблицы объединяется с каждой строкой 
из второй таблицы

select * from countries;
select * from jobs;
select * from regions;

select * from countries
cross join regions;

select count(*) from countries
cross join regions;

select * from countries
cross join regions
where countries.region_id > 2
order by country_id;

select * from countries natural join jobs;
Если нет столбцов с общим названием, то выполяется
операция как cross join

____________________________________________________________________________
ORACLE JOIN SYNTAX

-INNER JOIN
SELECT column(s)
FROM table_1 t1, table_2 t2
WHERE t1.column1 = t2.column2;

select first_name, last_name, salary, e.department_id, department_name
from employees e, departments d
where e.department_id = d.department_id;

-RIGHT OUTER JOIN
SELECT column(s)
FROM table_1 t1, table_2 tw
WHERE t1.column1 (+) = t2.column2;

select first_name, last_name, salary, e.department_id, department_name
from employees e, departments d
where e.department_id(+) = d.department_id;

-LEFT OUTER JOIN
SELECT column(s)
FROM table_1 t1, table_2 tw
WHERE t1.column1  = t2.column2 (+);

select first_name, last_name, salary, e.department_id, department_name
from employees e, departments d
where e.department_id = d.department_id(+);

-CROSS JOIN
SELECT column(s)
FROM table_1 t1, table_2 t2;

select * from countries, regions;


#############################################################################
homework_7

select * from employees;
select * from departments;
select * from regions;
select * from locations;
select * from countries;

--employees.department_id - departments.department_id
--departments.location_id - locations.locations_id
--locations.country_id - countries.country_id
--countries.region_id - regions.region_id


select r.region_name, count(*)
from regions r
join countries c using(region_id)
join locations l using(country_id)
join departments d using(location_id)
right outer join employees e using (department_id)
group by r.region_name;

Еще один вариант
SELECT region_name, count(*)
FROM employees e
    JOIN departments d ON (e.department_id = d.department_id)
    JOIN locations l ON (d.location_id = l.location_id)
    JOIN countries c ON (l.country_id = c.country_id)
    JOIN regions r ON (c.region_id = r.region_id)
GROUP BY region_name;


select first_name, last_name, 
       department_name, job_id,
       street_address, country_name,
       region_name
from employees 
join departments using(department_id)
join locations using(location_id)
join countries using(country_id)
join regions using(region_id);

Еще один вариант
select first_name, last_name, 
       department_name, job_id,
       street_address, country_name,
       region_name
from employees e 
join departments d on(e.department_id = d.department_id) 
join locations l on(d.location_id = l.location_id)
join countries c on (l.country_id = c.country_id)
join regions r on(c.region_id = r.region_id);


select emp2.first_name, count(*) 
from employees emp1
join employees emp2 on (emp1.manager_id = emp2.employee_id)
group by emp2.first_name
having count(*) > 6;

select d.department_name, count(*)
from departments d
join employees e using(department_id)
group by d.department_name
having count(*) > 30;

SELECT department_name
FROM employees e
RIGHT JOIN departments d ON (e.department_id = d.department_id)
WHERE first_name is NULL;

SELECT emp.*
FROM employees emp JOIN employees man ON (emp.manager_id = man.employee_id)
WHERE TO_CHAR(man.hire_date, 'YYYY') = '2005'
AND emp.hire_date < TO_DATE('01-01-2005', 'DD-MM-YYYY');

select c.country_name, r.region_name
from countries c
natural join regions r;

select * from jobs;
select * from employees;

select emp.first_name, emp.last_name, emp.salary, 
       job.min_salary + 1000 as "MIN SALARY" 
from employees emp
join jobs job
on (emp.job_id = job.job_id)
where emp.salary < job.min_salary + 1000;

Еще один вариант
SELECT first_name, last_name, salary, min_salary + 1000 as "MIN SALARY"
FROM employees e 
JOIN jobs j
ON (e.job_id = j.job_id AND salary < min_salary+1000);

select distinct emp.first_name, emp.last_name, coun.country_name
from employees emp
full outer join departments dep on (emp.department_id = dep.department_id)
full outer join locations loc on (dep.location_id = loc.location_id)
full outer join countries coun on (loc.country_id = coun.country_id)
order by emp.first_name, emp.last_name, coun.country_name;

select first_name, last_name, country_name
from employees 
cross join countries;

SELECT region_name, count(*)
FROM employees e, departments d, locations l, countries c, regions r
WHERE (e.department_id = d.department_id 
AND d.location_id = l.location_id
AND l.country_id = c.country_id
AND c.region_id = r.region_id)
GROUP BY region_name;

select department_name
from employees e, departments d
where first_name is null
and e.department_id (+) = d.department_id;


############################################################################
############################################################################
SUBQUERY - подзапрос

select first_name, last_name, salary
from employees 
where salary > (select AVG(salary) from employees);

--- (select AVG(salary) from employees) срабатывает раньше, чем основной селект

select (select MIN(min_salary) from jobs) min_yild,
(select MAX(LENGTH(first_name)) from employees) long_name
from dual;

select first_name, last_name 
from employees
where employee_id in (select manager_id from employees);

select department_name, max(salary), min(salary)
from (select salary, department_name from employees e 
join departments d
on (e.department_id = d.department_id))
group by department_name;

Тот же запрос с использованием join и без subquery
SELECT department_name, MIN(salary), MAX(salary)
FROM employees e 
JOIN departments d
ON (e.department_id = d.department_id)
GROUP BY department_name;

select department_name, max(salary), min(salary)
from (select salary, department_name from employees e 
join departments d
on (e.department_id = d.department_id))
group by department_name
having max(salary) > (select 2*5000 from dual)
and min(salary)<(select salary from employees where employee_id = 113);


---TYPES OF SUBQUERIES
--- SINGLE ROW
--- MULTIPLE ROW
--- SCALAR

____________________________________________________________________________
SINGLE-ROW SUBQUERY

select MAX(salary) from employees;
select first_name, last_name, salary from employees
where salary > 24000/5;

select first_name, last_name, salary
from employees
where salary <
(select max(salary)/5 from employees);

select first_name, last_name, salary from employees
where salary > (select AVG(salary) from employees);

select first_name, last_name, salary from employees
where salary >= (select salary from employees where employee_id = 180);

select first_name, last_name, salary from employees
where salary >= (select salary from employees where employee_id > 180);
---Возвращает ошибку, так как подзапрос не singlerow, a multiply row

select job_title from jobs j
join employees e 
on (j.job_id = e.job_id)
group by job_title
having avg(salary) = 
(select max(avg(salary)) from employees 
group by job_id);

_____________________________________________________________________________
MULTIPLE-ROW SUBQUERY
IN, ANY, ALL

select * from jobs;

select first_name, last_name, salary
from employees
where job_id = 
(select job_id from jobs where min_salary > 8000);
--- Получаем ошибку так как из подзапроса возвращается больше одной строки

select first_name, last_name, salary
from employees
where job_id IN 
(select job_id from jobs where min_salary > 8000);

select first_name, last_name, salary
from employees
where job_id NOT IN 
(select job_id from jobs where min_salary > 8000);

select first_name, last_name, salary
from employees
where salary > (select salary from employees where department_id = 100);
--- Возвращает ошибку по той же причине. Чтобы ее избежать можно использовать 
--- ANY или ALL

select first_name, last_name, salary
from employees
where salary > ANY (select salary from employees where department_id = 100);

select first_name, last_name, salary
from employees
where salary > ALL (select salary from employees where department_id = 100);

select distinct department_name 
from employees e
join departments d 
on (e.department_id = d.department_id);

---Тот же результат используя SUBQUERY
select department_name 
from departments 
where department_id IN 
(select distinct department_id from employees);

_____________________________________________________________________________
CORRELATED SUBQUERY

select e1.first_name, e1.last_name, e1.salary from employees e1
where salary > (select AVG(e2.salary) from employees e2
where e2.department_id = e1.department_id);
--Запрос возвращает людей, котоыре зарабатывают больше средней ЗП в их 
--- департаменте

_____________________________________________________________________________
SUBQUERY EXAMPLES

--- НАЙДЕМ РАБОТНИКОВ, КОТОРЫЕ РАБОТАЮТ В ГЕРМАНИИ
SELECT first_name, last_name, salary
FROM employees
WHERE department_id IN
(SELECT department_id FROM departments WHERE location_id IN
(SELECT location_id FROM locations WHERE country_id = 
(SELECT country_id FROM countries WHERE country_name = 'Germany')));

--- Выводим список работников, которые:
---Job_Id = Manager
---Salary больше средней зарплаты по компании
select * from jobs;

select first_name, last_name, salary
from employees
where job_id IN 
(select job_id from jobs where UPPER(job_title) like '%MANAGER%')
and salary > (select AVG(salary) from employees);

select first_name, last_name, salary from employees
where salary > (select MAX(salary) from employees where first_name = 'David');


#############################################################################
homework_8

select *
from employees
where length(first_name) = (select max(length(first_name)) from employees);

select *
from employees
where salary > (select avg(salary) from employees);


select l.city, sum(e.salary)
from locations l
join  departments d using (location_id)
join employees e using(department_id)
group by city 
having sum(salary) = (select min(sum(e.salary))
            from employees e
            join departments d  on (e.department_id = d.department_id)
            join locations l on (d.location_id = l.location_id)
            group by city);

select * from employees
where manager_id in
(select manager_id from employees
where salary > 15000);


---Вспомогательная инфа для 5ой задачи
select * from employees 
full outer join departments using(department_id);
---5ая задача
select * from departments
where department_name not in
(select d.department_name from employees e
join departments d on (e.department_id = d.department_id)
group by d.department_name);
--- ВТОРОЙ ВАРИАНТ
SELECT *
FROM DEPARTMENTS
WHERE DEPARTMENT_ID NOT IN (SELECT DISTINCT DEPARTMENT_ID
                            FROM EMPLOYEES
                            WHERE DEPARTMENT_ID IS NOT NULL);

---Вспомогательная инфа для 6ой задачи
select count(*), emp2.manager_id from employees emp1
join employees emp2 on (emp1.manager_id = emp2.manager_id)
group by emp2.manager_id;
---6ая задача
select * from employees
where employee_id not in 
(select emp2.manager_id from employees emp1
join employees emp2 on (emp1.manager_id = emp2.manager_id)
group by emp2.manager_id);
--- ВТОРОЙ ВАРИАНТ
SELECT *
FROM employees
WHERE employee_id NOT IN (SELECT DISTINCT manager_id
                          FROM employees
                          WHERE manager_id IS NOT NULL);

select emp_numb, manager_id from
(select count(*) as "EMP_NUMB", emp2.manager_id from employees emp1
join employees emp2 on (emp1.manager_id = emp2.manager_id)
group by emp2.manager_id)
where emp_numb > 6;
--- ВТОРОЙ ВАРИАНТ
SELECT *
FROM employees e
WHERE (SELECT COUNT(*)
       FROM employees
       WHERE manager_id = e.employee_id) > 6;
--- Во втором варианте использовался CORRELATED SUBQUERY

select * from
(select e.employee_id, e.first_name, e.last_name, e.email,
        e.phone_number, e.hire_date, e.job_id,
        e.commission_pct, e.manager_id, d.department_name from employees e
join departments d using (department_id))
where upper(department_name) like '%IT%';

---Второй вариант
select * from employees
where department_id = 
(select distinct(department_id) from departments
where upper(department_name) like 'IT');

---Третий вариант
SELECT *
FROM employees
WHERE department_id = (SELECT department_id
                       FROM departments
                       WHERE department_name = 'IT');
                       
SELECT *
FROM employees
WHERE manager_id IN (SELECT employee_id
                     FROM employees
                     WHERE TO_CHAR (hire_date, 'YYYY') = '2005')
      AND hire_date < TO_DATE ('01-01-2005', 'DD-MM-YYYY');
      
SELECT *
FROM employees e
WHERE manager_id IN (SELECT employee_id
                     FROM employees
                     WHERE TO_CHAR (hire_date, 'MM') = '01')
      AND (SELECT LENGTH(job_title)
           FROM jobs
           WHERE job_id = e.job_id) > 15;
           

############################################################################
############################################################################
SET OPERATORS (Операторы множеств)

-UNION
-UNION ALL
-INTERSECT
-MINUS

____________________________________________________________________________
UNION ALL
Объединяет 2 output множества в одно простым соединением

select * from jobs 
where job_id like '%MAN%'
UNION ALL
select * from jobs 
where job_id like '%MAN%';

select * from jobs 
where job_id like '%MAN%';

select * from jobs;

select job_id, max_salary
from jobs
where job_id like '%MAN%'
UNION ALL
select job_title, min_salary
from jobs
where job_id like '%MAN%';

select job_id, job_title, min_salary from jobs 
where job_id like '%MAN%'
UNION ALL
select job_id, job_title, min_salary from jobs 
where job_id like '%MAN%'
order by min_salary DESC;

select job_id, job_title, min_salary from jobs 
where job_id like '%MAN%'
UNION ALL
select job_id, job_title, max_salary from jobs 
where job_id like '%MAN%'
order by min_salary DESC;

select first_name, last_name, salary
from employees
where employee_id > 200
UNION ALL
select job_id, job_title, max_salary from jobs
where job_id like '%MAN%';

select country_id from countries
UNION ALL
select country_name from countries;

select country_id from countries
UNION ALL
select region_id from countries;
---Возвращает ошибку так как разные типы у присоединяемых множеств

____________________________________________________________________________
UNION
Объединяет 2 output множества в одно, удаляя при этом дубликаты и сортируя его

select * from jobs 
where job_id like '%MAN%'
UNION
select * from jobs 
where job_id like '%MAN%';

select * 
from jobs
where min_salary between 4500 and 8000
UNION
select * 
from jobs
where max_salary between 10000 and 15000
order by 3;

____________________________________________________________________________
INTERSECT
Возвращает только общие строки, удаляя при этом дубликаты и сортируя результат

select * from jobs 
where job_id like '%MAN%'
INTERSECT
select * from jobs 
where job_id like '%MAN%';

select * 
from jobs
where min_salary between 4500 and 8000
INTERSECT
select * 
from jobs
where max_salary between 10000 and 15000
order by 3;

select first_name, last_name from employees
INTERSECT 
select street_address, city from locations;

_____________________________________________________________________________
MINUS
Возвращает только те строки, которые есть в первом множестве, но которых нет во
втором множестве, удаляя при этом дубликаты и сортируя результат

select * from jobs 
where job_id like '%MAN%'
MINUS
select * from jobs 
where job_id like '%MAN%';

select * 
from jobs
where min_salary between 4500 and 8000
MINUS
select * 
from jobs
where max_salary between 10000 and 15000
order by 3;

_____________________________________________________________________________
Примеры на SET операторы

select first_name, salary from employees
where first_name like '%a%'
INTERSECT
select first_name, salary from employees
where first_name like '%e%'
MINUS
select first_name, salary from employees
where first_name like '%l%';

select first_name, salary from employees
where first_name like '%a%'
UNION
select first_name, salary from employees
where first_name like '%e%'
MINUS
select first_name, salary from employees
where first_name like '%l%';

select first_name, salary from employees
where first_name like '%a%'
UNION
(select first_name, salary from employees
where first_name like '%e%'
MINUS
select first_name, salary from employees
where first_name like '%l%');

select manager_id
from employees
where department_id = 20
INTERSECT
select manager_id
from employees
where department_id = 30;


select department_id dep, sum(salary) from employees
group by department_id;

select job_id, sum(salary) from employees
group by job_id;

select department_id dep_id, to_char(null) job_id, sum(salary) from employees
group by department_id
UNION
select to_number(null), job_id, sum(salary) from employees
group by job_id;


#############################################################################
homework_9

select emp1.manager_id, emp1.job_id, emp1.department_id, sum(emp1.salary)
from employees emp1
group by emp1.manager_id, emp1.job_id, emp1.department_id
order by emp1.manager_id, emp1.department_id, sum(emp1.salary);

---Второй вариант
SELECT manager_id, TO_CHAR(null) job_id,
TO_NUMBER(null) department_id, SUM(salary)
FROM employees
GROUP BY manager_id
UNION
SELECT TO_NUMBER(null), job_id,
TO_NUMBER(null), SUM(salary)
FROM employees
GROUP BY job_id
UNION
SELECT TO_NUMBER(null), TO_CHAR(null),
department_id, SUM(salary)
FROM employees
GROUP BY department_id;

select department_id from employees
where to_number(manager_id, '999') = 100
minus
select department_id from employees
where to_number(manager_id, '999') = 145
minus
select department_id from employees
where to_number(manager_id, '999') = 201;

---Второй вариант
SELECT department_id FROM employees
WHERE manager_id = 100
MINUS
SELECT department_id FROM employees
WHERE manager_id IN (145, 201);


select first_name, last_name, salary from employees
where first_name like '_a%' and lower(last_name) like '%s%'
order by salary desc;

---Второй вариант
select first_name, last_name, salary from employees
where first_name like '_a%'
INTERSECT
select first_name, last_name, salary from employees
where lower(last_name) like '%s%'
order by salary desc;

select loc.location_id, loc.postal_code, loc.city from locations loc
join countries coun on (loc.country_id = coun.country_id)
where coun.country_name in ('Italy','Germany')
UNION ALL
select location_id, postal_code, city from locations
where postal_code like '%9%';

---Второй вариант
select location_id, postal_code, city from locations
where country_id IN
(select country_id from countries where country_name in ('Italy', 'Germany'))
UNION ALL
select location_id, postal_code, city from locations
where postal_code like '%9%';

SELECT country_id id, country_name country, region_id region 
FROM countries
WHERE LENGTH(country_name) > 8
UNION
SELECT * FROM countries
WHERE region_id != (SELECT region_id FROM regions
WHERE UPPER(region_name) = 'EUROPE')
ORDER BY country DESC;


############################################################################
############################################################################
DML COMMANDS (DATA MANIPULATION LANGUAGE)
-SELECT
-INSERT
-UPDATE
-DELETE
-MERGE

____________________________________________________________________________
---INSERT

select * from employees;
select * from countries;

шаблон:
INSERT INTO table_name column(s) VALUES (value(s));

insert into countries values('SW', 'Sweden', 1);

insert into countries (country_id, country_name, region_id)
values('NR', 'Norway', 1);

insert into countries (region_id, country_name, country_id)
values(1, 'Greece', 'GR');

insert into countries (country_id, country_name)
values('PR', 'Portigal');

insert into countries
values('FL', 'Finland', null);


---По возможности, при занесении данных в таблицу нужно использовать функции
--- это best practice
insert into employees (employee_id, last_name, email, hire_date, job_id)
values (208, INITCAP('Vasilieva'), UPPER('vasilieva'), 
TO_DATE('18-JAN-2019', 'DD-MON-YYYY'), UPPER('it_prog'));

select * from employees
where last_name like 'Vasilieva';


insert into employees (employee_id, last_name, email, hire_date, job_id)
values (209, INITCAP('Vasilieva'),
        UPPER('vasilieva1'), sysdate, UPPER('it_prog'));
        
____________________________________________________________________________
INSERT с использованием SUBQUERY
--- Вставляем в таблицу несколько строк

INSERT INTO table_name
column(s)
SUBQUERY;

create table new_emps
(
emp_id integer,
name varchar2(20),
start_date date,
job varchar2(10)
);
 
INSERT INTO new_emps (emp_id, name, start_date)
(select employee_id, first_name, hire_date from employees
where employee_id > 200);

select * from new_emps;

INSERT INTO new_emps
(select employee_id, first_name, hire_date from employees
where employee_id > 200);
---Возвращает ошибку 
---Так как в таблице 4 столбца, а мы добавляем только три 

INSERT INTO new_emps
(select employee_id, first_name, hire_date, job_id from employees
where employee_id > 200);

_____________________________________________________________________________
INSERT в несколько таблиц;

create table emps_with_high_salary
(
name varchar2(20),
salary integer
);

create table emps_with_dept_100
(
name varchar2(20),
salary integer
);

create table some_emps
(
name varchar2(20),
salary integer
);

DROP TABLE emps_with_high_salary;
DROP TABLE emps_with_dept_100;
DROP TABLE some_emps;


INSERT ALL
WHEN department_id = 100 THEN
INTO emps_with_dept_100 VALUES (first_name, salary)
WHEN salary > 15000 THEN
INTO emps_with_high_salary (name) VALUES (last_name)
WHEN 5=5 THEN
INTO some_emps (name, salary) VALUES (first_name, salary)
(select first_name, last_name, salary, department_id
from employees where LENGTH(first_name) > 5);

SELECT * FROM emps_with_dept_100;
SELECT * FROM emps_with_high_salary;
SELECT * FROM some_emps;

____________________________________________________________________________
UPDATE

UPDATE table_name
SET
column(s) = value(s)
WHERE condition(s);

select * from employees;

UPDATE employees
SET salary = 10000
where employee_id = 100;

UPDATE employees
SET salary = salary * 2
where employee_id = 100;

UPDATE employees
SET salary = 27000, job_id = 'IT_PROG'
where employee_id = 101;

---UPDATE Нескольких строк
UPDATE employees
SET salary = 8500
where employee_id < 105;

UPDATE employees
SET salary = 100000;

---Откат информации  F12(Rollback)

____________________________________________________________________________
UPDATE с SUBQUERY

UPDATE table_name
SET
column(s) = subquery(s)
WHERE column = subquery;

UPDATE employees
SET salary = 5000
WHERE department_id IN
(select department_id from departments where department_name = 'Marketing');

UPDATE employees 
SET salary = (select MAX(salary) from employees),
    hire_date = (select MIN(start_date) from job_history)
where employee_id = 180;

select * from employees
where employee_id = 180;

____________________________________________________________________________
DELETE;

select * from employees;

DELETE
FROM table_name
WHERE condition(s);

select * from new_emps;

insert into new_emps
(select employee_id, first_name, hire_date, job_id 
from employees);

delete from new_emps;
delete from new_emps
where emp_id = 201;

delete from new_emps 
where job like '%CLERK%' or name is null;

_____________________________________________________________________________
DELETE with SUBQUERY

DELETE
FROM table_name
WHERE column = subquery;

delete from new_emps where job IN 
(select distinct job_id from employees
where department_id IN(
select department_id from departments where manager_id = 100));

_____________________________________________________________________________
MERGE
Редкая команда, объединяющая в себя все команды (Insert, Update, Delete);

MERGE INTO table_name1 t1
USING {table_name2|subquery} t2
ON (t1.column = t2.column)
WHEN MATCHED THEN
UPDATE SET column = value
DELETE WHERE condition
WHEN NOT MATCHED THEN
INSERT (value1, value2)
VALUES (column1, column2);

select * from employees;
select * from new_emps;

insert into new_emps
(select employee_id, first_name, hire_date, job_id from employees
where employee_id < 110);

MERGE INTO new_emps ne
USING employees e
ON (ne.emp_id = e.employee_id)
WHEN MATCHED THEN
UPDATE SET ne.start_date = SYSDATE
DELETE where ne.job like '%IT%'
WHEN NOT MATCHED THEN
INSERT (emp_id, name, start_date, job)
VALUES (employee_id, last_name, hire_date, job_id);

#############################################################################
#############################################################################
TRANSACTION
Принципы ACID
A - ATOMICY (Атомарность)
C - CONSISTENCY (Согласованность)
I - ISOLATION (Изолированность)
D - DURABLE (Долговечность)

Транзакция это изменение DB
insert
update
delete
insert
itc
commit|rollback - Закрывают транзакцию;

_____________________________________________________________________________
TCL COMMANDS:
COMMIT;
--- Заканчивает текущую транзакцию. После завершения, изменения становятся
--- видимыми остальным пользователям. До коммита, изменения видны только для
--- текущей сессии

select * from new_emps;
delete from new_emps
where name = 'Pat';
commit;

insert into new_emps values (1000, 'Olesia', sysdate, 'IT_PROG');
update new_emps set emp_id = 300 where emp_id = 100;
delete from new_emps where emp_id = 101;
commit;

_____________________________________________________________________________
TCL COMMANDS:
ROLLBACK;

--- Откат всей информации до начала транзакции

ROLLBACK TO SAVEPOINT savepoint_name;

delete from new_emps;

insert into new_emps
(select employee_id, last_name, hire_date, job_id from employees);
commit;

select * from new_emps;

insert into new_emps values (1000, 'Olesia', sysdate, 'IT_PROG');
update new_emps set emp_id = 300 where emp_id = 100;
delete from new_emps where emp_id = 101;
rollback;

--- Если rollback сделать сразу же после commit, то изменения не откатятся
--- Так как commit фиксирует все изменения и делает их доступными для
--- Других сессий

select * from new_emps;

_____________________________________________________________________________
TCL COMMANDS:
SAVEPOINT;

select * from new_emps;

delete from new_emps;

insert into new_emps
(select employee_id, last_name, hire_date, job_id from employees);
commit;

insert into new_emps values (1000, 'Olesia', sysdate, 'IT_PROG');
savepoint s1;
update new_emps set emp_id = 300 where emp_id = 100;
savepoint s2;
delete from new_emps where emp_id = 101;
rollback; --- Откат к началу транзакции
rollback to savepoint s2; --- Откат к этапу s2
--- rollback to savepoint не закрывает транзакцию, а rollback закрывает
commit;

_____________________________________________________________________________
TCL COMMANDS:
AUTOCOMMIT;

--- чтобы подключить, в командной строке пишем
--- set autocommit on;
--- чтобы выключить, пишем в командной строке
--- set autocommit off;
select * from new_emps;


insert into new_emps values (1000, 'Olesia', sysdate, 'IT_PROG');

update new_emps set emp_id = 300 where emp_id = 100;

delete from new_emps where emp_id = 101;
commit;

--- В SQL Developer:
---Tools -> Preferences ->Database -> Advanced -> Установить галочку autocommit;

_____________________________________________________________________________
SELECT FOR UPDATE;

select * from new_emps for update;
--- При использовании for update, Oracle ставит lock на изменение
--- указанной таблицы. lock будет висеть до тех пор, пока транзакция 
--- не будет закрыта

update new_emps set start_date = '12.JAN.17' where name = 'Olesia';
commit;

select * from new_emps;

#############################################################################
homework_10

CREATE TABLE locations2 as (select * from locations where 1=2);

select * from locations2;
select * from locations;

insert into locations2 (location_id, street_address, city, country_id)
(select location_id, street_address, city, country_id from locations
join countries using(country_id)
where country_name = 'Italy');
COMMIT;

insert into locations2 
(select location_id, street_address, city, country_id from locations
join countries using(country_id)
where upper(country_name) like 'FRANCE');
COMMIT;

CREATE TABLE locations4europe as (select * from locations where 1=2);

INSERT ALL
WHEN 5=5 THEN
INTO locations2 values(location_id, street_address, postal_code,
                       city, state_province, country_id)
WHEN location_id in
                    (select location_id from locations l
                     join countries c using(country_id)
                     join regions r using(region_id)
                     where upper(r.region_name) like 'EUROPE')
THEN
INTO locations4europe (location_id, street_address, city, country_id)
                values (location_id, street_address, city, country_id)
(SELECT * FROM locations);
COMMIT;

select * from locations;
select * from locations2;
select * from locations4europe;

UPDATE locations2
SET postal_code = 21061996
where postal_code is null;
ROLLBACK;

UPDATE locations2
SET postal_code = 
(select postal_code from locations where location_id = 2600)
where postal_code is null;
COMMIT;

DELETE
FROM locations2
WHERE UPPER(country_id) LIKE 'IT';
SAVEPOINT save_1;

UPDATE locations2
SET street_address = 'Sezam st.18'
where location_id > 2500;
SAVEPOINT save_2;

DELETE
FROM locations2
WHERE street_address = 'Sezam st.18';
ROLLBACK TO SAVEPOINT save_2;
COMMIT;

#############################################################################
#############################################################################
DDL commands;

select object_type, count(object_type) from user_objects
group by object_type
order by object_type;

select object_type, count(object_type) from all_objects
group by object_type
order by object_type;

select table_name from user_tables;

select column_name, data_type, nullable from user_tab_columns
where table_name = 'DEPARTMENTS';

--- ОСНОВНЫЕ DB ОБЪЕКТЫ

---TABLE
---VIEW (ИМЕННОВАННЫЙ SELECT)
---SYNONYM (ALIAS FOR TABLE OR VIEW)
---INDEX
---SEQUENCE

#############################################################################
USERS AND SCHEMA

USER - ЛИЦО, КОТОРОЕ МОЖЕТ ПОДКЛЮЧИТЬСЯ К БД
       ИМЕЕТ USER_NAME И PASSWORD
       
SCHEMA - ОБЪЕКТЫ БД, КОТОРЫЕ ПРИНАДЛЕЖАТ ОДНОМУ USER

_____________________________________________________________________________
ПРАВИЛА НАЗВАНИЯ ОБЪЕКТОВ. ПОНЯТЯТИЕ NAMESPACE;

1. Имя должно содержать от 1 до 30 символов
2. Объект не может называться зарезервированным словом
3. Все имена должны называться, начиная с буквы
4. В названии можно использовать _ $, #
5. Прописные буквы будут конвертированы в заглавные

Правила 2-4 можно игнорировать, если занести название в кавычки

create table "3 abc def"(
id number
);

select * from "3abc def";

NAMESPACE;
Общее пространство, которое не допускает одинаковое название объектов

_____________________________________________________________________________
---CREATE TABLE;

select * from employees;

---CREATE TABLE schema.table ORGANIZATION HEAP
---(column_name datatype DEAFAULT expt,
---column_name datatype DEFAULT expr,
---...);

CREATE TABLE students (
student_id integer,
name varchar2(15),
start_date date DEFAULT ROUND(SYSDATE),
scholarship number(6, 2),
avg_score number(4, 2) DEFAULT 5
) ORGANIZATION HEAP;

select * from students;

INSERT INTO students (student_id, name, start_date, scholarship, avg_score)
VALUES (1, 'Alex', TO_DATE('23-MAY-22'), 1500.3, 7.8);

INSERT INTO students (student_id, name, start_date, scholarship, avg_score)
VALUES (2, 'Olesya', TO_DATE('23-MAY-22'), 1000, 8);

INSERT INTO students (student_id, name, scholarship)
VALUES (3, 'Antonio', 800);
COMMIT;

select * from students;

_____________________________________________________________________________
---CREATE TABLE WITH SUBQUERY

CREATE TABLE schema.table;
AS
subquery;

select * from new_emps;

CREATE TABLE new_emps2
as
(select employee_id, first_name, last_name,
        salary, department_id from employees);

        
CREATE TABLE new_dep
as
(select department_name, max(salary) max_salary,
        min(salary) min_salary from employees e
join departments d using(department_id)
group by department_name);

select * from new_dep;

select * from regions;

CREATE TABLE regions2
as (select * from regions where 5 = 6);

select * from regions2;

_____________________________________________________________________________
ALTERING TABLE - ИЗМЕНЕНИЕ ТАБЛИЦЫ
1.
ALTER TABLE table_name
ADD (column_name data_type DEFAULT expr);
2.
ALTER TABLE table_name
MODIFY (column_name data_type DEFAULT expr);
3.
ALTER TABLE table_name
DROP COLUMN column_name;
4.
ALTER TABLE table_name
SET UNUSED COLUMN column_name;
--- отличается от Drop тем, что колонка перестает быть видимой,
--- но ее физического удаления не происходит.
ALTER TABLE table_name DROP UNUSED COLUMNS;
5.
ALTER table_name
RENAME COLUMN column_name1 TO column_name2;
6. ALTER table_name READ ONLY;
--- После этой операции, таблица становится доступна только для select
--- DML команды выполнить невозможно 

select * from students;

ALTER TABLE students
ADD (course number DEFAULT 3);

ALTER TABLE students
MODIFY (avg_score integer);
--- Возвращается ошибка, так как в столбе есть ячейка со значением,
--- не соответствующем формату integer

ALTER TABLE students
MODIFY (avg_score number(5, 3));

ALTER TABLE students
MODIFY (start_date date DEFAULT null);

insert into students (student_id, name)
values(4, 'Natasha');

select * from students;

ALTER TABLE students DROP COLUMN scholarship;

ALTER TABLE students SET UNUSED COLUMN start_date;

ALTER TABLE students DROP UNUSED COLUMNS;

ALTER TABLE students
RENAME COLUMN student_id TO id;

____________________________________________________________________________
TRUNCATE;
--- Полностью удаляет все данные из таблицы

TRUNCATE TABLE
schema.table_name;

select * from students;

TRUNCATE TABLE students;
--- Таблица students еще существует, но все строки удалены

____________________________________________________________________________
DROP TABLE; ---Удаление таблицы

DROP TABLE
schema.table_name;

--- Для примера заполним строки
INSERT INTO students (id, name, avg_score, course)
VALUES (1, 'Alex', 85, 3);

INSERT INTO students (id, name, avg_score, course)
VALUES (1, 'Olesya', 99, 1);

INSERT INTO students (id, name, avg_score, course)
VALUES (1, 'Natasha', 90, 2);
COMMIT;

DROP TABLE students;

#############################################################################
homework_11

CREATE TABLE friends
as
(select employee_id id,
	first_name name,
	last_name surname
from employees
where commission_pct is not null);

select * from friends;

alter table friends 
add (email varchar2(15) default null);

alter table friends
modify (email varchar2(15) default 'no email');

insert into friends (id, name, surname)
values (220, 'Michael', 'Shilman');
COMMIT;

alter table friends
rename column id to friends_id;

drop table friends;

create table friends (
id integer,
name varchar2(15),
surname varchar2(15),
email varchar2(15),
salary number(10, 2) default 800,
city varchar2(15),
birthday date default to_date('1-JAN-1970', 'DD-MON-YYYY'))
organization heap;

select * from friends;

insert into friends
values (1, 'Anton', 'Yadikov', 'yadikov@mail.ru',
        1200, 'Kazan', to_date('17-DEC-1994'));

insert into friends (id, name, surname, email, city)
values (2, 'Vasiliy', 'Boyarchuk', 'fuck@yandex.ru', 'Balashicha');

commit;

alter table friends
drop column salary;

alter table friends
set unused column email;

alter table friends
set unused column birthday;

alter table friends
drop unused columns;

alter table friends
read only;

insert into friends (id)
values (3);

truncate table friends;

drop table friends;

############################################################################
############################################################################
DDL commands part 2

CONSTRAINT (ОГРАНИЧЕНИЯ)

_____________________________________________________________________________
UNIQUE CONSTRAINT

UNIQUE принуждает столбец(цы) содержать только уникальные значения. 
       Исключения - null
       
CREATE TABLE students(
id number CONSTRAINT st_id_unique UNIQUE,
name varchar2(15),
course number,
faculty_id integer,
avg_score number(5, 2),
start_date date,
scholarship integer
);
CREATE TABLE faculties(
id number,
name varchar2(15)
);

INSERT INTO students 
values (1, 'Alex', 1, 3, 8.2, TO_DATE('01-SEP-2014', 'DD-MON-YYYY'), 1450);

INSERT INTO students 
values (1, 'Alex', 1, 3, 8.2, TO_DATE('01-SEP-2014', 'DD-MON-YYYY'), 1450);
--- Возвращается ошибка, так как на таблицу id
--- мы наложили ограничения уникальности
--- если вместо id использовать значение null, то строка добавится

INSERT INTO students 
values (null, 'Olesya', 1, 2, 9.6, TO_DATE('01-SEP-2003', 'DD-MON-YYYY'), 1500);

INSERT INTO students 
values (2, 'Natasha', 1, 2, 7.6, TO_DATE('01-SEP-2018', 'DD-MON-YYYY'), 2500);
COMMIT;

select * from students;

DROP TABLE students;

____________________________________________________________________________
COMPOSITE CONSTRAINTS;


CREATE TABLE students(
id number,
name varchar2(15),
course number,
faculty_id integer,
avg_score number(5, 2),
start_date date,
scholarship integer,
CONSTRAINT st_id_unique UNIQUE (id, name)
);

---В данном примере уникальность проверяетя по паре значений,
--- указанных в constraint. Таким образом, в таблице могут быть одинаковые
--- значения id и уникальные значения name, но по отдельности

CREATE TABLE students(
id number,
name varchar2(15),
course number,
faculty_id integer,
avg_score number(5, 2),
start_date date,
scholarship integer,
CONSTRAINT st_id_unique UNIQUE (id)
);

INSERT INTO students 
values (1, 'Alex', 1, 3, 8.2, TO_DATE('01-SEP-2014', 'DD-MON-YYYY'), 1450);
INSERT INTO students 
values (2, 'Olesya', 1, 2, 9.6, TO_DATE('01-SEP-2003', 'DD-MON-YYYY'), 1500);
INSERT INTO students 
values (3, 'Natasha', 1, 2, 7.6, TO_DATE('01-SEP-2018', 'DD-MON-YYYY'), 2500);

select * from students;

drop table students;

CREATE TABLE students(
id number,
name varchar2(15),
course number,
faculty_id integer,
avg_score number(5, 2),
start_date date,
scholarship integer,
UNIQUE (id)
);

CREATE TABLE students(
id number UNIQUE,
name varchar2(15),
course number,
faculty_id integer,
avg_score number(5, 2),
start_date date,
scholarship integer
);

select * from students;

CREATE TABLE students(
id number,
name varchar2(15),
course number,
faculty_id integer,
avg_score number(5, 2),
start_date date,
scholarship integer
);

CREATE TABLE faculties(
id number,
name varchar2(15)
);

alter table students
add constraint st_id_unique UNIQUE(id);

insert into faculties values (1, 'CS');
insert into faculties values (2, 'Economics');
insert into faculties values (2, 'Philology');

update faculties
set id = 3
where name = 'Philology';
COMMIT;

select * from faculties;

alter table faculties add UNIQUE(id);

drop table students;
drop table faculties;

alter table students MODIFY(id constraint abc UNIQUE);

alter table faculties MODIFY(id UNIQUE);

alter table students drop constraint abc;

____________________________________________________________________________
NOT NULL  CONSTRAINT
--- Не разрешает столбцам иметь значения null;

select * from students;
select * from faculties;

drop table students;
drop table faculties;

CREATE TABLE students(
id number,
name varchar2(15),
course number constraint stud_course_notnull NOT NULL,
faculty_id integer
);

CREATE TABLE faculties(
id number,
name varchar2(15)
);

insert into students
values (1, 'Alexander', null, 1);
insert into students (id, name, faculty_id)
values (1, 'Alexander', 1);

insert into students
values (1, 'Alex', 3, 1);


--- Варианты записи
CREATE TABLE students(
id number,
name varchar2(15),
course number NOT NULL,
faculty_id integer
);

alter table students MODIFY
(course constraint st_course_notnull not null);

alter table students MODIFY
(course not null;

_____________________________________________________________________________
PRIMARY KEY;
Принуждает столбец(цы) содержать только уникальные значения
и не разрешает содержать значение 'null' 
PRIMARY KEY в таблице должен быть всего один. Если еще на один
столбец необходимо наложить ограничение, можно воспользоваться
UNIQUE и NOT NULL;

drop table students;


CREATE TABLE students (
id number constraint st_id_pk primary key,
name varchar2(15),
course number,
faculty_id integer
);

INSERT INTO students VALUES (1, 'Alex', 4, 5);
INSERT INTO students VALUES (2, 'Olesya', 4, 4);
INSERT INTO students VALUES (1, 'Misha', null, 3);
---Возвращается ошибка
INSERT INTO students (id, name, faculty_id)
VALUES (null, 'Natasha', 2);
---Возвращается ошибка

CREATE TABLE students (
id number primary key,
name varchar2(15),
course number,
faculty_id integer
);

CREATE TABLE students (
id numbery,
name varchar2(15),
course number,
faculty_id integer,
constraint pk primary key (id)
);

CREATE TABLE students (
id numbery,
name varchar2(15),
course number,
faculty_id integer,
primary key (id)
);

CREATE TABLE students (
id number,
name varchar2(15),
course number,
faculty_id integer,
primary key (id, name)
);

Разрешается использовать primary key в alter table -/-/- modify

ALTER TABLE students MODIFY (id constraint pk primary key);
ALTER TABLE students add constraint pk primary key (id);
ALTER TABLE students add primary key (id);

_____________________________________________________________________________
FOREIGN KEY

--- Принуждает использовать только значения из определенного столбца
--- таблицы-родителя или значение 'null'

--- Ссылка в foreign key должна быть или на столбец с ограничением unique
--- или с ограничением primary key

--- Можно делать ссылку на столбец в одной таблице

select * from employees;
select * from departments;

--- department_id в departments - родитель
--- department_id в employees - ребенок

select * from students;
select * from faculties;

CREATE TABLE faculties(
id number primary key,
name varchar2(15)
);

CREATE TABLE students (
id number,
name varchar2(15),
course number,
faculty_id integer constraint st_faculty_fk references faculties(id)
);

drop table students;
drop table faculties;

insert into faculties values (1, 'CS');
insert into faculties values (2, 'Marketing');

INSERT INTO students VALUES (1, 'Alex', 4, 5);
--- Возвращается ошибка, так как числа 5 нет в таблице факультетов
INSERT INTO students VALUES (2, 'Olesya', 4, 1);
INSERT INTO students VALUES (1, 'Misha', null, 2);

CREATE TABLE students (
id number,
name varchar2(15),
course number,
faculty_id integer,
constraint fk foreign key(faculty_id) references faculties(id)
);

ALTER TABLE students MODIFY(
constraint fk faculty_id references faculties(id));

ALTER TABLE students MODIFY(
faculty_id constraint fk references faculties(id));

ALTER TABLE students MODIFY (faculty_id references faculties(id));

ALTER TABLE students ADD CONSTRAINT fk FOREIGN KEY (faculty_id)
REFERENCES faculties(id);

ALTER TABLE students ADD FOREIGN KEY (faculty_id)
REFERENCES faculties(id);

_____________________________________________________________________________
ОПЦИЯ DELETE ДЛЯ FOREIGN KEY

CREATE TABLE students(
id number,
name varchar2(15),
course number,
faculty_id integer references faculties
);

CREATE TABLE faculties(
id number primary key,
name varchar2(15)
);

insert into faculties values (1, 'CS');
insert into faculties values (2, 'Marketing');
insert into faculties values (3, 'Phisics');
COMMIT;

INSERT INTO students VALUES (1, 'Alex', 3, 1);
INSERT INTO students VALUES (2, 'Olesya', 4, 1);
INSERT INTO students VALUES (3, 'Misha', 1, 2);
COMMIT;

select * from faculties;
select * from students;

delete from faculties where id = 1;
--- Возвращается ошибка, так как между студенами и факультетами есть связь.

delete from faculties where id = 3;
--- Удаление проходит,
--- так как у трегьего факультета нет связи с таблицей студентов

CREATE TABLE students(
id number,
name varchar2(15),
course number,
faculty_id integer references faculties ON DELETE CASCADE
);

--- Запись ON DELETE CASCADE означает, что при удалении факультета из
--- таблицы факультетов, будет удаляться строка из таблицы студентов,
--- где есть связь с таблицей факультетов

CREATE TABLE students(
id number,
name varchar2(15),
course number,
faculty_id integer references faculties ON DELETE SET NULL
);

--- Запись ON DELETE SET NULL означает, что при удалении факультета из
--- таблицы факультетов, в таблице студентов связь с удаленным факультетом
--- будет заменяться на null

_____________________________________________________________________________
CHECK CONSTRAINT;

CREATE TABLE students(
id number,
name varchar2(15),
course number CONSTRAINT ch CHECK (course > 0 AND course < 6),
faculty_id integer 
);

---Sysdate в этом constraint использовать нельзя

INSERT INTO students VALUES (1, 'Alex', 3, 1);
INSERT INTO students VALUES (2, 'Olesya', 4, 1);
INSERT INTO students VALUES (3, 'Misha', 1, 7);
COMMIT;

select * from students;


update students set course = 10 where id = 1;
--- Возвращается ошибка, так как нарушается прописанное условие

CREATE TABLE students(
id number,
name varchar2(15),
course number,
faculty_id integer,
email varchar2(15) CHECK (INSTR(email, '@')> 0) constraint un UNIQUE
);

alter table studenrs modify (id constraint ch CHECK (id >=1));
alter table students add check (course < 30);

___________________________________________________________________________
ВВЕДЕНИЕ В INDEX;
--- Создается автоматически для столбцов с ограничениями UNIQUE и PRIMARY KEY

select * from employees where first_name = 'John';
select rowid from employees where first_name = 'John';
select * from employees where rowid = 'AAAR6sAAEAAAKrGAAt';

--- Типи индексов
--- B-TREE (DEFAULT)
--- BITMAP

--- B-TREE эффективен тогда, когда:
---1) Много строк в таблице
---2) Кол-во строк в output отностительно общего кол-ва маленькое
---3) В столбце с индексом должно быть много уникальных значений

---Шаблон создания индексов
CREATE {UNIQUE|BITMAP} INDEX
schema.index_name ON
schema.table_name(column1, column2,...);
---Шаблон удаления индексов
DROP INDEX schema.index_name;

DROP TABLE students;
DROP TABLE faculties;

CREATE TABLE students(
id number,
name varchar2(15),
course number,
faculty_id number
);

CREATE TABLE faculties(
id number,
name varchar2(15)
);

CREATE INDEX in1 ON students(id);  

insert into students values (1, 'Alex', 3);
insert into students values (1, 'Olesya', 3);
insert into students values (2, 'Misha', 3);
insert into students values (2, 'Misha', 4);

delete from students where course = 4;

select * from students;

CREATE UNIQUE INDEX in2 ON students(name);  
CREATE INDEX in3 ON students(name, id);  

CREATE UNIQUE INDEX st_in1 ON students(id);
CREATE UNIQUE INDEX f_in1 ON faculties(id);
CREATE UNIQUE INDEX st_in2 ON students(course);
CREATE INDEX st_in3 ON students(name);

alter table students add constraint st_pk primary key (id);
alter table faculties add constraint f_pk primary key (id);
alter table students add constraint st_un unique (course);

--- Столбец с primary key всегда должен иметь свой индекс

alter table students add constraint st_fk foreign key (faculty_id)
references faculties(id);

select * from faculties;

DROP INDEX st_in3;

_____________________________________________________________________________
INDEX BITMAP

CREATE {UNIQUE|BITMAP} INDEX
schema.index_name ON
schema.table_name (column1, column2, ...);

DROP INDEX schema.index_name;

--- BITMAP эффективен тогда, когда:
---1) мало уникальных значений
---2) Кол-во строк в output отностительно общего кол-ва большое
---3) Использование булевой логики OR, AND, NOT

CREATE BITMAP INDEX b_ind1 ON students(faculty_id);

select * from v$version;

#############################################################################
homework_11_2
       
create table address(
id integer constraint ad_id_un unique,
country varchar2(25),
city varchar2(25)
);

create table friends(
id integer,
name varchar2(25),
email varchar2(25),
address_id integer constraint fk_to_add references address(id) on delete
                                                               set null,
birthday date,
constraint len_name check (length(name) > 3)
);

CREATE UNIQUE INDEX index1 ON friends(id); 

alter table friends
add constraint fr_id_pk primary key(id);

create index fr_ind1 on friends(email);

alter table friends MODIFY
(email constraint fr_email_nn not null);

drop table friends;
drop table address;

#############################################################################
#############################################################################
VIEW

--- Simple
--- Complex

select * from employees;

create view fin_emp as 
(select employee_id, job_id, salary from employees);

select * from fin_emp;

create view fin_emp2 as
(select department_name, sum(salary) sum_salary from employees e 
join departments d on (e.department_id = d.department_id)
group by department_name);

select * from fin_emp2;

select department_name from fin_emp2
where sum_salary > 10000;

create view emps_with_high_salary2 as
(select first_name, last_name from employees 
where salary >= 12000);

update employees 
set salary = 15000 
where employee_id = 103;

select * from emps_with_high_salary2;

_____________________________________________________________________________
SIMPLE and COMPLEX views

--- SIMPLE VIEW              |            COMPLEX VIEW
--- one table                |            join tables
--- no functions             |            functions
--- no aggregation           |            aggregation
--- can use DML commands     |            cannot use DML commands

select * from students;

insert into students values(1, 'Alex', 3, 1);
insert into students values(2, 'Olesya', 2, 2);
insert into students values(3, 'Masha', 1, 1);

create view v101 as
(select name, course from students);

select * from v101;

insert into v101 values ('Ivan', 4);

delete from v101 where name = 'Ivan';

alter table students
modify (id not null);


create view v105 as
(select SUBSTR(name, 2) name, course from students);

select * from v105;

insert into v105 values ('Oleg', 3);
--- Операция не проходит
delete from v105 where name = 'lex';

create view v106 as select distinct name, course from students;
select * from v106;
insert into v106 values ('Oleg', 3);
--- Операция не проходит
delete from v106 where name = 'Masha';
--- Операция не проходит

create view v107
(as select name n, course c from students);

insert into v107 values('Kolya', 3);
delete from v107 where n = 'Masha';

select * from v107;

create view v108 as
(select rownum r, name, course from students);

select * from v108;

_____________________________________________________________________________
Создание CREATE VIEW;

select * from students;

drop table students;
drop table faculties;

CREATE TABLE students(
id number,
name varchar2(15),
course number
);

insert into students values (1, 'Alex', 5);
insert into students values (2, 'Olesya', 4);
insert into students values (3, 'Anton', 3);
insert into students values (4, 'Nastya', 2);
insert into students values (5, 'Vasya', 3);
COMMIT;

--- Шаблон
CREATE OR REPLACE {FORCE|NOFORCE} VIEW
schema.view_name(alias1, alias2,...)
AS subquery
WITH CHECK OPTION {CONSTRAINT constrain_theme}
WITH READ ONLY {CONSTRAINT constraint_name};

select * from fin_emp2;

create or replace view fin_emp2 as select * from students;

select * from fin_emp2;

create FORCE VIEW v201 as select * from students2;
--- Несмотря на то, что students2 не существует, благодаря FORCE view 
--- все равно создается

create view v202 as select * from students where course > 2;
select * from v202;

insert into v202 values(7, 'Katya', 1);
--- Закинулось в таблицу students
select * from v202;

create view v203 as select * from students
where course > 2 with check option;

insert into v203 values(7, 'Fedya', 1);
--- Вернется ошибка, так как используется check option
insert into v203 values(7, 'Fedya', 3);

update v203 set course = 2 where name = 'Fedya';
--- update так же не проходит, так как не удовлетворяется check option

update v203 set course = 5 where name = 'Fedya';
select * from v203;

create view v204 as select * from students
with read only;
--- v204 изменить невозможно

create view v210 as select * from students
with read only constraint constraint_1;

create view v211 (a, b, c) as select * from students;

select * from v211;

_____________________________________________________________________________
ALTER VIEW and DROP VIEW

--- Шаблон
alter view 
schema.view_name 
COMPILE;

create force view v18 as select name, last_name from students;
select * from v18;

alter table students add (last_name varchar2(15));
alter view v18 compile; --- Проверка на компиляцию
select * from v18;

drop view v18;

create view v212 as select * from v211;

create view v301 as select * from students where id > 4;
select * from v301 where name = 'Alex';

_____________________________________________________________________________
---SYNONYM
--- Альтернативное имя объекта

select * from employees;
select * from hr.employees;
select * from hr.employees@orclpdb2;

--- Synonym позволяет переименовывать таблицы или view и "перемещать"
--- таблицы в ту схему, которая пренадлежить userу, у которого есть доступ

--- ШАБЛОН
CREATE PUBLIC SYNONYM synonym_name
FOR object_name;

--- ШАБЛОН
DROP PUBLIC SYNONYM synonym_name;

--- ШАБЛОН
ALTER PUBLIC SYNONYM synonym_name
COMPILE;

select * from students;

create SYNONYM syn1 for students;

select * from syn1;

delete from syn1 where id = 7;

create PUBLIC SYNONYM syn1 for employees;

select * from syn1;
--- В первую очередь проверяется private synonym

DROP PUBLIC SYNONYM syn1;

--- Если удалить таблицу student, синоним к нему остается,
--- но им уже невозможно воспользоваться

alter synonym syn1 compile;

select * from syn1;

_____________________________________________________________________________
---INTRODUCTION TO SEQUENCE (Последовательности)

--- яркий пример это employee_id в employees
select * from employees;

--- Шаблон
CREATE SEQUENCE schema.sequence_name
INCREMENT BY number
START WITH number
{MAXVALUE number | NOMAXVALUE}
{MINVALUE number | NOMINVALUE}
{CYCLE | NOCYCLE}
{CACHE number | NOCACHE};

--- Шаблон
DROP SEQUENCE schema.sequence_name;
_____________________________________________________________________________
Работа с SEQUENCE ЧАСТЬ 1

create sequence s1;
---nextval
---currval
select s1.nextval from dual;
select s1.currval from dual;

drop table students;

create table students(
id number,
name varchar2(25),
course number,
faculty_id integer
);

create table faculties(
id number,
name varchar2(15)
);

create sequence seq_st;

create sequence seq_faculty
start with 20
increment by 5;

insert into faculties values(seq_faculty.nextval, 'IT');
insert into students values(seq_st.nextval, 'Alex', 1, seq_faculty.nextval);

insert into faculties values(seq_faculty.nextval, 'Management');
insert into faculties values(seq_faculty.nextval, 'Mathematic');
insert into faculties values(seq_faculty.currval, 'History');


insert into students values(seq_st.nextval, 'Olesya', 1, 25);
insert into students values(seq_st.nextval, 'Anton', 1, seq_faculty.nextval);

insert into students values(seq_st.nextval, 'Vasya', 1, seq_faculty.currval);
COMMIT;

select * from students;

select * from faculties;

CREATE sequence s3 increment by 2 maxvalue 17;
select s3.nextval from dual;
--- Доходит до 17 и возвращает ошибку

CREATE sequence s4 increment by 2 maxvalue 17 cycle cache 3;
select s4.nextval from dual;

CREATE sequence s5 
start with 7
increment by 4
maxvalue 17
cycle cache 3;

select s5.nextval from dual;
---Начнет с 7, дойдет до 17 и вернется на 1

drop table students;

create table students(
id number,
name varchar2(25)
);

create sequence s10;

insert into students values(s10.nextval, 'Alex');
insert into students values(s10.nextval, 'Olesya');
insert into students values(s10.nextval, 'Anton');
ROLLBACK;
insert into students values(s10.nextval, 'Nastya');

select * from students;

---sequence не зависит от commit и rollback


_____________________________________________________________________________
Работа с SEQUENCE ЧАСТЬ 2

create table seq(
n number
);

insert into seq values (1);
commit;

drop table students;

create table students(
id number primary key,
name varchar2(25)
);

insert into seq values(1);
insert into students values((select n from seq), 'Alex');

update seq set n = n + 1;


select * from students;
select * from seq;

alter sequence s10 increment by 5;

insert into students values(s10.nextval, 'Kolya');
insert into students values(s10.nextval, 'Fedor');

drop sequence s10;

create sequence s20;

select s20.nextval from dual;
select s20.currval from dual;


#############################################################################
homework_11_3

create table emp1000
as
(select first_name, last_name, salary, department_id from employees);

select * from emp1000;

create force view v1000
as
(select emp.first_name,
            emp.last_name,
                emp.salary,
                    dep.department_name,
                        emp.city
from emp1000 emp
join departments dep on (emp.department_id = dep.department_id));

alter table emp1000
add (city varchar2(25));

alter view v1000 compile;

create public synonym syn1000
for v1000;

drop view v1000;
drop public synonym syn1000;
drop table emp1000;

create sequence seq1000
increment by 4
start with 12
maxvalue 200
cycle;

alter sequence seq1000
nomaxvalue
nocycle;

select * from employees;

INSERT INTO employees (employee_id, last_name, email, hire_date, job_id)
values (seq1000.nextval, 'Vasiliev', 'AVASILIEV', SYSDATE-1000, 'IT_PROG');

INSERT INTO employees (employee_id, last_name, email, hire_date, job_id)
values (seq1000.nextval, 'Kharlamova', 'OKHARLAMOVA', SYSDATE-1500, 'IT_PROG');

select * from employees;

COMMIT;

##############################################################################
##############################################################################
SINGLE AMPERSAND SUBSTITUTION

select first_name, last_name, salary
from employees
where employee_id = 130;

select first_name, last_name, salary
from employees
where employee_id = &ID;

select first_name, last_name, salary
from employees
where first_name = '&name';

select first_name, last_name, salary
from employees
where first_name = '&name'
and salary > &salary;

____________________________________________________________________________
DOUBLE AMPERSAND SUBTITUTION

select first_name, last_name, salary
from employees
where first_name like '%s%'
and last_name like '%s%';

select first_name, last_name, salary
from employees
where first_name like '%&&s%'
and last_name like '%&s%';

select first_name, last_name, &col from employees
order by &col2;

select first_name, last_name, &&col from employees
order by &col;

select &znach from employees;

select &select_list
from &table_name
where &conditions
order by &cl;

select * from students;

update students
set &col3 = &value 
where &condition;

______________________________________________________________________________
DEFINE and UNDEFINE

UNDEFINE s;
UNDEFINE col;
DEFINE;
DEFINE s = s;

set define off; --- Чтобы символ & воспренимался как обычный символ
set define on; --- Чтобы символ & воспренимался как специальный символ

############################################################################
homework_12

create table test200(
id integer,
name1 varchar2(15),
name2 varchar2(15),
address1 varchar2(15),
address2 varchar2(15)
);

select * from test200;

update test200 set &col = &val where id = &id_val;

set verify on;

select * from test200
where name1 = '&&name'
and
      name2 = '&name'
and 
      address1 = '&&address'
and
      address2 = '&address';
      
UNDEFINE name;
UNDEFINE address;