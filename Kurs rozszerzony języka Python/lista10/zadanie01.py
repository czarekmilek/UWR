import matplotlib.pyplot as plt
import matplotlib.animation as animation
import random

# Plansza
board_size = 11

# Snake
snake = [(6, 5)]  # początkowe koordynaty snake'a
snake_direction = (1, 0)  # początkowy kierunek snake'a

# Funkcja generująca nowe punkty, aby nie tworzyły się w nieodpowiednich miejscach
def generate_new_point(snake, obstacles, board_size, exclude_points):
    while True:
        new_point = (random.randint(1, board_size - 1), random.randint(1, board_size - 1))
        if new_point not in snake and new_point not in obstacles and new_point not in exclude_points:
            return new_point

# Obstacles
num_obstacles = 5  # liczba przeszkód rozłożonych na planszy
obstacles = [generate_new_point(snake, [], board_size, []) for _ in range(num_obstacles)]

# Animacja
interval = 200  # czas w milisekundach

# Punkty
num_points = 11  # liczba punków rozłożonych na planszy
points = [generate_new_point(snake, obstacles, board_size, []) for _ in range(num_points)]

# Inicjalizacja planszy
fig, ax = plt.subplots()
ax.set_xlim(0, board_size)
ax.set_ylim(0, board_size)
ax.set_aspect('equal')

# Inicjalizacja snake'a, punktów i przeszkód
snake_plot, = ax.plot([], [], 'bo', markersize=18)
points_plot, = ax.plot([], [], 'rs', markersize=13)
obstacles_plot, = ax.plot([], [], 'ks', markersize=18)

def init():
    snake_plot.set_data([], [])
    points_plot.set_data([], [])
    obstacles_plot.set_data([], [])
    return snake_plot, points_plot, obstacles_plot

def update(frame):
    global snake, snake_direction, points

    # Ruchy snake'a
    directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]

    # Nowy, losowy kierunek, t.ż. snake nie wjedzie w siebie bezpośrednio "zawracając"
    new_direction = random.choice([d for d in directions if (d[0], d[1]) != (-snake_direction[0], -snake_direction[1])])

    snake_direction = new_direction

    head = snake[-1]
    new_head = ((head[0] + snake_direction[0]) % board_size, (head[1] + snake_direction[1]) % board_size)

    # Check - kolizja ze swoim własnym segmentem
    if new_head in snake:
        ani.event_source.stop()
        print("Game over! - snake hit itself!")
        return snake_plot, points_plot, obstacles_plot

    # Check - kolizja z punktami
    if new_head in points:
        points.remove(new_head)
        points.append(generate_new_point(snake, obstacles, board_size, points))
    else:
        snake = snake[1:]

    # Check - kolizja z przeszkodami
    if new_head in obstacles:
        ani.event_source.stop()
        print("Game over! - snake hit an obstacle!")
        return snake_plot, points_plot, obstacles_plot

    # Check - kolizja z granicami planszy
    if new_head[0] < 1 or new_head[0] >= board_size or new_head[1] < 1 or new_head[1] >= board_size:
        ani.event_source.stop()
        print("Game over! - snake hit boundaries")
        return snake_plot, points_plot, obstacles_plot

    snake.append(new_head)

    # Update
    snake_plot.set_data([s[0] for s in snake], [s[1] for s in snake])
    points_plot.set_data([s[0] for s in points], [s[1] for s in points])
    obstacles_plot.set_data([s[0] for s in obstacles], [s[1] for s in obstacles])

    return snake_plot, points_plot, obstacles_plot

# Odpalenie animacji
ani = animation.FuncAnimation(fig, update, frames=range(30), init_func=init, blit=True, interval=interval)

plt.show()
