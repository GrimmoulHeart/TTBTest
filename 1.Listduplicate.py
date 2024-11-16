A = [1, 2, 3, 5, 6, 8, 9]
B = [3, 2, 1, 5, 6, 0]

duplicate = list(set(A) & set(B))
print(duplicate)