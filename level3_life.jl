"Для живой клетки (1):
- < 2 соседей - умирает (одиночество)
- 2-3 соседа -выживает
- > 3 соседей -умирает (перенаселение)

Для мертвой клетки (0):
- = 3 соседа - рождается
- ≠ 3 соседа -остается мертвой
"
module GameOfLife
using Plots

mutable struct Life
    current_frame::Matrix{Int}
    next_frame::Matrix{Int}
end

function step!(state::Life)
    curr = state.current_frame
    next = state.next_frame
    n, m = size(curr)
    
    # Проходим по каждой клетке
    for i in 1:n
        for j in 1:m
            # Считаем живых соседей 
            neighbors = 0
            for di in -1:1
                for dj in -1:1
                    if di == 0 && dj == 0
                        continue  # Пропускаем саму клетку
                    end
                    #  границы: mod1
                    ni = mod1(i + di, n)
                    nj = mod1(j + dj, m)
                    neighbors += curr[ni, nj]
                end
            end
            
            # Правила игры "Жизнь"
            if curr[i, j] == 1  # Клетка жива
                if neighbors < 2 || neighbors > 3
                    next[i, j] = 0  # Умирает
                else
                    next[i, j] = 1  # Выживает
                end
            else  # Клетка мертва
                if neighbors == 3
                    next[i, j] = 1  # Рождается
                else
                    next[i, j] = 0  # Остается мертвой
                end
            end
        end
    end
    
    # Обновляем текущий кадр
    state.current_frame .= state.next_frame
    return nothing
end

function main(ARGS)
    n = 30
    m = 30
    # Инициализация случайными 0 и 1
    init = rand(0:1, n, m)
    
    game = Life(init, zeros(n, m))
    
    anim = @animate for time = 1:100
        step!(game)
        cr = game.current_frame
        heatmap(cr, 
                title="Game of Life - Step $time",
                color=:blues,
                legend=false,
                aspect_ratio=:equal)
    end
    gif(anim, "life.gif", fps = 10)
    println("Анимация сохранена в life.gif")
end

export main

end

# Запуск
using .GameOfLife
GameOfLife.main("")

