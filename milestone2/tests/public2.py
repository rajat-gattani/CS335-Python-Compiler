data: list[float] = [-2.3, 3.14, 0.9, 11, -9.1]


def compute_min() -> float:
  min_value: float = 0.0
  i: int = 0
  j: int = len(data)
  for i in range(j):
    if min_value>0:
      min_value = data[i]
    elif data[i] < min_value:
      min_value = data[i]
  return min_value


def compute_avg() -> float:
  avg_value: float = 0.0
  sum: float = 0
  i: int = 0
  j: int = len(data)
  for i in range(j):
    sum += data[i]
  return sum / len(data)


def main():
  min_value: float = compute_min()
  print("Minimum value: ")
  print(min_value)
  avg_value: float = compute_avg()
  print("Average value: ")
  print(avg_value)


if __name__ == "__main__":
  main()
