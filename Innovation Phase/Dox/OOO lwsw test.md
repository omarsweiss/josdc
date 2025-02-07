### Benchmark 1: Basic Store and Load
**Objective:** Test basic store and load functionality.
```assembly
addi $1, $0, 10      # $1 = 10
sw $1, 0($0)         # Store $1 at memory address 0
lw $2, 0($0)         # Load from memory address 0 into $2
```

``` binary
0 : 00100000000000010000000000001010;
1 : 10101100000000010000000000000000;
2 : 10001100000000100000000000000000;
```

**Expected Values:**
- `$1 = 10`
- `$2 = 10`

### Benchmark 2: Load-Use Dependency
**Objective:** Test load-use dependency (RAW hazard).
```assembly
addi $1, $0, 20      # $1 = 20
sw $1, 4($0)         # Store $1 at memory address 4
lw $2, 4($0)         # Load from memory address 4 into $2
addi $3, $2, 5       # $3 = $2 + 5 (should be 25)
```

``` binary
0 : 00100000000000010000000000010100;
1 : 10101100000000010000000000000100;
2 : 10001100000000100000000000000100;
3 : 00100000010000110000000000000101;
```

**Expected Values:**
- `$1 = 20`
- `$2 = 20`
- `$3 = 25`

### Benchmark 3: Store-Store Dependency
**Objective:** Test store-store dependency (WAW hazard).
```assembly
addi $1, $0, 30      # $1 = 30
addi $2, $0, 40      # $2 = 40
sw $1, 8($0)         # Store $1 at memory address 8
sw $2, 8($0)         # Store $2 at memory address 8 (overwrite)
lw $3, 8($0)         # Load from memory address 8 into $3
```

``` binary
0 : 00100000000000010000000000011110;
1 : 00100000000000100000000000101000;
2 : 10101100000000010000000000001000;
3 : 10101100000000100000000000001000;
4 : 10001100000000110000000000001000;
```
**Expected Values:**
- `$1 = 30`
- `$2 = 40`
- `$3 = 40`

### Benchmark 4: Load-Store Dependency
**Objective:** Test load-store dependency (WAR hazard).
```assembly
addi $1, $0, 50      # $1 = 50
sw $1, 12($0)        # Store $1 at memory address 12
lw $2, 12($0)        # Load from memory address 12 into $2
addi $3, $2, 10      # $3 = $2 + 10 (should be 60)
sw $3, 12($0)        # Store $3 at memory address 12 (overwrite)
lw $4, 12($0)        # Load from memory address 12 into $4
```

```binary
0 : 00100000000000010000000000110010;
1 : 10101100000000010000000000001100;
2 : 10001100000000100000000000001100;
3 : 00100000010000110000000000001010;
4 : 10101100000000110000000000001100;
5 : 10001100000001000000000000001100;
```

**Expected Values:**
- `$1 = 50`
- `$2 = 50`
- `$3 = 60`
- `$4 = 60`

### Benchmark 5: Forwarding from Store to Load
**Objective:** Test forwarding from store to load.
```assembly
addi $1, $0, 70      # $1 = 70
sw $1, 16($0)        # Store $1 at memory address 16
lw $2, 16($0)        # Load from memory address 16 into $2
addi $3, $2, 20      # $3 = $2 + 20 (should be 90)
```

``` binary
0 : 00100000000000010000000001000110;
1 : 10101100000000010000000000010000;
2 : 10001100000000100000000000010000;
3 : 00100000010000110000000000010100;
```
**Expected Values:**
- `$1 = 70`
- `$2 = 70`
- `$3 = 90`

### Benchmark 6: Multiple Loads and Stores
**Objective:** Test multiple loads and stores with dependencies.
```assembly
addi $1, $0, 100     # $1 = 100
sw $1, 20($0)        # Store $1 at memory address 20
lw $2, 20($0)        # Load from memory address 20 into $2
addi $3, $2, 30      # $3 = $2 + 30 (should be 130)
sw $3, 24($0)        # Store $3 at memory address 24
lw $4, 24($0)        # Load from memory address 24 into $4
addi $5, $4, 40      # $5 = $4 + 40 (should be 170)
```

