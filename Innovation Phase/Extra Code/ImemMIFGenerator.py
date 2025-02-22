def generate_mif(filename, values_str, depth=1024, is_dmemory=False):
    values = values_str.strip().split("\n")  # Split input string into lines
    
    # Read the original file
    with open(filename, "r") as file:
        lines = file.readlines()
    if filename == "Innovation Phase\dual_issue\instructionMemoryInitializationFile.mif":
        # Find the CONTENT section
        start_idx = next(i for i, line in enumerate(lines) if "CONTENT BEGIN" in line) + 1
        end_idx = next(i for i, line in enumerate(lines) if "END;" in line)
    
    # Process input values to match expected format
    new_content = []
    for line in values:
        address, value = line.split(":")
        address = address.strip()
        value = value.strip().rstrip(";")        
        new_content.append(f"{address} : {value};\n")
    if filename == "Innovation Phase\dual_issue\instructionMemoryInitializationFile.mif":
        # Fill remaining memory with zeros if needed
        last_address = int(values[-1].split(':')[0]) if values else -1
        if last_address < depth - 1:
            new_content.append(f"[{last_address+1}..{depth-1}]: 0;\n")
    
        # Replace old content with new values
        lines[start_idx:end_idx] = new_content
    if filename == "Innovation Phase\dual_issue\instructionMemoryInitializationFile.mif":
        # Write back to the file
        with open(filename, "w") as file:
            file.writelines(lines)
    else:
        with open(filename, "w") as file:
            file.writelines(new_content)
    
    print(f"MIF file '{filename}' updated successfully.")


imemory_values = """0 : 00110100000000100000000000000000;
1 : 00100000000101000000000000001010;
2 : 00111000000111110000000000000001;
3 : 00110000000001010000000000000000;
4 : 10001100101010100000000000000000;
5 : 10001100101011110000000000000000;
6 : 00100000010000100000000000000001;
7 : 00000000000000000000000000000000;
8 : 00000000010101001100100000101010;
9 : 00000000000000000000000000000000;
10 : 00000000000000000000000000000000;
11 : 00010111111110010000000000010010;
12 : 00000000010000000010100000100000;
13 : 00000000000000000000000000000000;
14 : 10001100101100000000000000000000;
15 : 00000000000000000000000000000000;
16 : 00000000000000000000000000000000;
17 : 00000000000000000000000000000000;
18 : 00000001010100001101000000101010;
19 : 00000000000000000000000000000000;
20 : 00000000000000000000000000000000;
21 : 00010000000110100000000000000010;
22 : 00000010000000000101000000100101;
23 : 00001000000000000000000000000110;
24 : 00000010000011111101100000101010;
25 : 00000000000000000000000000000000;
26 : 00000000000000000000000000000000;
27 : 00010000000110111111111111101010;
28 : 00000010000000000111100000100000;
29 : 00001000000000000000000000000110;
30 : 00000000000000000000000000000000;
31 : 00000000000000000000000000000000;"""

generate_mif("Innovation Phase\dual_issue\instructionMemoryInitializationFile.mif", imemory_values)
generate_mif("Innovation Phase\Extra Code\imem.txt", imemory_values)
