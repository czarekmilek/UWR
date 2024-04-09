from matplotlib import pyplot as plt
import numpy as np

def calc_M(x, t):
    n = len(x) - 1
    q = [0]
    p = [0]
    u = [0]

    k = 1
    while k <= n - 1:
        lk = calc_lam(k, t)
        p.append(lk * q[k - 1] + 2)
        q.append((lk - 1) / p[k])
        u.append((calc_dk(k, x, t) - lk * u[k - 1]) / p[k])
        k += 1

    M = [0] * (n + 1)
    M[n] = 0
    M[n - 1] = u[n - 1]
    k = n - 2
    while k >= 0:
        M[k] = u[k] + q[k] * M[k + 1]
        k -= 1

    return M

def calc_lam(k, t):
    return (t[k] - t[k - 1]) / (t[k + 1] - t[k - 1])

def calc_dk(k, x, t):
    t1 = (x[k + 1] - x[k]) / (t[k + 1] - t[k])
    t2 = (x[k] - x[k - 1]) / (t[k] - t[k - 1])
    return 6 * (t1 - t2) / (t[k + 1] - t[k - 1])

def calc_nifs3(X, x0, M, t):
    k = 1
    while t[k] < X:
        k += 1

    return (1 / (t[k] - t[k - 1])) * (M[k - 1] * pow(t[k] - X, 3) / 6.
              + M[k] * pow(X - t[k - 1], 3) / 6.
              + (x0[k - 1] - M[k - 1] * pow(t[k] - t[k - 1], 2) / 6.) * (t[k] - X)
              + (x0[k] - M[k] * pow(t[k] - t[k - 1], 2) / 6.) * (X - t[k - 1]))


def reset_lsf(X, Y, pow):
    c = [0]
    d = [0]
    a = []

    Pk2 = [1] * len(X)
    EPk1_sq = EPk2_sq = len(X)
    ck1 = calc_ck(X, Pk2, EPk2_sq)
    Pk1 = [x - ck1 for x in X]
    EPk_sq = sum([x * x for x in Pk1])
    c.append(ck1)
    d.append(0)
    a.append(calc_ak(Y, Pk2, EPk2_sq))
    a.append(calc_ak(Y, Pk1, EPk_sq))

    for k in range(2, pow + 1):
        Pk2, Pk1, EPk2_sq, EPk1_sq = Pk1, [(x - ck1) * xPk1 - dk * xPk2 for x, xPk1, xPk2 in zip(X, Pk1, Pk2)], EPk1_sq, EPk_sq
        ck = calc_ck(X, Pk1, EPk1_sq)
        dk = calc_dk(EPk1_sq, EPk2_sq)
        c.append(ck)
        d.append(dk)
        EPk_sq = sum([x * x for x in Pk1])
        a.append(calc_ak(Y, Pk1, EPk_sq))

    return c, d, a

def calc(X, c, d, a):
    Qk2 = 1
    Qk1 = (X - c[0]) * Qk2
    res = a[0] * Qk2 + a[1] * Qk1

    for k in range(2, len(c)):
        Qk2, Qk1 = Qk1, (X - c[k]) * Qk1 - d[k] * Qk2
        res += a[k] * Qk1
    return res

def calc_ck(X, Pk1, EPk1_sq):
    ExPsq = sum(x * p * p for x, p in zip(X, Pk1))
    return ExPsq / EPk1_sq

def calc_dk(EPk1_sq, EPk2_sq):
    return EPk1_sq / EPk2_sq

def calc_ak(Y, Pk, EPk_sq):
    EfPk = sum(y * p for y, p in zip(Y, Pk))
    return EfPk / EPk_sq

def plot_lsf(X, Y, pow=15, from_x=-4, to=5, step=0.01):
    c, d, a = reset_lsf(X, Y, pow)
    x = np.arange(from_x, to, step)
    plt.plot(x, [calc(X_val, c, d, a) for X_val in x], 'y')

#-----------------------------------------

def plot_f(from_x=-4, to_x=5, step=0.01):
    x = np.arange(from_x, to_x, step)
    y = (x - 1.2) * (x + 4.7) * (x - 2.3)
    plt.plot(x, y, 'r')

def plot_data_points(file_data):
    x = [x for x, _ in file_data]
    y = [y for _, y in file_data]
    plt.plot(x, y, 'bo', markersize=3)

def plot_nifs3(file_data, step=0.001):
    sorted_data = sorted(file_data, key=lambda x: x[0])
    x0 = [x for x, y in sorted_data]
    y0 = [y for x, y in sorted_data]
    n = len(x0) - 1
    t = [i / n for i in range(len(x0))]
    Mx = calc_M(x0, t)
    My = calc_M(y0, t)

    res_x = []
    res_y = []
    T = t[0]
    while T <= t[-1]:
        res_x.append(calc_nifs3(T, x0, Mx, t))
        res_y.append(calc_nifs3(T, y0, My, t))
        T += step

    plt.plot(res_x, res_y, 'black')

#-----------------------------------------

file_data = []
with open("punkty.csv", "r") as file:
    for line in file:
        x, y = line.strip().replace(' ', '').split(',')
        file_data.append((float(x), float(y)))

plt.cla()
X = [x for x, y in file_data]
Y = [y for x, y in file_data]
plot_lsf(X, Y)
plot_f()
plot_data_points(file_data)
plot_nifs3(file_data)
plot_lsf(3)
plt.legend(['f(x)', 'data points', 'NIFS3', 'Aproksymacja'])
plt.grid(True)
plt.show()
