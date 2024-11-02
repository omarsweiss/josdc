def to_twos_complement(value, bits=16):
   
    if value < 0:
        value = (1 << bits) + value  
    return format(value, f"0{bits}b")

def assemble(inp):
  parts = inp.replace(",", "").split()
  opcode = parts[0]
  rtype = ['add','sub','and','or','slt','xor','nor']
  shamtt = ['sll','srl']
  swld = {'sw':'101011', 'lw':'100011'}
  itype = {'addi':'001000', 'beq':'000100', 'bne':'000101', 'ori':'001101', 'xori':'001110', 'andi':'001100' ,'slti':'001010'}
  jtype = {'j': '000010', 'jr':'000000','jal':'000011'}
  register_map = {
    "$zero":"00000",
    "$at": "00001",
    "$v0": "00010",
    "$v1": "00011",
    "$a0": "00100",
    "$a1": "00101",
    "$a2": "00110",
    "$a3": "00111",
    "$t0": "01000",
    "$t1": "01001",
    "$t2": "01010",
    "$t3": "01011",
    "$t4": "01100",
    "$t5": "01101",
    "$t6": "01110",
    "$t7": "01111",
    "$s0": "10000",
    "$s1": "10001",
    "$s2": "10010",
    "$s3": "10011",
    "$s4": "10100",
    "$s5": "10101",
    "$s6": "10110",
    "$s7": "10111",
    "$t8": "11000",
    "$t9": "11001",
    "$k0": "11010",
    "$k1": "11011",
    "$gp": "11100",
    "$sp": "11101",
    "$fp": "11110",
    "$ra": "11111"}

  if opcode in rtype:
    _,dest,src1, src2 = parts
    opcode_binary = format(0b000000,'06b')
    src1_binary = register_map.get(src1,"00000")
    src2_binary = register_map.get(src2,"00000")
    dest_binary = register_map.get(dest,"00000")
    shamt = format(0b00000, '05b')
    funct = format({'add': 0b100000, 'sub': 0b100010, 'and': 0b100100, 'or': 0b100101,'slt': 0b101010, 'xor':0b100110,'nor': 0b100111 }[opcode], '06b')
    machine_code = f"{opcode_binary}{src1_binary}{src2_binary}{dest_binary}{shamt}{funct}"
    return machine_code
  
  elif opcode in shamtt:
    _,dest,src1,shamt = parts 
    opcode_binary = format(0b000000,'06b') 
    src1_binary = register_map.get(src1,"00000")
    src2_binary = format(0b00000, '05b')
    dest_binary = register_map.get(dest,"00000")
    shamt = format(int(shamt), '05b')
    funct = format({'sll': 0b000000, 'srl': 0b000010}[opcode], '06b')
    machine_code = f"{opcode_binary}{src1_binary}{src2_binary}{dest_binary}{shamt}{funct}"
    return machine_code

  elif opcode in itype:
    _,dest,src1, imm = parts
    opcode_binary = itype[opcode]
    src1_binary = register_map.get(src1,"00000")
    dest_binary = register_map.get(dest,"00000")
    imm_binary = to_twos_complement(int(imm), 16)
    machine_code = f"{opcode_binary}{src1_binary}{dest_binary}{imm_binary}"
    return machine_code
  
  elif opcode in swld:
    opcode_binary = swld[opcode]
    src1_binary = register_map.get(parts[1], "00000")
    offset, rs = parts[2].split("(") 
    offset_binary = to_twos_complement(int(offset), 16)
    dest_binary = register_map.get(rs.replace(")", ""), "00000")
    machine_code = f"{opcode_binary}{src1_binary}{dest_binary}{offset_binary}"
    return machine_code


  elif opcode in jtype:
    if (opcode == 'j' or opcode == 'jal'):
      _,  imm = parts
      opcode_binary = jtype[opcode]
      imm_binary = to_twos_complement(int(imm), 26)
      machine_code = f"{opcode_binary}{imm_binary}"
      return machine_code
    else:
      _,  src1 = parts
      opcode_binary = jtype[opcode]
      src1_binary = register_map.get(src1,"00000")
      padding = format(0b0, '021b')
      machine_code = f"{opcode_binary}{src1_binary}{padding}"
      return machine_code
  else:
    return 'instruction not found'

instructions = """lw $t0, 0($s0)
    lw   $t1, 4($s0)
    add  $t2, $t0, $t1
    sub  $t3, $t0, $t1
    and  $t4, $t0, $t1
    or   $t5, $t0, $t1
    xor  $t6, $t0, $t1
    sll  $t7, $t0, 2
    srl  $t8, $t1, 1
    beq  $t0, $t1, 6
    j 6
    sw   $t2, 8($s0)
    sw   $t3, 12($s0)"""
i = 0 
for instruction in instructions.splitlines():
  print(f"{i} : {assemble(instruction)};")
  i += 1
