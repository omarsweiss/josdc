import Assmebler_Scheduler
import ImemMIFGenerator
import DmemMIFGeneratort
def runCpu():
    instructions = []
    with open("Innovation Phase\Extra Code\imem.txt", 'r') as inst:
        for line in inst:
            parts = line.split(":")
            if len(parts)>1:
                instructions.append(int(parts[1].strip().rstrip(";"),2))

    class Instruction:
        def __init__(self, instruction):
            self.instructionVal = bin(instruction)
            self.opcode = instruction >> 26 & 0b111111
            self.rs = instruction >> 21 & 0b11111
            self.rt = instruction >> 16 & 0b11111
            self.rd = instruction >> 11 & 0b11111
            self.shamt = instruction >> 6 & 0b11111
            self.funct = instruction & 0b111111
            self.imm = instruction & 0xFFFF
            self.cycles = [0] * 5 #creates an array for every stage to record at which stage was an instruction in every cycle
                                    #for example, if an instruction was at Decode stage, then self.cycles[0] = 0 and self.cycoles[1] = 1 and so on... a dictionary might be better.


    class PipelineState:
        def __init__(self):
            self.cycle = 0
            self.ifidFlushT = 0
            self.idexFlushT = 0
            self.ifidFlushNT = 0
            self.idexFlushNT = 0
            self.branchflushcount = 0
            self.branchInstruction  = 0
            self.histReg = 0
            self.taken = 1
            self.ifidStall = 0
            self.pcNT = 0
            self.pcT = 0
            self.registers = [0] *32
            self.memory = [0] * 1024 #can be changed to any size depending on the memory size
            
    class PipelineRegister:
        def __init__(self):
            self.flush = 0
            self.instruction1T = 0
            self.instructionVal1T = 0
            self.instruction2T = 0
            self.instructionVal2T = 0
            self.instruction1NT = 0
            self.instructionVal1NT = 0
            self.instruction2NT = 0
            self.instructionVal2NT = 0
            self.instruction1 = 0
            self.instructionVal1 = 0
            self.instruction2 = 0
            self.instructionVal2 = 0
            self.prediction = 0
            self.stateIndex = 0
            self.last = 0
            self.inst2T = Instruction(0)
            self.inst2NT = Instruction(0)
            self.data = 0 # any data, depending on the stage. signals are interpreted directly w/o a CU so no need for multiple signals 
            self.done = 0
            self.flush = 0
            self.pc = 0 

    IF_ID = PipelineRegister()
    ID_EX = PipelineRegister()
    EX_MEM = PipelineRegister()
    MEM_WB = PipelineRegister()
    state = PipelineState()
    opcodes = {
        0x0 : 'rtype', 0x8: 'addi', 0xd :'ori', 0xe: 'xori', 0xc:'andi', 0xa:'slti',
        0x23: 'lw', 0x2b : 'sw', 0x4:'beq', 0x2:'j', 0x3 : 'jal', 0x5:'bne'
        
    }
    notWrites = [0x2b, 0x4, 0x2, 0x5]
    rtypes = {
        0x20: 'add', 0x22:'sub', 0x24:'and', 0x25: 'or', 0x2a:'slt', 0x26: 'xor', 
        0x27:'nor', 0x0:'sll', 0x2:'srl', 0x8:'jr'
        
    }
    def signed(data):
            if data & 0x8000:
                return data - (1 << 16)  
            else: return data

    def hazard_unit(ID_EX, state, EX_MEM, MEM_WB, IF_ID):
        ldHazardT = False
        ldHazardNT = False
        if IF_ID.done and ID_EX.done:
            memReadT= opcodes[ID_EX.instruction1T.opcode] == 'lw'
            if memReadT and ((IF_ID.rs1T == ID_EX.destreg1T) or (opcodes[IF_ID.instruction1T.opcode] == 'rtype' and (IF_ID.rt1T == ID_EX.destreg1T))):
                ldHazardT = True
            if memReadT and ((IF_ID.rs2T == ID_EX.destreg1T) or (opcodes[IF_ID.instruction2T.opcode] == 'rtype' and (IF_ID.rt2T == ID_EX.destreg1T))):
                ldHazardT = True
            if memReadT and ((IF_ID.rs1T == ID_EX.destreg2T) or (opcodes[IF_ID.instruction1T.opcode] == 'rtype' and (IF_ID.rt1T == ID_EX.destreg2T))):
                ldHazardT = True
            if memReadT and ((IF_ID.rs2T == ID_EX.destreg2T) or (opcodes[IF_ID.instruction2T.opcode] == 'rtype' and (IF_ID.rt2T == ID_EX.destreg2T))):
                ldHazardT = True
            memReadNT= opcodes[ID_EX.instruction1NT.opcode] == 'lw'
            if memReadNT and ((IF_ID.rs1NT == ID_EX.destreg1NT) or (opcodes[IF_ID.instruction1NT.opcode] == 'rtype' and (IF_ID.rt1NT == ID_EX.destreg1NT))):
                ldHazardNT = True
            if memReadNT and ((IF_ID.rs2NT == ID_EX.destreg1NT) or (opcodes[IF_ID.instruction2NT.opcode] == 'rtype' and (IF_ID.rt2NT == ID_EX.destreg1NT))):
                ldHazardNT = True
            if memReadNT and ((IF_ID.rs1NT == ID_EX.destreg2NT) or (opcodes[IF_ID.instruction1NT.opcode] == 'rtype' and (IF_ID.rt1NT == ID_EX.destreg2NT))):
                ldHazardNT = True
            if memReadNT and ((IF_ID.rs2NT == ID_EX.destreg2NT) or (opcodes[IF_ID.instruction2NT.opcode] == 'rtype' and (IF_ID.rt2NT == ID_EX.destreg2NT))):
                ldHazardNT = True
            
        return ldHazardT, ldHazardNT

    def forwarding_unit(EX_MEM, MEM_WB, ID_EX, state):
        if not EX_MEM.done and MEM_WB.done and ID_EX.done:
            writeex1 = 1 if EX_MEM.instruction1.opcode not in notWrites else 0
            writewb1 = 1 if MEM_WB.instruction1.opcode not in notWrites else 0
            writeex2 = 1 if EX_MEM.instruction2.opcode not in notWrites else 0
            writewb2 = 1 if MEM_WB.instruction2.opcode not in notWrites else 0
            #Taken path forwarding
            if writeex1 and EX_MEM.destreg1 == ID_EX.rs1T and EX_MEM.destreg1 != 0:
                op1T = EX_MEM.data1 
            elif writewb1 and MEM_WB.destreg1 == ID_EX.rs1T and MEM_WB.destreg1 !=0:
                op1T = MEM_WB.data1
            else: op1T = state.registers[ID_EX.instruction1T.rs]     
            if writeex2 and EX_MEM.destreg2 == ID_EX.rs1T and EX_MEM.destreg2 != 0:
                op1T = EX_MEM.data2 
            elif writewb2 and MEM_WB.destreg2 == ID_EX.rs1T and MEM_WB.destreg2 !=0:
                op1T = MEM_WB.data2
            
            if writeex1 and EX_MEM.destreg1 == ID_EX.rs2T and EX_MEM.destreg1 != 0:
                op1_2T = EX_MEM.data1 
            elif writewb1 and MEM_WB.destreg1 == ID_EX.rs2T and MEM_WB.destreg1 !=0:
                op1_2T = MEM_WB.data1
            else: op1_2T = state.registers[ID_EX.instruction2T.rs]
            
            if writeex2 and EX_MEM.destreg2 == ID_EX.rs2T and EX_MEM.destreg2 != 0:
                op1_2T = EX_MEM.data2 
            elif writewb2 and MEM_WB.destreg2 == ID_EX.rs2T and MEM_WB.destreg2 !=0:
                op1_2T = MEM_WB.data2


            if writeex1 and EX_MEM.destreg1 == ID_EX.rt1T and EX_MEM.destreg1 != 0:
                op2T = EX_MEM.data1 
            elif writewb1 and MEM_WB.destreg1 == ID_EX.rt1T and MEM_WB.destreg1 !=0:
                op2T = MEM_WB.data1
            else: op2T = state.registers[ID_EX.instruction1T.rt]
            if writeex2 and EX_MEM.destreg2 == ID_EX.rt1T and EX_MEM.destreg2 != 0:
                op2T = EX_MEM.data2 
            elif writewb2 and MEM_WB.destreg2 == ID_EX.rt1T and MEM_WB.destreg2 !=0:
                op2T = MEM_WB.data2
            
            
            if writeex1 and EX_MEM.destreg1 == ID_EX.rt2T and EX_MEM.destreg1 != 0:
                op2_2T = EX_MEM.data1 
            elif writewb1 and MEM_WB.destreg1 == ID_EX.rt2T and MEM_WB.destreg1 !=0:
                op2_2T = MEM_WB.data1
            else: op2_2T = state.registers[ID_EX.instruction2T.rt]
            if writeex2 and EX_MEM.destreg2 == ID_EX.rt2T and EX_MEM.destreg2 != 0:
                op2_2T = EX_MEM.data2 
            elif writewb2 and MEM_WB.destreg2 == ID_EX.rt2T and MEM_WB.destreg2 !=0:
                op2_2T = MEM_WB.data2
            
            
            
            #Not taken path forwarding=================================================
            if writeex1 and EX_MEM.destreg1 == ID_EX.rs1NT and EX_MEM.destreg1 != 0:
                op1NT = EX_MEM.data1 
            elif writewb1 and MEM_WB.destreg1 == ID_EX.rs1NT and MEM_WB.destreg1 !=0:
                op1NT = MEM_WB.data1
            else: op1NT = state.registers[ID_EX.instruction1NT.rs]
            if writeex2 and EX_MEM.destreg2 == ID_EX.rs1NT and EX_MEM.destreg2 != 0:
                op1NT = EX_MEM.data2 
            elif writewb2 and MEM_WB.destreg2 == ID_EX.rs1NT and MEM_WB.destreg2 !=0:
                op1NT = MEM_WB.data2
            
            
            if writeex1 and EX_MEM.destreg1 == ID_EX.rs2NT and EX_MEM.destreg1 != 0:
                op1_2NT = EX_MEM.data1 
            elif writewb1 and MEM_WB.destreg1 == ID_EX.rs2NT and MEM_WB.destreg1 !=0:
                op1_2NT = MEM_WB.data1
            else: op1_2NT = state.registers[ID_EX.instruction2NT.rs]
            if writeex2 and EX_MEM.destreg2 == ID_EX.rs2NT and EX_MEM.destreg2 != 0:
                op1_2NT = EX_MEM.data2 
            elif writewb2 and MEM_WB.destreg2 == ID_EX.rs2NT and MEM_WB.destreg2 !=0:
                op1_2NT = MEM_WB.data2
            

            if writeex1 and EX_MEM.destreg1 == ID_EX.rt1NT and EX_MEM.destreg1 != 0:
                op2NT = EX_MEM.data1 
            elif writewb1 and MEM_WB.destreg1 == ID_EX.rt1NT and MEM_WB.destreg1 !=0:
                op2NT = MEM_WB.data1
            else: op2NT = state.registers[ID_EX.instruction1NT.rt]
            if writeex2 and EX_MEM.destreg2 == ID_EX.rt1NT and EX_MEM.destreg2 != 0:
                op2NT = EX_MEM.data2 
            elif writewb2 and MEM_WB.destreg2 == ID_EX.rt1NT and MEM_WB.destreg2 !=0:
                op2NT = MEM_WB.data2
            
            
            if writeex1 and EX_MEM.destreg1 == ID_EX.rt2NT and EX_MEM.destreg1 != 0:
                op2_2NT = EX_MEM.data1 
            elif writewb1 and MEM_WB.destreg1 == ID_EX.rt2NT and MEM_WB.destreg1 !=0:
                op2_2NT = MEM_WB.data1
            else: op2_2NT = state.registers[ID_EX.instruction2NT.rt]
            if writeex2 and EX_MEM.destreg2 == ID_EX.rt2NT and EX_MEM.destreg2 != 0:
                op2_2NT = EX_MEM.data2 
            elif writewb2 and MEM_WB.destreg2 == ID_EX.rt2NT and MEM_WB.destreg2 !=0:
                op2_2NT = MEM_WB.data2
            
            
            
            return op1T, op2T, op1_2T, op2_2T, op1NT, op2NT, op1_2NT, op2_2NT
        
        else: return state.registers[ID_EX.instruction1T.rs], state.registers[ID_EX.instruction1T.rt], state.registers[ID_EX.instruction2T.rs], state.registers[ID_EX.instruction2T.rt], state.registers[ID_EX.instruction1NT.rs], state.registers[ID_EX.instruction1NT.rt], state.registers[ID_EX.instruction2NT.rs], state.registers[ID_EX.instruction2NT.rt]



    def fetch(state, instructions, IF_ID):
        IF_ID.rs1 = 0
        IF_ID.rt1 = 0
        IF_ID.rs2 = 0
        IF_ID.rt2 = 0
        IF_ID.last = 0
        if IF_ID.done:
            return
        
        if state.pcT < len(instructions):
            inst1T = Instruction(instructions[state.pcT])
        else: 
            IF_ID.last = 1
            inst1T = Instruction(0)
            
        if (state.pcT + 1) < len(instructions):
            inst2T = Instruction(instructions[state.pcT +1])
        else: 
            IF_ID.last = 1
            inst2T = Instruction(0)
            
        if state.pcNT < len(instructions):
            inst1NT = Instruction(instructions[state.pcNT])
        else: 
            IF_ID.last = 1
            inst1NT = Instruction(0)  
            
        if (state.pcNT + 1) < len(instructions):
            inst2NT = Instruction(instructions[state.pcNT +1])
        else: 
            IF_ID.last = 1
            inst2NT = Instruction(0)
            
        if state.ifidFlushT or state.ifidFlushNT:
            if state.ifidFlushT:
                IF_ID.last = 0
                inst1T = Instruction(0)
                inst2T = Instruction(0)
                state.ifidFlushT = 0
            if state.ifidFlushNT:
                IF_ID.last = 0
                inst1NT = Instruction(0)
                inst2NT = Instruction(0)
                state.ifidFlushNT = 0
            
        #Taken Path=============================
        IF_ID.thisPCT = state.pcT
        IF_ID.instruction1T = inst1T
        IF_ID.instructionVal1T = inst1T.instructionVal
        IF_ID.instruction2T = inst2T
        IF_ID.instructionVal2T = inst2T.instructionVal
        if ((opcodes[inst2T.opcode] == 'beq' or opcodes[inst2T.opcode] =='bne' )):
            state.branchInstruction +=1
        IF_ID.rs1T = inst1T.rs
        IF_ID.rt1T = inst1T.rt
        IF_ID.rs2T = inst2T.rs
        IF_ID.rt2T = inst2T.rt
        IF_ID.pcp2T = state.pcT+2
        #Statically assume taken
        if ((opcodes[inst2T.opcode] == 'beq' or opcodes[inst2T.opcode] =='bne' )):
            state.pcT = state.pcT +2+ signed(inst2T.imm )& 0b1111111111
            
        elif opcodes[inst2T.opcode] == 'j' or opcodes[inst2T.opcode] =='jal':
            state.pcT = inst2T.imm &0b1111111111
        else: 
            state.pcT += 2
            
        #Not taken Path=========================
        IF_ID.thisPCNT = state.pcNT
        IF_ID.instruction1NT = inst1NT
        IF_ID.instructionVal1NT = inst1NT.instructionVal
        IF_ID.instruction2NT = inst2NT
        IF_ID.instructionVal2NT = inst2NT.instructionVal
        if ((opcodes[inst2NT.opcode] == 'beq' or opcodes[inst2NT.opcode] =='bne' )):
            state.branchInstruction +=1
        IF_ID.rs1NT = inst1NT.rs
        IF_ID.rt1NT = inst1NT.rt
        IF_ID.rs2NT = inst2NT.rs
        IF_ID.rt2NT = inst2NT.rt
        IF_ID.pcp2NT = state.pcNT+2
        if opcodes[inst2NT.opcode] == 'j' or opcodes[inst2NT.opcode] =='jal':
            state.pcNT = inst2NT.imm &0b1111111111
        else: 
            state.pcNT += 2
                
        IF_ID.nextpcT = state.pcT
        IF_ID.nextpcNT = state.pcNT #The taken path takes this value if the its branch was incorrect
        IF_ID.done = 1



    def decode(state, IF_ID, ID_EX):
        ID_EX.readData1_1T = 0
        ID_EX.readData2_1T = 0
        ID_EX.imm_1T = 0
        ID_EX.last =0
        ID_EX.rs1T = 0
        ID_EX.rt1T = 0
        ID_EX.rd1T = 0
        ID_EX.thisPCT = 0
        ID_EX.pcp2T = 0
        ID_EX.destreg1T = 0
        ID_EX.instruction1T = Instruction(0)
        ID_EX.readData1_2T = 0
        ID_EX.readData2_2T = 0
        ID_EX.imm_2T = 0
        ID_EX.rs2T = 0
        ID_EX.rt2T = 0
        ID_EX.rd2T = 0
        ID_EX.destreg2T = 0
        ID_EX.instruction2T = Instruction(0)
        ID_EX.readData1_1NT = 0
        ID_EX.readData2_1NT = 0
        ID_EX.imm_1NT = 0
        ID_EX.last =0
        ID_EX.rs1NT = 0
        ID_EX.rt1NT = 0
        ID_EX.rd1NT = 0
        ID_EX.thisPCNT = 0
        ID_EX.pcp2NT = 0
        ID_EX.destreg1NT = 0
        ID_EX.instruction1NT = Instruction(0)
        ID_EX.readData1_2NT = 0
        ID_EX.readData2_2NT = 0
        ID_EX.imm_2NT = 0
        ID_EX.rs2NT = 0
        ID_EX.rt2NT = 0
        ID_EX.rd2NT = 0
        ID_EX.destreg2NT = 0
        ID_EX.instruction2NT = Instruction(0)
        if not IF_ID.done: #checks if IFID is fetching another instruction or not
            return
        
        inst1T = IF_ID.instruction1T
        inst2T = IF_ID.instruction2T
        if state.idexFlushT:
            ID_EX.instruction1T = Instruction(0)
            ID_EX.instructionVal1T = 0
            inst1T = Instruction(0)
            ID_EX.instruction2T = Instruction(0)
            ID_EX.instructionVal2T = 0
            inst2T = Instruction(0)
            state.idexFlushT = 0
        
        if opcodes[inst1T.opcode] == 'rtype':
            ID_EX.readData1_1T = state.registers[inst1T.rs]
            ID_EX.readData2_1T = state.registers[inst1T.rt]
        else:
            ID_EX.imm_1T= signed(inst1T.imm)
            ID_EX.readData1_1T = state.registers[inst1T.rs]
            
        if opcodes[inst2T.opcode] == 'rtype':
            ID_EX.readData1_2T = state.registers[inst2T.rs]
            ID_EX.readData2_2T = state.registers[inst2T.rt]
        else:
            ID_EX.imm_2T= signed(inst2T.imm)
            ID_EX.readData1_2T = state.registers[inst2T.rs]
            
        ID_EX.instruction1T = inst1T
        ID_EX.instruction2T = inst2T
        
        
        ID_EX.instructionVal1T = inst1T.instructionVal
        ID_EX.instructionVal2T = inst2T.instructionVal
        
        ID_EX.rs1T = inst1T.rs
        ID_EX.rt1T = inst1T.rt
        ID_EX.rs2T = inst2T.rs
        ID_EX.rt2T = inst2T.rt
        
        validRt1T = opcodes[inst1T.opcode] == 'rtype' or opcodes[inst1T.opcode] =='bne' or opcodes[inst1T.opcode] == 'beq'
        ID_EX.destreg1T = inst1T.rd if validRt1T else inst1T.rt
        validRt2T = opcodes[inst2T.opcode] == 'rtype' or opcodes[inst2T.opcode] =='bne' or opcodes[inst2T.opcode] == 'beq'
        ID_EX.destreg2T = inst2T.rd if validRt2T else inst2T.rt
        
        ID_EX.rd1T = inst1T.rd
        ID_EX.rd2T = inst2T.rd
        #Not taken Path==============================================
        
        
        inst1NT = IF_ID.instruction1NT
        inst2NT = IF_ID.instruction2NT
        if state.idexFlushNT:
            ID_EX.instruction1NT = Instruction(0)
            ID_EX.instructionVal1NT = 0
            inst1NT = Instruction(0)
            ID_EX.instruction2NT = Instruction(0)
            ID_EX.instructionVal2NT = 0
            inst2NT = Instruction(0)
            state.idexFlushNT = 0

        
        if opcodes[inst1NT.opcode] == 'rtype':
            ID_EX.readData1_1NT = state.registers[inst1NT.rs]
            ID_EX.readData2_1NT = state.registers[inst1NT.rt]
        else:
            ID_EX.imm_1NT= signed(inst1NT.imm)
            ID_EX.readData1_1NT = state.registers[inst1NT.rs]
            
        if opcodes[inst2NT.opcode] == 'rtype':
            ID_EX.readData1_2NT = state.registers[inst2NT.rs]
            ID_EX.readData2_2NT = state.registers[inst2NT.rt]
        else:
            ID_EX.imm_2NT= signed(inst2NT.imm)
            ID_EX.readData1_2NT = state.registers[inst2NT.rs]
            
        ID_EX.instruction1NT = inst1NT
        ID_EX.instruction2NT = inst2NT
        
        
        ID_EX.instructionVal1NT = inst1NT.instructionVal
        ID_EX.instructionVal2NT = inst2NT.instructionVal
        
        ID_EX.rs1NT = inst1NT.rs
        ID_EX.rt1NT = inst1NT.rt
        ID_EX.rs2NT = inst2NT.rs
        ID_EX.rt2NT = inst2NT.rt
        
        validRt1NT = opcodes[inst1NT.opcode] == 'rtype' or opcodes[inst1NT.opcode] =='bne' or opcodes[inst1NT.opcode] == 'beq'
        ID_EX.destreg1NT = inst1NT.rd if validRt1NT else inst1NT.rt
        validRt2NT = opcodes[inst2NT.opcode] == 'rtype' or opcodes[inst2NT.opcode] =='bne' or opcodes[inst2NT.opcode] == 'beq'
        ID_EX.destreg2NT = inst2NT.rd if validRt2NT else inst2NT.rt
        
        ID_EX.rd1NT = inst1NT.rd
        ID_EX.rd2NT = inst2NT.rd
        
        ID_EX.pcp2T = IF_ID.pcp2T
        ID_EX.pcp2NT = IF_ID.pcp2NT
        ID_EX.last = IF_ID.last
        
        ID_EX.thisPCT = IF_ID.thisPCT
        ID_EX.thisPCNT = IF_ID.thisPCNT
        ID_EX.done = 1 #IDEX cannot decode and change its value until execute stage is done
        IF_ID.done = 0 # IFID is now allowed to fetch another instruction
        
        
        
        
    def execute(state,ID_EX, EX_MEM, IF_ID):
        if not ID_EX.done: 
            return
        EX_MEM.last =0
        EX_MEM.forwardBres1 = 0
        EX_MEM.imm1 = 0
        EX_MEM.readData1_1 = 0
        EX_MEM.instruction1 = Instruction(0)
        EX_MEM.forwardBres2 = 0
        EX_MEM.imm_2 = 0
        EX_MEM.readData1_2 = 0
        EX_MEM.instruction2 = Instruction(0)
        data1T = 0
        data2T = 0
        data1NT = 0
        data2NT = 0
        inst1T = ID_EX.instruction1T
        inst2T = ID_EX.instruction2T
        inst1NT = ID_EX.instruction1NT
        inst2NT = ID_EX.instruction2NT
        validRt1T = opcodes[inst1T.opcode] == 'rtype' or opcodes[inst1T.opcode] =='bne' or opcodes[inst1T.opcode] == 'beq'
        validRt2T = opcodes[inst2T.opcode] == 'rtype' or opcodes[inst2T.opcode] =='bne' or opcodes[inst2T.opcode] == 'beq'
        
        validRt1NT = opcodes[inst1NT.opcode] == 'rtype' or opcodes[inst1NT.opcode] =='bne' or opcodes[inst1NT.opcode] == 'beq'
        validRt2NT = opcodes[inst2NT.opcode] == 'rtype' or opcodes[inst2NT.opcode] =='bne' or opcodes[inst2NT.opcode] == 'beq'
        
        op1T, op2T, op1_2T, op2_2T, op1NT, op2NT, op1_2NT, op2_2NT = forwarding_unit(EX_MEM=EX_MEM, MEM_WB=MEM_WB, ID_EX=ID_EX, state= state)
        
        if not validRt1T: op2T = ID_EX.imm_1T
        if not validRt2T: op2_2T = ID_EX.imm_2T
        
        if not validRt1NT: op2NT = ID_EX.imm_1NT
        if not validRt2NT: op2_2NT = ID_EX.imm_2NT
        
        if opcodes[inst1T.opcode] == 'rtype':
            if rtypes[inst1T.funct] =='add':
                data1T = op1T + op2T
            elif rtypes[inst1T.funct] =='sub':
                data1T = op1T - op2T
            elif rtypes[inst1T.funct] =='and':
                data1T = op1T & op2T
            elif rtypes[inst1T.funct] =='or':
                data1T = op1T | op2T
            elif rtypes[inst1T.funct] =='slt':
                data1T = 1 if op1T<op2T else 0
            elif rtypes[inst1T.funct] =='xor':
                data1T = op1T ^ op2T
            elif rtypes[inst1T.funct] =='nor':
                data1T = ~(op1T | op2T)
            elif rtypes[inst1T.funct] =='sll':
                data1T = op1T <<inst1T.shamt
            elif rtypes[inst1T.funct] =='srl':
                data1T = op1T >> inst1T.shamt
                
        elif opcodes[inst1T.opcode] == 'addi':
            data1T = op1T+op2T
        elif opcodes[inst1T.opcode] == 'ori':
            data1T = op1T|op2T
        elif opcodes[inst1T.opcode] == 'xori':
            data1T = op1T^op2T
        elif opcodes[inst1T.opcode] == 'andi':
            data1T = op1T& op2T
        elif opcodes[inst1T.opcode] == 'slti':
            data1T = 1 if op1T<op2T else 0
        elif opcodes[inst1T.opcode] == 'sw': data1T = state.registers[inst1T.rt]
        else: data1T = 0
        
        if opcodes[inst1NT.opcode] == 'rtype':
            if rtypes[inst1NT.funct] =='add':
                data1NT = op1NT + op2NT
            elif rtypes[inst1NT.funct] =='sub':
                data1NT = op1NT - op2NT
            elif rtypes[inst1NT.funct] =='and':
                data1NT = op1NT & op2NT
            elif rtypes[inst1NT.funct] =='or':
                data1NT = op1NT | op2NT
            elif rtypes[inst1NT.funct] =='slt':
                data1NT = 1 if op1NT<op2NT else 0
            elif rtypes[inst1NT.funct] =='xor':
                data1NT = op1NT ^ op2NT
            elif rtypes[inst1NT.funct] =='nor':
                data1NT = ~(op1NT | op2NT)
            elif rtypes[inst1NT.funct] =='sll':
                data1NT = op1NT <<inst1NT.shamt
            elif rtypes[inst1NT.funct] =='srl':
                data1NT = op1NT >> inst1NT.shamt
        elif opcodes[inst1NT.opcode] == 'addi':
            data1NT = op1NT+op2NT
        elif opcodes[inst1NT.opcode] == 'ori':
            data1NT = op1NT|op2NT
        elif opcodes[inst1NT.opcode] == 'xori':
            data1NT = op1NT^op2NT
        elif opcodes[inst1NT.opcode] == 'andi':
            data1NT = op1NT&op2NT
        elif opcodes[inst1NT.opcode] == 'slti':
            data1NT = 1 if op1NT<op2NT else 0
        elif opcodes[inst1NT.opcode] == 'sw': data1NT = state.registers[inst1NT.rt]
        else: data1NT = 0
        
        
        if opcodes[inst2T.opcode] == 'rtype':
            if rtypes[inst2T.funct] =='add':
                data2T = op1_2T + op2_2T
            elif rtypes[inst2T.funct] =='sub':
                data2T = op1_2T - op2_2T
            elif rtypes[inst2T.funct] =='and':
                data2T = op1_2T & op2_2T
            elif rtypes[inst2T.funct] =='or':
                data2T = op1_2T | op2_2T
            elif rtypes[inst2T.funct] =='slt':
                data2T = 1 if op1_2T<op2_2T else 0
            elif rtypes[inst2T.funct] =='xor':
                data2T = op1_2T ^ op2_2T
            elif rtypes[inst2T.funct] =='nor':
                data2T = ~(op1_2T| op2_2T)
            elif rtypes[inst2T.funct] =='sll':
                data2T = op1_2T <<inst2T.shamt
            elif rtypes[inst2T.funct] =='srl':
                data2T = op1_2T >> inst2T.shamt
                
        elif opcodes[inst2T.opcode] == 'addi':
            data2T = op1_2T+op2_2T
        elif opcodes[inst2T.opcode] == 'ori':
            data2T = op1_2T|op2_2T
        elif opcodes[inst2T.opcode] == 'xori':
            data2T = op1_2T^op2_2T
        elif opcodes[inst2T.opcode] == 'andi':
            data2T = op1_2T&op2_2T
        elif opcodes[inst2T.opcode] == 'slti':
            data2T = 1 if op1_2T<op2_2T else 0
        elif opcodes[inst2T.opcode] == 'sw': data2T = state.registers[inst2T.rt]
        else: data2T = 0
        
        if opcodes[inst2NT.opcode] == 'rtype':
            if rtypes[inst2NT.funct] =='add':
                data2NT = op1_2NT + op2_2NT
            elif rtypes[inst2NT.funct] =='sub':
                data2NT = op1_2NT - op2_2NT
            elif rtypes[inst2NT.funct] =='and':
                data2NT = op1_2NT & op2_2NT
            elif rtypes[inst2NT.funct] =='or':
                data2NT = op1_2NT | op2_2NT
            elif rtypes[inst2NT.funct] =='slt':
                data2NT = 1 if op1_2NT<op2_2NT else 0
            elif rtypes[inst2NT.funct] =='xor':
                data2NT = op1_2NT ^ op2_2NT
            elif rtypes[inst2NT.funct] =='nor':
                data2NT = ~(op1_2NT| op2_2NT)
            elif rtypes[inst2NT.funct] =='sll':
                data2NT = op1_2NT <<inst2NT.shamt
            elif rtypes[inst2NT.funct] =='srl':
                data2NT = op1_2NT >> inst2NT.shamt
        elif opcodes[inst2NT.opcode] == 'addi':
            data2NT = op1_2NT+op2_2NT
        elif opcodes[inst2NT.opcode] == 'ori':
            data2NT = op1_2NT|op2_2NT
        elif opcodes[inst2NT.opcode] == 'xori':
            data2NT = op1_2NT^op2_2NT
        elif opcodes[inst2NT.opcode] == 'andi':
            data2NT = op1_2NT&op2_2NT
        elif opcodes[inst2NT.opcode] == 'slti':
            data2NT = 1 if op1_2NT<op2_2NT else 0
        elif opcodes[inst2NT.opcode] == 'sw': data2NT = state.registers[inst2NT.rt]
        else: data2NT = 0
        

        if(opcodes[inst2T.opcode] == 'bne'):
            if op1_2T == op2_2T:
                state.taken = 0
            else: state.taken = 1
        elif(opcodes[inst2T.opcode] == 'beq'):
            if op1_2T == op2_2T:
                state.taken = 1
            else: state.taken = 0
            
        if(opcodes[inst2NT.opcode] == 'bne'):
            if op1_2NT == op2_2NT:
                state.taken = 0
            else: state.taken = 1
        elif(opcodes[inst2NT.opcode] == 'beq'):
            if op1_2NT == op2_2NT:
                state.taken = 1
            else: state.taken = 0  
            
            
            
        if opcodes[inst2T.opcode] == 'bne' or opcodes[inst2T.opcode] == 'beq':
            if state.taken:
                if IF_ID.inst2T and opcodes[IF_ID.inst2T.opcode] == 'beq' or opcodes[IF_ID.inst2T.opcode] == 'beq':
                    state.pcNT = IF_ID.pcp2T
                    state.idexFlushNT = 1
                else:
                    state.pcNT = state.pcT
                    state.idexFlushNT = 1

            else:
                state.pcT = state.pcNT
                state.idexFlushT = 1
                
        if opcodes[inst2NT.opcode] == 'bne' or opcodes[inst2NT.opcode] == 'beq':
            if state.taken:
                state.pcNT = state.pcT
                state.idexFlushNT = 1
            else:
                if IF_ID.inst2NT and opcodes[IF_ID.inst2NT.opcode] == 'beq' or opcodes[IF_ID.inst2NT.opcode] == 'beq' :
                    state.pcT = IF_ID.pcp2NT +signed(IF_ID.inst2NT.imm )& 0b1111111111
                    state.idexFlushT = 1
                else:
                    state.pcT = state.pcNT
                    state.idexFlushT = 1
        
        if opcodes[inst2T.opcode] == 'rtype' and rtypes[inst2T.funct] == 'jr':
            state.pcT = state.registers[inst2T.rs] & 0b1111111111
            state.pcNT = state.pcT
            state.ifidFlushT = 1
            state.idexFlushNT = 1
        if opcodes[inst2NT.opcode] == 'rtype' and rtypes[inst2NT.funct] == 'jr':
            state.pcT = state.registers[inst2NT.rs] & 0b1111111111
            state.pcNT = state.pcT
            state.ifidFlushT = 1
            state.idexFlushNT = 1
               
        
                
        taken = state.taken              
        EX_MEM.instruction1 = inst1T if taken else inst1NT
        EX_MEM.instructionVal1 = inst1T.instructionVal if taken else inst1NT.instructionVal
        
        EX_MEM.imm_1 = ID_EX.imm_1T if taken else ID_EX.imm_1NT
        
        EX_MEM.instruction2 = inst2T if taken else inst2NT
        EX_MEM.instructionVal2 = inst2T.instructionVal if taken else inst2NT.instructionVal
        
        EX_MEM.imm_2 = ID_EX.imm_2T if taken else ID_EX.imm_2NT
        
        EX_MEM.readData1_1 = ID_EX.readData1_1T if taken else ID_EX.readData1_1NT 
        EX_MEM.readData1_2 = ID_EX.readData1_2T if taken else ID_EX.readData1_2NT
        
        EX_MEM.rs1 = inst1T.rs if taken else inst1NT.rs 
        EX_MEM.rt1 = inst1T.rt if taken else inst1NT.rt
        EX_MEM.rd1 = inst1T.rd if taken else inst1NT.rd
        
        EX_MEM.rs2 = inst2T.rs if taken else inst2NT.rs 
        EX_MEM.rt2 = inst2T.rt if taken else inst2NT.rt
        EX_MEM.rd2 = inst2T.rd if taken else inst2NT.rd
                
        EX_MEM.op1 = op1T if taken else op1NT    
        EX_MEM.op2 = op2T if taken else op2NT
        EX_MEM.op1_2 = op1_2T if taken else op1_2NT
        EX_MEM.op2_2 = op2_2T if taken else op1_2NT

        EX_MEM.data1 = data1T if taken else data1NT
        EX_MEM.data2 = data2T if taken else data2NT
        
        EX_MEM.last = ID_EX.last
        EX_MEM.thisPC = ID_EX.thisPCT if taken else ID_EX.thisPCNT
        EX_MEM.destreg1 = (inst1T.rd if validRt1T else inst1T.rt) if taken else (inst1NT.rd if validRt1NT else inst1NT.rt)
        EX_MEM.destreg2 = (inst2T.rd if validRt2T else inst2T.rt) if taken else (inst2NT.rd if validRt2NT else inst2NT.rt)
        
        EX_MEM.pcp2 = ID_EX.pcp2T if taken else ID_EX.pcp2NT
        EX_MEM.done = 1
        ID_EX.done = 0
            
            
                
            
                
    def memory (state, EX_MEM, MEM_WB):
        MEM_WB.last =0
        if not EX_MEM.done: #checks if exeucte is executing or not
            return
        inst1 = EX_MEM.instruction1
        op1 = 0
        op12 = 0
        datastored = 0
        datastored2 = 0
        inst2 = EX_MEM.instruction2
        if MEM_WB.instruction1:
            writewb1 = 1 if MEM_WB.instruction1.opcode not in notWrites else 0
        if MEM_WB.instruction2:   
            writewb2 = 1 if MEM_WB.instruction2.opcode not in notWrites else 0
            
        if opcodes[inst1.opcode] == 'lw':
            data1 = state.memory[EX_MEM.op1 + EX_MEM.imm_1]
        elif opcodes[inst1.opcode] == 'sw':
            if writewb2 and MEM_WB.destreg2 == inst1.rs and MEM_WB.destreg2 !=0:
                op1 = MEM_WB.data2  
            elif writewb1 and MEM_WB.destreg1 == inst1.rs and MEM_WB.destreg1 !=0:
                op1 = MEM_WB.data1
            else:
                op1 = EX_MEM.op1  
                
            if writewb2 and MEM_WB.destreg2 == inst1.rt and MEM_WB.destreg2 !=0:
                datastored = MEM_WB.data2
            elif writewb1 and MEM_WB.destreg1 == inst1.rt and MEM_WB.destreg1 !=0:
                datastored = MEM_WB.data1
            else:
                datastored = state.registers[inst1.rt]
            state.memory[op1 + EX_MEM.imm_1] = datastored
           
        if opcodes[inst2.opcode] == 'lw':
            data2 = state.memory[EX_MEM.op1_2 + EX_MEM.imm_2]
            
        elif opcodes[inst2.opcode] == 'sw':
            
            if writewb2 and MEM_WB.destreg2 == inst2.rs and MEM_WB.destreg2 !=0:
                op12 = MEM_WB.data2  
            elif writewb1 and MEM_WB.destreg1 == inst2.rs and MEM_WB.destreg1 !=0:
                op12 = MEM_WB.data1
            else:
                op12 = EX_MEM.op1_2  
            if writewb2 and MEM_WB.destreg2 == inst2.rt and MEM_WB.destreg2 !=0:
                datastored2 = MEM_WB.data2
            elif writewb1 and MEM_WB.destreg1 == inst2.rt and MEM_WB.destreg1 !=0:
                datastored2 = MEM_WB.data1
            else:
                datastored2 = state.registers[inst2.rt]
                
            state.memory[op12 + EX_MEM.imm_2] = datastored2
        
        MEM_WB.instruction1 = inst1
        MEM_WB.instructionVal1 = inst1.instructionVal
        MEM_WB.instruction2 = inst2
        MEM_WB.instructionVal2 = inst2.instructionVal
        MEM_WB.data1 = EX_MEM.data1 if opcodes[inst1.opcode] != 'lw' else data1
        MEM_WB.data2 = EX_MEM.data2 if opcodes[inst2.opcode] != 'lw' else data2
        MEM_WB.rs1 = inst1.rs
        MEM_WB.rt1 = inst1.rt
        MEM_WB.rd1 = inst1.rd
        MEM_WB.rs2 = inst2.rs
        MEM_WB.rt2 = inst2.rt
        MEM_WB.rd2 = inst2.rd
        
        MEM_WB.last = EX_MEM.last
        MEM_WB.thisPC = EX_MEM.thisPC
        MEM_WB.destreg1 = EX_MEM.destreg1
        MEM_WB.destreg2 = EX_MEM.destreg2
        MEM_WB.done = 1
        EX_MEM.done =0
        
        
    opcodes = {
        0x0 : 'rtype', 0x8: 'addi', 0xd :'ori', 0xe: 'xori', 0xc:'andi', 0xa:'slti',
        0x23: 'lw', 0x2b : 'sw', 0x4:'beq', 0x2:'j', 0x3 : 'jal', 0x5:'bne'
        
    }


    def writeBack(state, MEM_WB):
        if not MEM_WB.done:
            return
        inst1 = MEM_WB.instruction1
        inst2 = MEM_WB.instruction2
        if opcodes[inst1.opcode] != 'sw' and opcodes[inst1.opcode] !='j' and opcodes[inst1.opcode] !='jal' and opcodes[inst1.opcode] !='bne' and opcodes[inst1.opcode] !='beq':
            state.registers[inst1.rd if opcodes[inst1.opcode] == 'rtype' else inst1.rt] = MEM_WB.data1
            
        if opcodes[inst2.opcode] != 'sw' and opcodes[inst2.opcode] !='j' and opcodes[inst2.opcode] !='jal' and opcodes[inst2.opcode] !='bne' and opcodes[inst2.opcode] !='beq':
            state.registers[inst2.rd if opcodes[inst2.opcode] == 'rtype' else inst2.rt] = MEM_WB.data2
            
        if opcodes[inst2.opcode] == 'jal':
            state.registers[31] = MEM_WB.thisPC + 2
        MEM_WB.done = 0
        
        
        
        
    def printState(stages):
        for stage, reg in stages.items():
                print(f"{stage}: \n")
                for signal, value in vars(reg).items():
                    print(f"{signal}: {value}")
                print("-"*20)
                
    def read_binary_file(filename):
        binary_values = []

        with open(filename, 'r') as file:
            for line in file:
                if '0x' in line:
                    binary_values.append(int(line.strip(), 16))
                else: 
                    binary_values.append(int(line.strip()))  # Remove any whitespace or newline characters

        return binary_values
    instr_countT = 0
    instr_countNT = 0
    filename = "Innovation Phase\Extra Code\dmem.txt"
    binary_array = read_binary_file(filename)
    print(f'\nValues in the memory: \n{binary_array}\n')    
    #Initialize the pipeline state
    IF_ID = PipelineRegister()
    ID_EX = PipelineRegister()
    EX_MEM = PipelineRegister()
    MEM_WB = PipelineRegister()
    state = PipelineState()
    for i in range(len(binary_array)):
        state.memory[i] = binary_array[i]
    cycle = 0
    countofstalls = 0
    cycles = 5000
    stages = {'IF_ID':IF_ID, 'ID_EX': ID_EX, 'EX_MEM': EX_MEM, 'MEM_WB': MEM_WB }
    while (cycle < cycles):
        if MEM_WB.last:break
        writeBack(state, MEM_WB)
        memory(state, EX_MEM, MEM_WB)
        ldHazardT, ldHazardNT = hazard_unit(ID_EX, state, EX_MEM, MEM_WB, IF_ID)
        if ldHazardT:
            state.pcT = IF_ID.thisPCT
            state.idexFlushT = 1
            print("load hazard detected")
            countofstalls +=1
        if ldHazardNT:
            state.pcNT = IF_ID.thisPCNT
            state.idexFlushNT = 1
            
        execute(state, ID_EX, EX_MEM, IF_ID)
        decode(state, IF_ID, ID_EX)
        fetch(state, instructions, IF_ID)
        
        
        cycle +=1
    state.pc = 0
    
    
    
    
    
    print(f"\n\n{'-' *50}")
    print(f"Cycle {cycle}")
    def print_registers(registers):
        print("\nFinal Register Values:")
        print(f"{'-' * 50}")
        for i, value in enumerate(registers):
            print(f"R{i:2}: {value}")
        print(f"{'-' * 50}\n")

    print_registers(state.registers[0:32])

    def printMemory(memory):
        print ("\nFinal mem values:")
        print(f"{"-"*50}")
        for i in range(32):
            print(f"M{i:2}: {memory[i]}")
        print(f"{"-"*50}")
    printMemory(state.memory)
    print("cycle count: ", cycle)
    print("ld hazard count: ", countofstalls)
    print("branch flush count: ", state.branchflushcount)
    print("branch instruction count: ", state.branchInstruction )
    


            
