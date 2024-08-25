class testing():

  def loop_func1(n:int)->int:
    i:int
    j:int

    for i in range(3,8):
      a : int = n
      for j in range(10):
        b : int = 5
        if(j==5):
          b += 1
          break
      a = a + 2
      if(a < 7):
        break
    return j

  def loop_func2(n:int)->int:
    k:int
    l:int
    for k in range(3,8):
      c : int = n
      for l in range(10):
        d : int = 5
        if(l==5):
          d += 1
          continue
      c = c + 2
      if(c < 7):
        break
    return l 


def main():
  obj : testing = testing()
  print(obj.loop_func1(5))
  print(obj.loop_func2(5))

if __name__ == "__main__":
  main()
