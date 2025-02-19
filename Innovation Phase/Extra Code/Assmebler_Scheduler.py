def schedule(instructions_in):
    # Define sets of opcodes for different instruction types:
    immediate_opcodes = {"ADDI", "ANDI", "ORI", "XORI", "SLTI", "SLL", "Scheduler.ipynb"}
    load_opcodes      = {"LW"}
    store_opcodes     = {"SW"}
    branch_opcodes    = {"BEQ", "BNE"}
    jump_opcodes      = {"J", "JR", "JAL"}

    class Instruction:
        def __init__(self, line):
            # Remove commas and extra whitespace, then split into tokens.
            tokens = line.replace(",", "").split()
            if not tokens:
                return
            self.line = line.strip() if line != "NOP" else "SLL $0, $0, 0"
            self.latency = None if line != "NOP" else 0
            # Set default fields
            self.opcode = tokens[0].upper() if line != "NOP"  else "SLL"
            self.dest = None if line != "NOP" else "$0"
            self.rs = None if line != "NOP" else "$0"
            self.rt = None
            self.immediate = None if line != "NOP" else "0"
            # Flags 
            self.is_load = False
            self.is_store = False
            self.is_branch = False
            self.is_jump = False
            if line != "NOP":
                # Parse based on opcode type:
                if self.opcode in load_opcodes:
                    # Format: LW $t, offset($s)
                    # tokens[1] is the destination register (t)
                    # tokens[2] is in the form offset($s)
                    self.dest = tokens[1]
                    operand = tokens[2]
                    open_paren = operand.find('(')
                    close_paren = operand.find(')')
                    if open_paren != -1 and close_paren != -1:
                        self.immediate = operand[:open_paren]  # offset
                        self.rs = operand[open_paren+1:close_paren]  # base register
                    else:
                        self.immediate = operand
                    self.latency = 2
                    self.is_load = True

                elif self.opcode in store_opcodes:
                    # Format: SW $t, offset($s)
                    # For a store, there is no destination; 
                    # we treat $t as the register whose value is stored.
                    self.rt = tokens[1]
                    operand = tokens[2]
                    self.latency = 0
                    open_paren = operand.find('(')
                    close_paren = operand.find(')')
                    if open_paren != -1 and close_paren != -1:
                        self.immediate = operand[:open_paren]  # offset
                        self.rs = operand[open_paren+1:close_paren]  # base register
                    else:
                        self.immediate = operand
                    self.is_store = True

                elif self.opcode in branch_opcodes:
                    # Format: BEQ $s, $t, label
                    # Branches only have two registers.
                    self.rs = tokens[1]
                    self.rt = tokens[2]
                    self.latency = 0
                    if len(tokens) >= 4:
                        self.immediate = tokens[3]  # branch target
                    self.is_branch = True

                elif self.opcode in jump_opcodes:
                    self.latency = 0
                    # Format: J label, JR $s, or JAL label
                    if len(tokens) >= 2:
                        self.immediate = tokens[1]
                    self.is_jump = True

                elif self.opcode in immediate_opcodes:
                    # Immediate instructions: e.g. ADDI $t, $s, imm
                    # Here, destination is the first operand (t), then rs, then immediate.
                    self.latency = 1
                    self.dest = tokens[1]
                    self.rs = tokens[2]
                    if len(tokens) >= 4:
                        self.immediate = tokens[3]

                else:
                    # Assume R-type instruction: e.g. ADD $d, $s, $t
                    # Parsed as: dest = tokens[1], rs = tokens[2], rt = tokens[3]
                    self.dest = tokens[1]
                    self.latency = 1
                    self.rs = tokens[2]
                    if len(tokens) >= 4:
                        self.rt = tokens[3]

        def __repr__(self):
            # Reconstruct a representation for debugging.
            parts = [self.opcode]
            if self.dest is not None:
                parts.append(self.dest)
            if self.rs is not None:
                parts.append(self.rs)
            if self.rt is not None:
                parts.append(self.rt)
            if self.immediate is not None:
                parts.append(self.immediate)
            return " ".join(parts)


    def unpseudo(instructions):
        unpseudoed = []
        for instruction in instructions.splitlines():
            label = ''
            
            instruction = instruction.replace(",", "").strip()
            instruction = instruction.split()
            if ":" in instruction[0]:
                label = str(instruction[0]) + ' '
                first = str(instruction[1]).upper()
                instruction = instruction[1:]
            else:
                first = str(instruction[0]).upper()
                
            if first == 'SGT':
                # Transform SGT: sgt A, B, C  =>  slt A, C, B
                unpseudoed.append(label + 'SLT ' + str(instruction[1]) + ' ' + str(instruction[3]) + ' ' + str(instruction[2]))
            elif first == 'LI':
                # Transform LI: li A, imm  =>  ori A, $0, imm
                unpseudoed.append(label + 'ORI ' + str(instruction[1]) + ' $0 ' + str(instruction[2]))
            elif first == 'BLT':
                unpseudoed.append(label + 'ORI $30 ' + str(instruction[1]) + ' ' + str(instruction[2]))
                unpseudoed.append('BNE $30 $0 ' + str(instruction[3]))
            elif first == 'BLE':
                unpseudoed.append(label + 'SLT $30 ' + str(instruction[2]) + ' ' + str(instruction[1]))
                unpseudoed.append('BEQ $30 $0 ' + str(instruction[3]))
            elif first == 'BGT':
                unpseudoed.append(label + 'SLT $30 ' + str(instruction[2]) + ' ' + str(instruction[1]))
                unpseudoed.append('BNE $30 $0 ' + str(instruction[3]))
            elif first == 'BGE':
                unpseudoed.append(label + 'SLT $30 ' + str(instruction[1]) + ' ' + str(instruction[2]))
                unpseudoed.append('BEQ $30 $0 ' + str(instruction[3]))
            elif first == 'BLTZ':
                unpseudoed.append(label + 'SLTI $30 ' + str(instruction[1]) + ' 0')
                unpseudoed.append('BNE $30 $0 ' + str(instruction[2]))
            elif first == 'BGEZ':
                unpseudoed.append(label + 'SLTI $30 ' + str(instruction[1]) + ' 0')
                unpseudoed.append('BEQ $30 $0 ' + str(instruction[2]))
            else:
                unpseudoed.append(label + ' '.join(instruction))
        return unpseudoed

    def is_label(line):
        if  isinstance(line, Instruction):
            return False
        """Return True if the line is a label (ends with ':')."""
        return line.endswith(':')

    def is_pseudo(line):
        """Returns if an instruction is pseudo or not"""
        tokens = line.split()
        if not tokens:
            return False
        opcode = tokens[0].upper()
        pseudos = {"SGT", "LI", "BLT", "BLE", "BGT", "BGE", "BLTZ", "BGEZ"}
        return opcode in pseudos

    def is_branch(line):
        """Return True if the line starts with a branch opcode."""
        tokens = line.split()
        if not tokens:
            return False
        opcode = tokens[0].upper()
        branch_opcodes = {"BEQ", "BNE", "BLE", "BGT", "BLT", "BGE", "BLTZ", "BGEZ"}
        return opcode in branch_opcodes

    def is_jump(line):
        """Return True if the line starts with a jump opcode."""
        tokens = line.split()
        if not tokens:
            return False
        opcode = tokens[0].upper()
        jump_opcodes = {"J", "JR", "JAL"}
        return opcode in jump_opcodes

    def is_boundary(line):
        """A line is a boundary if it is a label, branch, or jump."""
        return is_label(line) or is_branch(line) or is_jump(line)

    def segment_code(code_str):
        """
        Accepts a string containing the assembly code.
        - Removes comments (ignores any text following '#').
        - Splits the code into lines.
        - Segments the code so that boundaries (labels, branches, jumps)
        are isolated as their own segments.
        
        Returns a list of segments (each segment is a list of lines).
        """
        segments = []
        current_segment = []
        
        # Split the input string into individual lines.
        lines = code_str.splitlines()
        for raw_line in lines:
            # Remove comments (anything after '#' is discarded) and trim whitespace.
            line = raw_line.split('#')[0].strip()
            if not line:
                continue  # Skip empty lines
            
            # If the instruction is pseudo, convert it.
            if is_pseudo(line):
                unpseudo_lines = []
                unpseudo_lines = unpseudo(line)
            else:
                unpseudo_lines = []
                unpseudo_lines = [line]
                
            for line1 in unpseudo_lines:
                if is_boundary(line1):
                    # Finalize any existing non-boundary segment.
                    if current_segment:
                        segments.append(current_segment)
                        segments.append([line1])
                        current_segment = []
                            
                    else:
                        # If there's no current segment, the boundary becomes its own segment.
                        segments.append([line1])
                
                else:
                    # Non-boundary line: add to the current segment.
                    current_segment.append(line1)
        
        # Add any leftover non-boundary instructions as a final segment.
        if current_segment:
            segments.append(current_segment)
        
        return segments




    import collections

    #------------------------------------------------------------------------------
    # Helper Functions and Definitions
    #------------------------------------------------------------------------------

    NOP = Instruction("NOP")


    def is_lw(instr):
        """Return True if the instruction is a load-word instruction."""
        return instr.opcode == "LW"

    def build_dependency_graph(instructions):
        """
        Build a dependency graph as a list of sets.
        dependencies[i] is the set of instruction indices that must come before instruction i.
        """
        n = len(instructions)
        dependencies = [set() for _ in range(n)]
        for i in range(n):
            for j in range(i):
                # If instr i reads a register that instr j writes, add dependency.
                if instructions[j].dest:
                    if instructions[i].rs and instructions[i].rs == instructions[j].dest:
                        dependencies[i].add(j)
                    if instructions[i].rt and instructions[i].rt == instructions[j].dest:
                        dependencies[i].add(j)
        return dependencies



    #------------------------------------------------------------------------------
    # Main Rescheduling Routine
    #------------------------------------------------------------------------------
    def reschedule(instructions):
        unscheduled = set(range(len(instructions)))
        scheduled = {}
        packets = []
        cycle = 0
        while unscheduled:
            ready = []
            for i in unscheduled:
                # Check if all dependencies are scheduled.
                if not all(dep in scheduled for dep in graph[i]):
                    continue
                # If an LW was scheduled only one cycle before it. Delay it
                delay_due_to_lw = False
                for dep in graph[i]:
                    if is_lw(instructions[dep]) and scheduled[dep] >= cycle -1:
                        delay_due_to_lw = True
                        break
                if delay_due_to_lw:
                    continue
                #Append the index of the ready instruction
                ready.append(i)
            # If no instruction is ready, add an empty packet
            if not ready:
                packets.append([NOP, NOP])
                cycle += 1
                continue
            candidate1 = None
            candidate2 = None
            for i in ready:
                if not is_branch(instructions[i].line) and not is_jump(instructions[i].line):
                    candidate1 = i
                    break
            for i in ready:
                if candidate1 is not None and i == candidate1:
                    continue
                candidate2 = i
                break
            slot1 = instructions[candidate1] if candidate1 is not None else NOP
            slot2 = instructions[candidate2] if candidate2 is not None else NOP
            
            #Append packet and update scheduled 
            packets.append([slot1, slot2])
            if candidate1 is not None:
                scheduled[candidate1] = cycle
                unscheduled.remove(candidate1)
            if candidate2 is not None and candidate2 != candidate1:
                scheduled[candidate2] = cycle
                unscheduled.remove(candidate2)
            cycle += 1
        final_schedule = [instr for packet in  packets for instr in packet]
        return final_schedule       
            
    final_code = []  # This will collect the final scheduled code as a list of Instruction objects.
    
    print(f"Original Code{'='*50}\n")
    print(instructions_in)
        
        
    print(f'\n')   
    print(f"Segmented Code{'='*50}\n")
    segments = segment_code(instructions_in)
    # Display the resulting segments:
    for idx, segment in enumerate(segments):
        print(f"Segment {idx}:")
        for line in segment:
            print(f"  {line}")


    for segment in segments:
        # Convert each line to an Instruction object.
        if len(segment) >1:
            segment_instrs = [Instruction(line) for line in segment]
            graph = build_dependency_graph(segment_instrs)
            final_schedule = reschedule(segment_instrs)
            for i in final_schedule:
                final_code.append(i)
        else:
            if is_branch(segment[0]):
                final_code.append(NOP.line)
                final_code.append(segment[0])
            elif is_jump(segment[0]):
                final_code.append(NOP.line)
                final_code.append(segment[0])
            elif is_label(segment[0]):
                final_code.append(segment[0])
            elif segment[0] == 'NOP':
                final_code.append(Instruction("NOP").line)
                final_code.append(NOP.line)
            else:
                final_code.append(segment[0])
                final_code.append(NOP.line)

    def generate_scheduled_code(final_code):
        output = []
        prev_was_label = False
        for i in final_code:
            if isinstance(i, str) and is_label(i):  
                if prev_was_label:
                    output[-1] += i + " "  # Append label inline

                else:
                    output.append(i + " ")  # Start a new label line
                prev_was_label = True
            else:
                output.append(str(i.line if not isinstance(i, str) else i) + "\n")
                prev_was_label = False

        return "".join(output)  # Return the full string
    final_instructions = generate_scheduled_code(final_code)
    print(f'\n')
    print(f'Final Scheduled Code{'='*50}\n')
    print(final_instructions)
    return final_instructions





