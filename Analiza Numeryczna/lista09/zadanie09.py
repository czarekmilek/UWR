import numpy as np
import matplotlib.pyplot as plt
from scipy.special import comb

def bernsteinPolynomial(n, i, t):
    return comb(n, i) * (t**(i)) * ((1-t)**(n-i))

def bezier(control_points, weights, t):
    n = len(control_points) - 1

    curve_x = 0
    curve_y = 0

    for i in range(len(control_points)):
        curve_x += bernsteinPolynomial(n,i, t) * control_points[i][0] * weights[i]
        curve_y += bernsteinPolynomial(n,i, t) * control_points[i][1] * weights[i]

    x = 0
    y = 0
    
    for i in range(len(weights)):
        x += bernsteinPolynomial(n, i, t) * weights[i]
        y += bernsteinPolynomial(n, i, t) * weights[i]

    curve_x = curve_x / x
    curve_y = curve_y / y
    
    return curve_x, curve_y

def plot_curve(num_points, control_points, weights):
    t = np.linspace(0, 1, num_points)
    curve_points = np.array([bezier(control_points, weights, ti) for ti in t])
    print(curve_points)
    
    plt.plot(curve_points[:, 0], curve_points[:, 1], color="blue", label='Bezier Curve')
    plt.scatter(*zip(*control_points), color='red', label='Control Points')
    plt.legend()
    plt.show()


# control points
control_points = [ (0.0, 0.0), (3.5, 36.0), (25.0, 25.0), (25.0, 1.5), (-5.0, 3.0), (-5.0, 33.0),
(15.0, 11.0), (-0.5, 35.0), (19.5, 15.5), (7.0, 0.0), (1.5, 10.5)]

weights = [1.0, 6.0, 4.0, 2.0, 3.0, 4.0, 2.0, 1.0, 5.0, 4.0, 1.0]
# weights = [1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]
# weights = [1.0, 6.0, 4.0, 2.0, 3.0, 4.0, 2.0, 1.0, 5.0, 4.0, 1.0]
weights = [1.0, 6.0, 4.0, 2.0, 3.0, 4.0, 2.0, 1.0, 5.0, 4.0, 1.0]

plot_curve(11, control_points, weights)
