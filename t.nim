var x = 5

proc customInc(x: var int, delta: int): void =
    x += delta

echo x
customInc(x, 5)
echo x