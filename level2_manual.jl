# Выболнить большую часть заданий ниже - привести примеры кода под каждым комментарием


#===========================================================================================
1. Переменные и константы, области видимости, cистема типов:
приведение к типам,
конкретные и абстрактные типы,
множественная диспетчеризация,
=#

# Что происходит с глобальной константой PI, о чем предупреждает интерпретатор?
const PI = 3.14159
PI = 3.14
#сonst делает переменную неизменяемой (константой)
#Интерпретатор выбрасывает ошибку при попытке изменить константу

# Что происходит с типами глобальных переменных ниже, какого типа `c` и почему?
a = 1
b = 2.0
c = a + b
#Float64 - Int64 + Float64 автоматически преобразуется в ..
#..Float64 для сохранения точности
# Что теперь произошло с переменной а? Как происходит биндинг имен в Julia?
a = "foo"
#переменные не имеют фиксированного типа 
#Имя a теперь ссылается на новое значение типа  String

# Что происходит с глобальной переменной g и почему? Чем ограничен биндинг имен в Julia?
g::Int = 1
g = "hi"
# Запись ::Int  ограничивает тип переменной
function greet()
    g = "hello" # Это НОВАЯ локальная переменная, не связанная с глобальной g
    println(g)
end
greet()

# Чем отличаются присвоение значений новому имени - и мутация значений?
v = [1,2,3] # v ссылается на массив
z = v # z ссылается на тот же массив 
v[1] = 3  # МУТАЦИЯ: меняем содержимое массива
v = "hello" # ПРИСВОЕНИЕ: v теперь ссылается на строку
z

# Написать тип, параметризованный другим типом
# Параметризованный тип Point{T}
struct Point{T}
    x::T
    y::T
end

# экземпляры с разными типами
p_int = Point{Int}(1, 2)        # Point{Int64}(1, 2)
p_float = Point{Float64}(3.0, 4.0)  # Point{Float64}(3.0, 4.0)
p_auto = Point(5, 6)            

println(p_int)
println(p_float)
println(p_auto)
#=
Написать функцию для двух аругментов, не указывая их тип,
и вторую функцию от двух аргментов с конкретными типами,
дать пример запуска
=#
# Функция без указания типов 
function multiply(a, b)
    println("multiply with any types: a=$a, b=$b")
    return a * b
end

# Функция с конкретными типами (только Int)
function multiple(a::Int, b::Int)
    println("multiply with Int types: a=$a, b=$b")
    return a * b
end

println(multiple(2, 3))       
println(multiply(2.5, 3.5))     
println(multiply("Hello ", "world"))  

#=
Абстрактный тип - ключевое слово?
Примитивный тип - ключевое слово?
Композитный тип - ключевое слово?
=#
abstract type Xxx end # Абстрактный тип - abstract type
primitive type MyChar 8 end  # 8-битный тип
# Композитный тип - struct (или mutable struct)
struct XX  # неизменяемый композитный тип
    name::String
    num::Int
end

mutable struct YY  # изменяемый композитный тип
    name::String
    num::Int
end
#=
Написать один абстрактный тип и два его подтипа (1 и 2)
Написать функцию над абстрактным типом, и функцию над её подтипом-1
Выполнить функции над объектами подтипов 1 и 2 и объяснить результат
(функция выводит произвольный текст в консоль)
=#
abstract type Shape end

struct Circle <: Shape end
struct Rectangle <: Shape end

# Функция для абстрактного типа
function draw(s::Shape)
    println("Drawing a shape")
end

# Функция для подтипа-1 (Circle)
function draw(c::Circle)
    println("Drawing a circle")
end

# Создаем объекты
circle = Circle()
rectangle = Rectangle()

# Выполняем функции
println("--- Вызов draw(circle) ---")
draw(circle)      

println("--- Вызов draw(rectangle) ---")
draw(rectangle)   

#===========================================================================================
2. Функции:
лямбды и обычные функции,
переменное количество аргументов,
именованные аргументы со значениями по умолчанию,
кортежи
=#

# Пример обычной функции
function add_regular(x, y)
    return x + y
end
# Пример лямбда-функции (аннонимной функции)
add_lambda = (x, y) -> x + y
# Пример функции с переменным количеством аргументов
function summm(x...)
    return sum(x)
end
summm(4, 8, 3, 1)
# Пример функции с именованными аргументами
function show_person(first_name::String, last_name::String)
    println("Имя: $first_name, Фамилия: $last_name")
