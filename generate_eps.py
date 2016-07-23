#!/usr/bin/python
import matplotlib.pyplot as plt
import numpy as np


x = np.linspace(0, 100, 200)
y1 = np.sin(x)
plt.plot(x, y1)
plt.xlabel('x')
plt.ylabel('y=sin(x)')
plt.savefig('./test1.eps', format='eps')
plt.close()

plt.plot(x, x)
plt.xlabel('x')
plt.ylabel('y=x')
plt.savefig('./test2.eps', format='eps')
plt.close()

y2 = np.cos(x)
plt.plot(x, y2)
plt.xlabel('x')
plt.ylabel('y=cos(x)')
plt.savefig('./subfolder/test1.eps', format='eps')
plt.close()

y3 = y1 * y2
plt.plot(x, y3)
plt.xlabel('x')
plt.ylabel('y=sin(x)cos(x)')
plt.savefig('./subfolder/test2.eps', format='eps')
plt.close()

