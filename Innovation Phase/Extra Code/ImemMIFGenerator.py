def generate_mif(filename, values_str, depth=1024, is_dmemory=False):
    values = values_str.strip().split("\n")  # Split input string into lines
    
    # Read the original file
    with open(filename, "r") as file:
        lines = file.readlines()
    
    # Find the CONTENT section
    start_idx = next(i for i, line in enumerate(lines) if "CONTENT BEGIN" in line) + 1
    end_idx = next(i for i, line in enumerate(lines) if "END;" in line)
    
    # Process input values to match expected format
    new_content = []
    for line in values:
        address, value = line.split(":")
        address = address.strip()
        value = value.strip().rstrip(";")
        
        # Convert hex values to unsigned binary if needed
        if is_dmemory and value.startswith("0x"):
            value = int(value, 16)
        
        new_content.append(f"{address} : {value};\n")
    
    # Fill remaining memory with zeros if needed
    last_address = int(values[-1].split(':')[0]) if values else -1
    if last_address < depth - 1:
        new_content.append(f"[{last_address+1}..{depth-1}]: 0;\n")
    
    # Replace old content with new values
    lines[start_idx:end_idx] = new_content
    
    # Write back to the file
    with open(filename, "w") as file:
        file.writelines(lines)
    
    print(f"MIF file '{filename}' updated successfully.")


imemory_values = """0 : 00100000000000100000000000000101;
1 : 00100000000000110000000000001010;
2 : 00110000000111110000000000000000;
3 : 00000000000000111111100000100000;
4 : 00000000000000100001100000100000;
5 : 00000000000111110001000000100000;
6 : 10101100000000100000000000000001;
7 : 10101100000000110000000000000010;
8 : 00100000000001000000000000001111;
9 : 00100000000001010000000000010100;
10 : 00000000100001010010100000100000;
11 : 00100000000001100000000000011001;
12 : 00000000101001000010000000100010;
13 : 00100000000001110000000000011110;
14 : 00000000101001000010100000100010;
15 : 10101100000001000000000000000011;
16 : 10101100000001010000000000000100;
17 : 00000000110001110011000000100110;
18 : 00000000110001110011100000100110;
19 : 00000000000000000000000000000000;
20 : 00000000110001110011000000100110;
21 : 10101100000001110000000000000110;
22 : 10101100000001100000000000000101;
23 : 00000000000000000000000000000000;"""

generate_mif("Innovation Phase\dual_issue\instructionMemoryInitializationFile.mif", imemory_values)
