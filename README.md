# shuck-doc2md

<p align="center">
  <b>English</b> | <a href="README_CN.md">中文</a>
</p>

A lightweight Windows tool that converts **Word (.docx)** and **PDF** files to **Markdown**, with full image extraction. Right-click any document in Explorer → **"To Markdown"** → done.

## Features

- **DOCX to Markdown** — headings, bold/italic, lists, tables, inline images
- **PDF to Markdown** — text extraction with page separators and embedded images
- **Image extraction** — all images saved to `{filename}_images/` with proper markdown references
- **In-place output** — `.md` and images created next to the original file
- **Windows context menu** — one-click conversion from Explorer
- **Toast notifications** — success/failure feedback via Windows 10/11

## Output

```
Documents/
├── report.docx
├── report.md              ← generated
└── report_images/         ← extracted images
    ├── image_001.png
    └── image_002.jpg
```

## Installation

### Option A: Portable EXE (no Python needed)

1. Download the latest release zip from [Releases](https://github.com/Shan-Zhu/shuck-doc2md/releases)
2. Extract to any folder
3. Double-click **`setup.bat`** to register the right-click menu
4. To uninstall, double-click **`uninstall.bat`**

### Option B: From Source (Python 3.10+)

```bash
git clone https://github.com/Shan-Zhu/shuck-doc2md.git
cd shuck-doc2md
pip install python-docx pdfplumber PyMuPDF
```

Edit `install_menu.reg` — replace the Python and script paths with yours:

```reg
@="\"C:\\Python314\\pythonw.exe\" \"D:\\Tools\\doc2md\\convert.py\" \"%1\""
```

Double-click `install_menu.reg` to register. Use `uninstall_menu.reg` to remove.

## Usage

**Right-click** any `.docx` or `.pdf` in Explorer → **"To Markdown"**

Or from the command line:

```bash
# Python
python convert.py "path/to/document.docx"

# EXE
doc2md.exe "path/to/document.pdf"
```

## Build EXE from Source

```bash
pip install pyinstaller
python build_exe.py
```

Output: `dist/doc2md.exe`

## How It Works

| Source | Text | Images |
|--------|------|--------|
| `.docx` | python-docx XML parsing (headings, lists, tables, formatting) | Extracted from `w:drawing` and `v:imagedata` |
| `.pdf` | pdfplumber text extraction | PyMuPDF image extraction (optional, graceful fallback) |

## License

[MIT](LICENSE)