def to_twos_complement(value, bits=16):
    """Converts a signed integer to its two's complement binary representation."""
    if isinstance(value, str) and value.startswith("0x"):
        value = int(value, 16)  # Convert hex string to integer
    else:
        value = int(value)  # Ensure it's an integer

    if value < 0:
        value = (1 << bits) + value  # Convert negative values to two's complement

    return format(value, f"0{bits}b")  # Format as binary string

def assemble(inp):
    parts = inp.replace(",", "").split()
    opcode = parts[0]
    
    rtype = {'add', 'sub', 'and', 'or', 'slt', 'xor', 'nor'}
    shamtt = {'sll', 'srl'}
    swld = {'sw': '101011', 'lw': '100011'}
    itype = {'addi': '001000', 'beq': '000100', 'bne': '000101', 'ori': '001101', 'xori': '001110', 'andi': '001100', 'slti': '001010'}
    jtype = {'j': '000010', 'jr': '000000', 'jal': '000011'}
    register_map = {f"${i}": format(i, '05b') for i in range(32)}

    if opcode in rtype:
        _, dest, src1, src2 = parts
        opcode_binary = '000000'
        src1_binary = register_map.get(src1, "00000")
        src2_binary = register_map.get(src2, "00000")
        dest_binary = register_map.get(dest, "00000")
        shamt = '00000'
        funct = format({'add': 0b100000, 'sub': 0b100010, 'and': 0b100100, 'or': 0b100101, 'slt': 0b101010, 'xor': 0b100110, 'nor': 0b100111}[opcode], '06b')
        return f"{opcode_binary}{src1_binary}{src2_binary}{dest_binary}{shamt}{funct}"
    
    elif opcode in shamtt:
        _, dest, src1, shamt = parts 
        opcode_binary = '000000'
        src1_binary = register_map.get(src1, "00000")
        src2_binary = '00000'
        dest_binary = register_map.get(dest, "00000")
        shamt = format(int(shamt, 16) if shamt.startswith("0x") else int(shamt), '05b')
        funct = format({'sll': 0b000000, 'srl': 0b000010}[opcode], '06b')
        return f"{opcode_binary}{src1_binary}{src2_binary}{dest_binary}{shamt}{funct}"
    
    elif opcode in itype:
        _, dest, src1, imm = parts
        opcode_binary = itype[opcode]
        src1_binary = register_map.get(src1, "00000")
        dest_binary = register_map.get(dest, "00000")
        imm_binary = to_twos_complement(imm, 16)
        return f"{opcode_binary}{src1_binary}{dest_binary}{imm_binary}"
    
    elif opcode in swld:
        opcode_binary = swld[opcode]
        src1_binary = register_map.get(parts[1], "00000")
        offset, rs = parts[2].split("(") 
        offset_binary = to_twos_complement(offset, 16)
        dest_binary = register_map.get(rs.replace(")", ""), "00000")
        return f"{opcode_binary}{dest_binary}{src1_binary}{offset_binary}"
    
    elif opcode in jtype:
        if opcode in {'j', 'jal'}:
            _, imm = parts
            opcode_binary = jtype[opcode]
            imm_binary = to_twos_complement(imm, 26)
            return f"{opcode_binary}{imm_binary}"
        else:
            _, src1 = parts
            opcode_binary = jtype[opcode]
            src1_binary = register_map.get(src1, "00000")
            padding = '000000000000000'
            funct = '001000'
            return f"{opcode_binary}{src1_binary}{padding}{funct}"
    else:
        return 'instruction not found'