end
show_person("Анна", "Иванова")
# Функции с переменным кол-вом именованных аргументов
function display_settings(; options...)
    for (setting, value) in options
        println("$setting = $value")
    end
end
display_settings(theme = "dark", fontSize = 14, language = "RU")
#=
Передать кортеж в функцию, которая принимает на вход несколько аргументов.
Присвоить кортеж результату функции, которая возвращает несколько аргументов.
Использовать splatting - деструктуризацию кортежа в набор аргументов.
=#
points = (4, 5, 6)

function calculate_total(a, b, c)
    return(a + b + c)
end

calculate_total(points...)

function collect_values(v...)
    return v
end

result_tuple = collect_values(points...)

#===========================================================================================
3. loop fusion, broadcast, filter, map, reduce, list comprehension
=#

#=
Перемножить все элементы массива
- через loop fusion и
- с помощью reduce
=#
numbers = [1, 2, 3, 4]

function product_loop(arr)
    total = 1
    for element in arr
        total *= element
    end
    return total
end

product_loop(numbers)

product_reduce = reduce(*, numbers)
#=
Написать функцию от одного аргумента и запустить ее по всем элементам массива
с помощью точки (broadcast)
c помощью map
c помощью list comprehension
указать, чем это лучше явного цикла?
=#
numbers = [1, 2, 3, 4]
function cube(x)
    return x^3
end

broadcast_cube = cube.(numbers)
map_cube = map(cube, numbers)
comprehension_cube = [cube(x) for x in numbers]
# Перемножить вектор-строку [1 2 3] на вектор-столбец [10,20,30] и объяснить результат
row_vector = [1 2 3]
column_vector = [10, 20, 30]
matrix_product = row_vector * column_vector
typeof(matrix_product)

# В одну строку выбрать из массива [1, -2, 2, 3, 4, -5, 0] только четные и положительные числа
data = [1, -2, 2, 3, 4, -5, 0]
even_positive = [x for x in data if x > 0 && x % 2 == 0]

# Объяснить следующий код обработки массива names - что за number мы в итоге определили?
using Random
Random.seed!(123)
names = [rand('A':'Z') * '_' * rand('0':'9') * rand([".csv", ".bin"]) for _ in 1:100]
# ---
same_names = unique(map(y -> split(y, ".")[1], filter(x -> startswith(x, "A"), names)))
numbers = parse.(Int, map(x -> split(x, "_")[end], same_names))
numbers_sorted = sort(numbers)
number = findfirst(n -> !(n in numbers_sorted), 0:9)
# нашли Первое число от 0 до 9, которого нет среди цифр в именах файлов, начинающихся на 'A'
# Упростить этот код обработки:
using Random
Random.seed!(123)
names = [rand('A':'Z') * '_' * rand('0':'9') * rand([".csv", ".bin"]) for _ in 1:100]

a_files = filter(name -> startswith(name, "A"), names)
digits = [parse(Int, split(name, "_")[end][1]) for name in a_files]
missing_digit = findfirst(d -> !(d in digits), 0:9)

println("Первая отсутствующая цифра в файлах на 'A': $missing_digit")

#===========================================================================================
4. Свой тип данных на общих интерфейсах
=#
struct SlowVector
    dimension::Int
end

Base.getindex(vec::SlowVector, position::Int) = position^2
slow_vec = SlowVector(6)
println("Элемент на позиции 6: $(slow_vec[6])")  # 36
println("Элемент на позиции 3: $(slow_vec[3])")  # 9
#=
написать свой тип ленивого массива, каждый элемент которого
вычисляется при взятии индекса (getindex) по формуле (index - 1)^2
=#
struct LazySquares
    size::Int
end

Base.getindex(arr::LazySquares, idx::Int) = (idx - 1)^2

# Создаем и используем ленивый массив
lazy_arr = LazySquares(10)
println("Ленивый массив размера 10")
println("Элемент с индексом 1: $(lazy_arr[1])")  # (1-1)^2 = 0
println("Элемент с индексом 5: $(lazy_arr[5])")  # (5-1)^2 = 16
println("Элемент с индексом 10: $(lazy_arr[10])") # (10-1)^2 = 81
#=
Написать два типа объектов команд, унаследованных от AbstractCommand,
которые применяются к массиву:
`SortCmd()` - сортирует исходный массив
`ChangeAtCmd(i, val)` - меняет элемент на позиции i на значение val
Каждая команда имеет конструктор и реализацию метода apply!
=#
abstract type AbstractCommand end
apply!(cmd::AbstractCommand, target::Vector) = error("Not implemented for type $(typeof(cmd))")

