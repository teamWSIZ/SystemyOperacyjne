
#wyniki powinny byc ~4sek

import math
u=0
for i in range(0,10000):
  for j in range(0,1000):
    u += math.sin(i*j)
print u