def labeling(instructions):
    labels = {}
    labeled = []
    for i, instruction in enumerate(instructions):
        first = instruction.split()[0]
        if ':' in first:
            labels[first[:-1]] = i
            labeled.append(' '.join(instruction.split()[1:]))
        else:
            labeled.append(instruction)
    for i, instruction in enumerate(labeled):
        if instruction.split()[0] in ['j', 'jal', 'bne', 'beq'] and instruction.split()[-1] in labels:
            offset = labels[instruction.split()[-1]] - (i + 1) if instruction.split()[0] in ['bne', 'beq'] else labels[instruction.split()[-1]]
            labeled[i] = ' '.join(instruction.split()[:-1]) + ' ' + str(offset)
    return labeled

def unpseudo(instructions):
    unpseudoed = []
    for instruction in instructions.splitlines():
        label = ''
        instruction = instruction.replace(",", "").strip().split()
        if ":" in instruction[0]:
            label = instruction[0] + ' '
            instruction = instruction[1:]
        if instruction[0] == 'sgt':
            unpseudoed.append(label + 'slt ' + instruction[1] + ' ' + instruction[3] + ' ' + instruction[2])
        elif instruction[0] == 'li':
            imm = instruction[2]
            if imm.startswith("0x"):
                imm = str(int(imm, 16))  # Convert hex to decimal string
            unpseudoed.append(label + 'ori ' + instruction[1] + ' $0 ' + imm)
        elif instruction[0] in ['blt', 'ble', 'bgt', 'bge']:
            reg = '$30'
            unpseudoed.append(label + 'slt ' + reg + ' ' + instruction[1] + ' ' + instruction[2])
            unpseudoed.append(('beq' if instruction[0] in ['ble', 'bge'] else 'bne') + ' ' + reg + ' $0 ' + instruction[3])
        elif instruction[0] in ['bltz', 'bgez']:
            reg = '$30'
            imm = instruction[2]
            if imm.startswith("0x"):
                imm = str(int(imm, 16))  # Convert hex to decimal string
            unpseudoed.append(label + 'slti ' + reg + ' ' + instruction[1] + ' ' + imm)
            unpseudoed.append(('beq' if instruction[0] == 'bgez' else 'bne') + ' ' + reg + ' $0 ' + instruction[2])
        else:
            unpseudoed.append(label + ' '.join(instruction))
    return unpseudoed

