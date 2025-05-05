"""
Deo - Web Optimizer
Optimise HTML, CSS, JS, PHP, Java, Dart et Flutter
Compatible avec html-minifier ou minify selon la disponibilité
"""

import os
import shutil
import subprocess
import tkinter as tk
from tkinter import filedialog, messagebox

def run_script(script_name):
    try:
        if os.name == 'nt':
            subprocess.run(['cmd', '/c', script_name], check=True)
        else:
            subprocess.run(['bash', script_name], check=True)
        messagebox.showinfo("Succès", "Optimisation terminée !")
    except subprocess.CalledProcessError as e:
        messagebox.showerror("Erreur", f"Une erreur est survenue :\n{e}")

def select_and_run():
    filename = filedialog.askopenfilename(title="Sélectionner un script", filetypes=[("Scripts", "*.sh *.bat")])
    if filename:
        run_script(filename)

def tool_exists(tool_name):
    return shutil.which(tool_name) is not None

def optimize_selected_files():
    files = filedialog.askopenfilenames(title="Sélectionner des fichiers à optimiser", filetypes=[
        ("Code files", "*.html *.css *.js *.php *.java *.dart"),
        ("Tous les fichiers", "*.*")
    ])
    if not files:
        return

    output_dir = filedialog.askdirectory(title="Choisir un dossier de sortie")
    if not output_dir:
        return

    for file in files:
        ext = os.path.splitext(file)[1].lower()
        base_name = os.path.basename(file)
        dest_path = os.path.join(output_dir, base_name)

        try:
            if ext == ".html":
                if tool_exists("html-minifier"):
                    subprocess.run(["html-minifier", "--collapse-whitespace", "--remove-comments",
                                    "--minify-js", "true", "--minify-css", "true", file, "-o", dest_path], check=True)
                elif tool_exists("minify"):
                    with open(dest_path, "w") as out_file:
                        subprocess.run(["minify", file], check=True, stdout=out_file)
                else:
                    shutil.copy(file, dest_path)
            elif ext == ".css" or ext == ".js":
                if tool_exists("cleancss") and ext == ".css":
                    subprocess.run(["cleancss", "-o", dest_path, file], check=True)
                elif tool_exists("javascript-obfuscator") and ext == ".js":
                    subprocess.run(["javascript-obfuscator", file, "--output", dest_path], check=True)
                elif tool_exists("minify"):
                    with open(dest_path, "w") as out_file:
                        subprocess.run(["minify", file], check=True, stdout=out_file)
                else:
                    shutil.copy(file, dest_path)
            elif ext == ".php":
                shutil.copy(file, dest_path)
            elif ext == ".java":
                java_out_dir = os.path.join(output_dir, "java_classes")
                os.makedirs(java_out_dir, exist_ok=True)
                subprocess.run(["javac", "-d", java_out_dir, file], check=True)
            elif ext == ".dart":
                exe_path = os.path.join(output_dir, os.path.splitext(base_name)[0])
                subprocess.run(["dart", "compile", "exe", file, "-o", exe_path], check=True)
        except Exception as e:
            messagebox.showerror("Erreur", f"Erreur lors du traitement de {base_name} :\n{e}")
            return

    messagebox.showinfo("Succès", "Tous les fichiers sélectionnés ont été optimisés !")

def show_info():
    messagebox.showinfo(
        "Infos",
        "Ce programme permet d'optimiser les fichiers HTML, CSS, JS, PHP, Java, Dart et Flutter.\n\n"
        "Il utilise html-minifier, cleancss, javascript-obfuscator ou minify si disponibles."
    )

root = tk.Tk()
root.title("Deo - Web Optimizer")
root.geometry("420x260")

tk.Label(
    root,
    text="Optimiseur Web (HTML, CSS, JS, PHP, Java, Dart, Flutter)",
    wraplength=400,
    justify="center"
).pack(pady=10)

tk.Button(
    root,
    text="Lancer le script Linux/macOS (.sh)",
    command=lambda: run_script("script-optimize.sh")
).pack(pady=5)

tk.Button(
    root,
    text="Lancer le script Windows (.bat)",
    command=lambda: run_script("script-optimize.bat")
).pack(pady=5)

tk.Button(
    root,
    text="Choisir un script personnalisé",
    command=select_and_run
).pack(pady=5)

tk.Button(
    root,
    text="Optimiser des fichiers manuellement",
    command=optimize_selected_files
).pack(pady=5)

tk.Button(
    root,
    text="À propos",
    command=show_info
).pack(pady=5)

root.mainloop()
