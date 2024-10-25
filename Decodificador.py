import tkinter as tk
from tkinter import filedialog, ttk, messagebox
import re

last_op1_per_register = {}

def decode_instruction(instruction):
    global last_op1_per_register
    
    op_code_map = {
        'RESTA': '110',
        'SUMA': '010',
        'MAYORQ': '111',
        'AND': '000',
        'OR': '001',
    }
    
    # Verificar si es una instrucción LEER
    if instruction.startswith('LEER'):
        match = re.match(r'LEER\s+\$(\d+)', instruction)
        if match:
            reg_num = int(match.group(1))
            if reg_num in last_op1_per_register:
                op1 = last_op1_per_register[reg_num]
            else:
                op1 = '00000'
            return f"XXXXX_XXXXX_X_XXX_{op1}_0"

    match = re.match(r'(\w+)\s+\$(\d+),\$(\d+)(?:,\$(\d+))?', instruction)
    if match:
        operation = match.group(1)
        op1 = f"{int(match.group(2)):05b}"
        op2 = f"{int(match.group(3)):05b}"
        we_br = '0'  
        alu_op = op_code_map[operation]
        
        if len(match.groups()) == 4 and match.group(4):
            dir_ram = f"{int(match.group(4)):05b}"
            last_op1_per_register[int(match.group(2))] = op1
        else:
            dir_ram = '00000'

        return f"{op2}_{dir_ram}_{we_br}_{alu_op}_{op1}_{1}" 
    return None

def process_file():
    # Abrir un cuadro de diálogo para seleccionar el archivo
    file_path = filedialog.askopenfilename(title="Seleccionar archivo de instrucciones", filetypes=[("Text files", "*.txt")])
    
    if not file_path:
        return

    with open(file_path, 'r') as file:
        instructions = file.readlines()
    
    results = []
    
    for instruction in instructions:
        decoded = decode_instruction(instruction.strip())
        if decoded:
            results.append(decoded)

    # Guardar los resultados en un nuevo archivo
    output_path = file_path.replace('.txt', '_decoded.txt')
    with open(output_path, 'w') as file:
        for result in results:
            file.write(result + '\n')
    
    messagebox.showinfo("Éxito", f"Archivo procesado y guardado como: {output_path}")

# Configurar la interfaz gráfica
root = tk.Tk()
root.title("Decodificador de Instrucciones")
root.geometry("400x200")
root.configure(bg="#f0f0f0")


style = ttk.Style()
style.configure("TButton", padding=10, relief="flat", background="#0056b3", foreground="red", font=("Arial", 12))
style.map("TButton", background=[("active", "#004080")]) 

frame = ttk.Frame(root, padding=20)
frame.pack(expand=True, fill="both")


title_label = ttk.Label(frame, text="Decodificador de Instrucciones", font=("Arial", 16), background="#f0f0f0")
title_label.pack(pady=10)


process_button = ttk.Button(frame, text="Seleccionar archivo de instrucciones", command=process_file)
process_button.pack(pady=20)


root.mainloop()
