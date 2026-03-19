# переписать ниже примеры из первого часа из видеолекции: 
# https://youtu.be/4igzy3bGVkQ
# по желанию можно поменять значения и попробовать другие функции
my_answer = 42
typeof(my_answer)
my_pi = 3.14159
typeof(my_pi)
my_name = "Yaroslav"
typeof(my_name)

my_answer = my_name
typeof(my_answer)

sum = 3 + 7

difference = 10 - 3

product = 20 * 5

quotient = 100 / 10

power = 10^2

modulus = 101 % 2

# Strings
s1 = "Это строка"
s2 = """Это тоже строка"""
typeof(s2)
typeof('a')

name = "Yaroslav"
num_fingers = 10
num_toes = 10

println("Привет, меня зовут $name.")
println("У меня $num_fingers пальцев на руках и $num_toes пальцев на ногах. Значит всего у меня $(num_fingers+num_toes) пальцев")
#$переменная вставляет значение переменной
#$(выражение)-вычисляет выражение и вставляет результат
string("строчка ", 10, " строчка")

s3 = "один"
s4 = "два"

s3 * s4

"$s3$s4"

# Data structures
# Dict
# знак стрелка - чтобы связать ключ со значением 
myphonebook = Dict("Yaroslav" => "867-5309", "yarik" => "555-234")
myphonebook["don"] = "555-FILK"

myphonebook

myphonebook["don"]

pop!(myphonebook, "don")

# Tuple(кортеж)
nomer = ("1", "2", "3")

nomer[3]
#nomer[3]="8" - нельзя так как кортежи не изменяемые

# Array
myfriends = ["ted", "robyn", "barney"]

fibonacci = [1, 1, 2, 3, 5, 8, 13]


mix = [1, 2, 3.0, "hi"]


myfriends[3]

myfriends[3] = "Don"
myfriends

push!(fibonacci, 21)

pop!(fibonacci)
fibonacci

favorites = [["koobideh", "chocolate", "eggs"], ["1", "2", "3"], ["4", "5", "6"]]
numbers = [[1, 2, 3], [4, 5], [6, 7, 8, 9]]

rand(4, 3) #создает 2-мерную матрицу (4 строки × 3 столбца)

rand(4, 3, 2) #создает 3-мерный массив (4 × 3 × 2) — как стопку из 2 матриц

# Loops
let n = 0
    while n < 10
        n += 1
        println(n)
    end
end

myfriends = ["1", "М2", "x2", "y4"]

let i = 1
    while i <= length(myfriends)
        friend = myfriends[i]
        println("Привет,$friend")
        i += 1
    end
end

for n in 1:10
    println(n)
end


for friend in myfriends
    println("Привет,$friend")
end

m, n = 5, 5
A = zeros(m, n)
#матрицы
for i in 1:m
    for j in 1:n
        A[i, j] = i + j
    end
end
A

B = zeros(m, n)

for i in 1:m, j in 1:n
    B[i, j] = i + j
end
B

C = [i + j for i in 1:m, j in 1:n]

for n in 1:10
    A = [i + j for i in 1:n, j in 1:n]
    display(A)
end

# Conditionals
x = 3
y = 90

if x > y
    println("$x больше $y")
elseif x < y
    println("$x меньше $y")
else
    println("$x равно $y")
end

if x > y
    x
else
    y
end

(x > y) ? x : y


(x > y) && println("$x больше $y")
(x < y) && println("$x меньше $y")

# functions
function sayhi(name)
    println("Привет, $name")
end

function f(x)
    x^2
end

sayhi("Yaroslav")
f(3)

sayhi2(name) = println("Привет, $name")
f2(x) = x^2
sayhi2("Yaroslav")
f2(3)

sayhi3 = name -> println("Привет, $name")
f3 = x -> x^2
sayhi3("Yaroslav")
f3(3)

sayhi(4)

A = rand(3, 3)
A
# не работает однозначно для вектора (из-за ^)
f(A)


v = [3, 5, 2]
# Не работает (не меняет оригинал)
sort(v)
v

# так работает (меняет оригинал)
sort!(v)
v

A = [i + 3 * j for j in 0:2, i in 1:3]
f(A)
B = f.(A)
A[2, 2]
A[2, 2]^2
B[2, 2]
v = [1, 2, 3]
f.(v)

# Packages
import Pkg
Pkg.add("Example")
using Example
hello("XXXX")

Pkg.add("Colors")
using Colors
palette = distinguishable_colors(100)
rand(palette, 3, 3)

Pkg.add("Plots")
using Plots
x = -3:0.1:3
f(x) = x^2
y = f.(x)
gr()
plot(x, y, label="line")
scatter!(x, y, label="points")

Pkg.add("PlotlyJS")
plotlyjs()
plot(x, y, label="line")
scatter!(x, y, label="points")


globaltemperatures = [14.4, 14.5, 14.8, 15.2, 15.5, 15.8]
numpirates = [45000, 200000, 15000, 5000, 400, 17]

plot(numpirates, globaltemperatures, legend=false)
scatter!(numpirates, globaltemperatures, legend=false)
xflip!()
xlabel!("Number of Pirates[Approximate]")
ylabel!("Global Temperature (C)")
title!("Influence of pirate population on gloabal warming")

p1 = plot(x, x)
p2 = plot(x, x .^ 2)
p3 = plot(x, x .^ 3)
p4 = plot(x, x .^ 4)
plot(p1, p2, p3, p4, layout=(2, 2), legend=false)

# Multiple dispatch
methods(+)

@which 3 + 3

@which 3.0 + 3.0

@which 3 + 3.0

import Base: +
# Ошибка! 
# "hello" + "world!"

+(x::String, y::String) = string(x, y)
"hello " + "world!"
@which "hello " + "world!"

foo(x, y) = println("duck-typed foo!")
foo(x::Int, y::Float64) = println("foo with int and float")
foo(x::Float64, y::Float64) = println("foo with two floats")
foo(x::Int, y::Int) = println("foo with two ints")

foo(1, 1)
foo(1.0, 1.0)
foo(1, 1.0)
foo(true, false)

# Basic linear algebra
A = rand(1:4, 3, 3)

B = A
C = copy(A)
[B C]

A[1] = 17
[B C]

x = ones(3)

b = A * x
Asym = A + A'
Apd = A'A
A \ b
Atall = A[:, 1:2]
display(Atall)
Atall \ b
A = randn(3, 3)
[A[:, 1] A[:, 1]] \ b
Ashort = A[1:2, :]
display(Ashort)
Ashort \ b[1:2]