abstract type AbstractCommand end
apply!(cmd::AbstractCommand, target::Vector) = error("Not implemented")

# Команда сортировки
struct SortCmd <: AbstractCommand end
apply!(::SortCmd, target::Vector) = sort!(target)

# Команда изменения элемента
struct ChangeAtCmd <: AbstractCommand
    i::Int
    val
end
apply!(cmd::ChangeAtCmd, target::Vector) = (target[cmd.i] = cmd.val; target)

# Пример использования
arr = [3, 1, 4, 1, 5]
apply!(SortCmd(), arr)
println(arr)  # [1, 1, 3, 4, 5]

apply!(ChangeAtCmd(2, 99), arr)
println(arr)  # [1, 99, 3, 4, 5]


# Аналогичные команды, но без наследования и в виде замыканий (лямбда-функций)


#===========================================================================================
5. Тесты: как проверять функции?
=#
# Определим функцию для тестирования
function multiply(x, y)
    return x * y
end

# Написать тест для функции multiply
@assert multiply(3, 3) == 9
@assert multiply(5, 2) == 10
@assert multiply(5, 2) != 9

# Также можно с помощью пакета Test
using Test
@testset "Тестирование умножения" begin
    @test multiply(3, 3) == 9
    @test multiply(5, 2) == 10
    @test multiply(0, 5) == 0
    @test multiply(-2, 3) == -6
    println("Все тесты умножения пройдены!")
end
# Написать тест для функции


#===========================================================================================
6. Дебаг: как отладить функцию по шагам?
=#
using Debugger

function sum_arr(arr)
    s = 0
    for x in arr
        s += x
    end
    return s
end

# Точка останова и отладка
@enter sum_arr([1, 2, 3])
#=
Отладить функцию по шагам с помощью макроса @enter и точек останова
=#


#===========================================================================================
7. Профилировщик: как оценить производительность функции?
=#

#=
Оценить производительность функции с помощью макроса @profview,
и добавить в этот репозиторий файл со скриншотом flamechart'а
=#
function generate_data(len)
    vec1 = Any[]
    for k = 1:len
        r = randn(1,1)
        append!(vec1, r)
    end
    vec2 = sort(vec1)
    vec3 = vec2 .^ 3 .- (sum(vec2) / len)
    return vec3
end

@time generate_data(1_000_000);


# Переписать функцию выше так, чтобы она выполнялась быстрее:


#===========================================================================================
8. Отличия от матлаба: приращение массива и предварительная аллокация?
=#

#=
Написать функцию определения первой разности, которая принимает и возвращает массив
и для каждой точки входного (x) и выходного (y) выходного массива вычисляет:
y[i] = x[i] - x[i-1]
=#

#=
Аналогичная функция, которая отличается тем, что внутри себя не аллоцирует новый массив y,
а принимает его первым аргументом, сам массив аллоцируется до вызова функции
=#

#=
Написать код, который добавляет элементы в конец массива, в начало массива,
в середину массива
=#


#===========================================================================================
9. Модули и функции: как оборачивать функции внутрь модуля, как их экспортировать
и пользоваться вне модуля?
=#


#=
Написать модуль с двумя функциями,
экспортировать одну из них,
воспользоваться обеими функциями вне модуля
=#
module Foo
    #export ?
end
# using .Foo ?
# import .Foo ?


#===========================================================================================
10. Зависимости, окружение и пакеты
=#

# Что такое environment, как задать его, как его поменять во время работы?

# Что такое пакет (package), как добавить новый пакет?

# Как начать разрабатывать чужой пакет?

#=
Как создать свой пакет?
(необязательно, эксперименты с PkgTemplates проводим вне этого репозитория)
=#


#===========================================================================================
11. Сохранение переменных в файл и чтение из файла.
Подключить пакеты JLD2, CSV.
=#

# Сохранить и загрузить произвольные обхекты в JLD2, сравнить их

# Сохранить и загрузить табличные объекты (массивы) в CSV, сравнить их


#===========================================================================================
12. Аргументы запуска Julia
=#

#=
Как задать окружение при запуске?
=#

#=
Как задать скрипт, который будет выполняться при запуске:
а) из файла .jl
б) из текста команды? (см. флаг -e)
=#

#=
После выполнения задания Boids запустить julia из командной строки,
передав в виде аргумента имя gif-файла для сохранения анимации
=#