instructions_nonBinary = Assmebler_Scheduler.schedule("""\
ADDI $13, $0, 20
ADD $11, $0, $0
LOOP1:
XOR $21, $11, $0
# this line is commented, use it for byte addressing memory
# SLL $21, $11, 2
ADD $12, $0, $0
LOOP2: 
XOR $22, $12, $0
# this line is commented, use it for byte addressing memory
# SLL $22, $12, 2
LW $8, 0x0($21)
LW $9, 0x0($22)
IF: 
SLT $10, $8, $9
BEQ $10, $0, ENDIF
ADD $3, $8, $0
ADD $8, $9, $0
ADD $9, $3, $0
SW $8, 0x0($21)
SW $9, 0x0($22)
ENDIF: 
ADDI $12, $12, 1
SLT $10, $12, $13
BNE $10, $0, LOOP2
ADDI $11, $11, 1
SLT $10, $11, $13
BNE $10, $0, LOOP1
NOP
                                          
""")
instructions = Assmebler_Scheduler.assembler(instructions_nonBinary)
ImemMIFGenerator.generate_mif("Innovation Phase\Extra Code\imem.txt", instructions)
ImemMIFGenerator.generate_mif("Innovation Phase\dual_issue\instructionMemoryInitializationFile.mif", instructions)
DmemMIFGeneratort.generate_mif("Innovation Phase\Extra Code\dmem.txt", "0x5, 0x7, 0x2, 0xF, 0xA, 0x10, 0x30, 0x1, 0xFF, 0x55, 0x0, 0x6, 0xAB, 0xAD, 0x99, 0x33, 0x1, 0x16, 0x22, 0x79" )
DmemMIFGeneratort.generate_mif("Innovation Phase\dual_issue\dataMemoryInitializationFile.mif", "0x5, 0x7, 0x2, 0xF, 0xA, 0x10, 0x30, 0x1, 0xFF, 0x55, 0x0, 0x6, 0xAB, 0xAD, 0x99, 0x33, 0x1, 0x16, 0x22, 0x79" )
state = runCpu()


        


                
        