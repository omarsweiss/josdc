def generate_mif(filename, values_str):
    values = values_str.split(", ")  # Split input string into a list of values
    depth = 2048  # Fixed memory depth
    
    # Read the original file
    with open(filename, "r") as file:
        lines = file.readlines()
    
    # Find the CONTENT section
    start_idx = next(i for i, line in enumerate(lines) if "CONTENT BEGIN" in line) + 1
    end_idx = next(i for i, line in enumerate(lines) if "END;" in line)
    
    # Rewrite only the memory initialization part
    new_content = ["\t{}: {};\n".format(i, val.upper()) for i, val in enumerate(values)]
    if len(values) < depth:
        new_content.append("\t[{}..{}]  :   0;\n".format(len(values), depth - 1))
    
    # Replace old content with new values
    lines[start_idx:end_idx] = new_content
    
    # Write back to the file
    with open(filename, "w") as file:
        file.writelines(lines)
    
    print(f"MIF file '{filename}' updated successfully.")

# Example usage
generate_mif("Innovation Phase\dual_issue\dataMemoryInitializationFile.mif", "1, 0, 0, 0, 3, 5, 0, 0, 0, 0, 22, 0")