```binary
0 : 00100000000000010000000001100100;
1 : 10101100000000010000000000010100;
2 : 10001100000000100000000000010100;
3 : 00100000010000110000000000011110;
4 : 10101100000000110000000000011000;
5 : 10001100000001000000000000011000;
6 : 00100000100001010000000000101000;
```


**Expected Values:**
- `$1 = 100`
- `$2 = 100`
- `$3 = 130`
- `$4 = 130`
- `$5 = 170`

### Benchmark 7: Load After Store with Different Addresses
**Objective:** Test load after store with different addresses.
```assembly
addi $1, $0, 200     # $1 = 200
sw $1, 28($0)        # Store $1 at memory address 28
addi $2, $0, 300     # $2 = 300
sw $2, 32($0)        # Store $2 at memory address 32
lw $3, 28($0)        # Load from memory address 28 into $3
lw $4, 32($0)        # Load from memory address 32 into $4
add $5, $3, $4       # $5 = $3 + $4 (should be 500)
```
```binary
0 : 00100000000000010000000011001000;
1 : 10101100000000010000000000011100;
2 : 00100000000000100000000100101100;
3 : 10101100000000100000000000100000;
4 : 10001100000000110000000000011100;
5 : 10001100000001000000000000100000;
6 : 00000000011001000010100000100000;
```
**Expected Values:**
- `$1 = 200`
- `$2 = 300`
- `$3 = 200`
- `$4 = 300`
- `$5 = 500`

### Benchmark 8: Store-Load Dependency with Immediate Offset
**Objective:** Test store-load dependency with an immediate offset.
```assembly
addi $1, $0, 400     # $1 = 400
sw $1, 36($0)        # Store $1 at memory address 36
lw $2, 36($0)        # Load from memory address 36 into $2
addi $3, $2, 50      # $3 = $2 + 50 (should be 450)
```

```binary
0 : 00100000000000010000000110010000;
1 : 10101100000000010000000000100100;
2 : 10001100000000100000000000100100;
3 : 00100000010000110000000000110010;

```
**Expected Values:**
- `$1 = 400`
- `$2 = 400`
- `$3 = 450`

### Benchmark 9: Load-Store Dependency with Immediate Offset
**Objective:** Test load-store dependency with an immediate offset.
```assembly
addi $1, $0, 500     # $1 = 500
sw $1, 40($0)        # Store $1 at memory address 40
lw $2, 40($0)        # Load from memory address 40 into $2
addi $3, $2, 60      # $3 = $2 + 60 (should be 560)
sw $3, 44($0)        # Store $3 at memory address 44
lw $4, 44($0)        # Load from memory address 44 into $4
```

```binary
0 : 00100000000000010000000111110100;
1 : 10101100000000010000000000101000;
2 : 10001100000000100000000000101000;
3 : 00100000010000110000000000111100;
4 : 10101100000000110000000000101100;
5 : 10001100000001000000000000101100;
```
**Expected Values:**
- `$1 = 500`
- `$2 = 500`
- `$3 = 560`
- `$4 = 560`

### Benchmark 10: Complex Dependency Chain
**Objective:** Test a complex chain of dependencies involving multiple loads and stores.
```assembly
addi $1, $0, 600     # $1 = 600
sw $1, 48($0)        # Store $1 at memory address 48
lw $2, 48($0)        # Load from memory address 48 into $2
addi $3, $2, 70      # $3 = $2 + 70 (should be 670)
sw $3, 52($0)        # Store $3 at memory address 52
lw $4, 52($0)        # Load from memory address 52 into $4
addi $5, $4, 80      # $5 = $4 + 80 (should be 750)
sw $5, 56($0)        # Store $5 at memory address 56
lw $6, 56($0)        # Load from memory address 56 into $6
```

```binary
0 : 00100000000000010000001001011000;
1 : 10101100000000010000000000110000;
2 : 10001100000000100000000000110000;
3 : 00100000010000110000000001000110;
4 : 10101100000000110000000000110100;
5 : 10001100000001000000000000110100;
6 : 00100000100001010000000001010000;
7 : 10101100000001010000000000111000;
8 : 10001100000001100000000000111000;
```
**Expected Values:**
- `$1 = 600`
- `$2 = 600`
- `$3 = 670`
- `$4 = 670`
- `$5 = 750`
- `$6 = 750`
