"""
Build standalone doc2md.exe using PyInstaller.
Usage: python build_exe.py
Output: dist/doc2md.exe (single file, ~30MB)
"""

import PyInstaller.__main__
import shutil
from pathlib import Path

ROOT = Path(__file__).parent
DIST = ROOT / "dist"
BUILD = ROOT / "build"

# Clean previous builds
for d in (DIST, BUILD):
    if d.exists():
        shutil.rmtree(d)

PyInstaller.__main__.run([
    str(ROOT / "convert.py"),
    "--onefile",
    "--name=doc2md",
    "--noconsole",              # use pythonw-style, no console window
    "--distpath", str(DIST),
    "--workpath", str(BUILD),
    "--specpath", str(BUILD),
    "--clean",
    # Hidden imports that PyInstaller may miss
    "--hidden-import=docx",
    "--hidden-import=pdfplumber",
    "--hidden-import=fitz",
    "--hidden-import=pdfminer",
    "--hidden-import=pdfminer.high_level",
    "--hidden-import=pdfminer.layout",
    "--hidden-import=PIL",
])

# Copy reg files into dist/ for packaging
for reg in ("install_menu_exe.reg", "uninstall_menu.reg"):
    src = ROOT / reg
    if src.exists():
        shutil.copy2(src, DIST / reg)

# Copy bat files into dist/ and ensure CRLF line endings
for bat in ("setup.bat", "uninstall.bat"):
    src = ROOT / bat
    if src.exists():
        content = src.read_text(encoding="utf-8")
        content = content.replace("\r\n", "\n").replace("\n", "\r\n")
        (DIST / bat).write_text(content, encoding="utf-8")

# Copy README
for f in ("README.md", "README_CN.md"):
    src = ROOT / f
    if src.exists():
        shutil.copy2(src, DIST / f)

print(f"\nBuild complete: {DIST / 'doc2md.exe'}")
print(f"Distribute the entire dist/ folder as a zip.")
