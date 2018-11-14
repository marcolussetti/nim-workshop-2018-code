import math
import random


def inside(x, y):
    return x**2 + y**2 <= 1


insideCounter = 0
for i in range(0, 1000):
    if inside(random.random(), random.random()):
        insideCounter += 1

pi = insideCounter / 1000.0 * 4
print(pi)
