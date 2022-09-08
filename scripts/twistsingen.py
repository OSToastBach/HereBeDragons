from math import sin

for i in range(1024):
    print(int(sin(i/24)*sin(i/44)*32)+32, end=',')
