import numpy as np
import matplotlib.pyplot as plt

n = np.arange(1, 100000, 1)

C1 = 20 + 15000/n
C2 = 60 + 7000/n
C3 = 4 + 47000/n
C4 = 2 + 61000/n

fig = plt.figure(1)
plt.plot(n, C1, n, C2, 'm', n, C3, n, C4)
plt.axis([20, 2000, 30, 400])
plt.show()

k = 10
C2mod = 10 + k + 7000/n

fig = plt.figure(2)
plt.plot(n, C1, n, C2mod)
plt.axis([20, 2000, 0, 400])
plt.show()