def assembler(instructions_in):
    instructions_in = instructions_in.lower().strip()
    instructions = labeling(unpseudo(instructions_in))
    for i, instruction in enumerate(instructions):
        print(f"{i} : {assemble(instruction)};")















instructions = """\
# Initialize registers
ADDI $2 , $0, 5 # $2 = 5
ADDI $3 , $0, 10 # $3 = 10
ANDI $31, $0, 0x0 # $31 = 0
ADD $31 ,$0, $3
ADD $3 , $0, $2
ADD $2 , $0, $31
# For word addressable # For Byte Addressable
Sw $2, 0x1($0) 
Sw $3, 0x2($0) 
ADDI $4 , $0, 15 # $4 = 15
ADDI $5 , $0, 20 # $5 = 20
ADD $5 , $4, $5
SUB $4 , $5, $4
SUB $5 , $5, $4
# For word addressable # For Byte Addressable
Sw $4, 0x3($0) 
Sw $5, 0x4($0) 
ADDI $6, $0 , 25 # $6 = 25
ADDI $7, $0 , 30 # $7 = 30
XOR $6, $6 , $7
XOR $7, $6 , $7
XOR $6, $6 , $7
# For word addressable # For Byte Addressable
Sw $6, 0x5($0) 
Sw $7, 0x6($0) 
NOP # (NOP equals to SLL $0, $0, 0)

"""



final_code = schedule(instructions)

assembler(final_code)







