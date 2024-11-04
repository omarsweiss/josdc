

def int_to_binary(num, num_bits):
    if num >= 0:

        binary = format(num, f'0{num_bits}b')
    else:

        binary = format((1 << num_bits) + num, f'0{num_bits}b')

    return binary

def hex_to_bin(hex_num, num_bits):

    decimal_num = int(hex_num[2:], 16)

    return int_to_binary(decimal_num, num_bits)

def assemble(inp):
  parts = inp.split()
  opcode = parts[0]
  rtype = ['add','sub','and','or','slt']
  itype = {'sw':'101011', 'lw':'100011', 'addi':'001000', 'beq':'000100'}
  jtype = {'jump': '001100', 'jr':'001110'}
  if opcode in rtype:
    _,dest,src1, src2,  = parts
    opcode_binary = format(0b000000,'06b')
    src1_binary = format(int(src1[1:]), '05b')
    src2_binary = format(int(src2[1:]), '05b')
    dest_binary = format(int(dest[1:]), '05b')
    shamt = format(0b00000, '05b')
    funct = format({'add': 0b100000, 'sub': 0b100010, 'and': 0b100100, 'or': 0b100101,'slt': 0b101010}[opcode], '06b')
    machine_code = f"{opcode_binary}{src1_binary}{src2_binary}{dest_binary}{shamt}{funct}"
    return machine_code

  elif opcode in itype:
    _,dest,src1, imm = parts
    opcode_binary = itype[opcode]
    src1_binary = format(int(src1[1:]), '05b')
    dest_binary = format(int(dest[1:]), '05b')
    imm_binary = hex_to_bin(imm, 16)
    machine_code = f"{opcode_binary}{src1_binary}{dest_binary}{imm_binary}"
    return machine_code
  elif opcode in jtype:
    if opcode == 'jump':
      _,  imm = parts
      opcode_binary = jtype[opcode]
      imm_binary = hex_to_bin(imm, 26)
      machine_code = f"{opcode_binary}{imm_binary}"
      return machine_code
    else:
      _,  src1 = parts
      opcode_binary = jtype[opcode]
      src1_binary = format(int(src1[1:]), '05b')
      padding = format(0b0, '021b')
      machine_code = f"{opcode_binary}{src1_binary}{padding}"
      return machine_code
  else:
    return 'instruction not found'

instructions = """addi $5 $0 0xff
addi $6 $0 0x55
sub $7 $5 $6
sw $7 $0 0x00
lw $8 $20 0x00
beq $6 $7 0x03
or $9 $6 $7
and $8 $6 $7
add $0 $6 $7
slt $10 $0 $5
addi $11 $11 0x20 """
i = 0 # try slt when we set, implement label stuff shit, try over/underflow instr
for instruction in instructions.splitlines():
  print(f"{i} : {assemble(instruction)};")
  i += 1

