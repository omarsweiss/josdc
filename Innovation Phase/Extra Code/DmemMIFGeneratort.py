def generate_mif(filename, values_str):
    # Split input string into a list of values
    hex_values = values_str.split(", ")
    if filename == "Innovation Phase\\dual_issue\\dataMemoryInitializationFile.mif":
        # Convert hex strings to unsigned integers
        unsigned_values = []
        for hex_val in hex_values:
            # Remove '0x' prefix if present and convert to integer
            if hex_val.startswith('0x'):
                int_value = int(hex_val, 16)
            else:
                int_value = hex_val
            unsigned_values.append(int_value)

        depth = 2048  # Fixed memory depth
    
        # Read the original file
        with open(filename, "r") as file:
            lines = file.readlines()
    
        # Find the CONTENT section
        start_idx = next(i for i, line in enumerate(lines) if "CONTENT BEGIN" in line) + 1
        end_idx = next(i for i, line in enumerate(lines) if "END;" in line)
    
        # Rewrite only the memory initialization part with unsigned values
        new_content = []
        for i, val in enumerate(unsigned_values):
            new_content.append("\t{}: {};\n".format(i, val))

        if len(unsigned_values) < depth:
            new_content.append("\t[{}..{}]  :   0;\n".format(len(unsigned_values), depth - 1))
    
        # Replace old content with new values
        lines[start_idx:end_idx] = new_content
    
        # Write back to the file
        with open(filename, "w") as file:
            file.writelines(lines)
    
        print(f"MIF file '{filename}' updated successfully with unsigned values.")
    else:
        new_content = []
        for val in hex_values:
            new_content.append(f'{val}\n')
        with open(filename, 'w') as file:
            file.writelines(new_content)
        print(f"MIF file '{filename}' updated successfully with unsigned values.")
            

# Example usage
generate_mif("Innovation Phase\\dual_issue\\dataMemoryInitializationFile.mif", 
            "0, 1, 2, 3, 1, 14, 1111111 ")


generate_mif("Innovation Phase\Extra Code\dmem.txt", 
            "0, 1, 2, 3, 123, 12 ")