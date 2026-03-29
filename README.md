# shuck-doc2md

<p align="center">
  <b>English</b> | <a href="README_CN.md">中文</a>
</p>

A lightweight Windows right-click tool that converts **Word (.docx)** and **PDF** files to **Markdown**, with full image extraction.

Right-click any `.docx` or `.pdf` file in Windows Explorer → **"To Markdown"** → get a clean `.md` file with images saved alongside.

## Features

- **DOCX to Markdown** — headings, bold/italic, lists, tables, inline images
- **PDF to Markdown** — text extraction with page separators and embedded images
- **Image extraction** — all images saved to a `{filename}_images/` folder with proper markdown references
- **In-place output** — the `.md` file and image folder are created next to the original file
- **Windows context menu** — one-click conversion from Explorer
- **Toast notifications** — shows success/failure via Windows 10/11 notifications

## Output Structure

```
Documents/
├── report.docx
├── report.md              ← generated markdown
└── report_images/         ← extracted images
    ├── image_001.png
    ├── image_002.jpg
    └── ...
```

## Requirements

- **Python 3.10+**
- **python-docx** — for Word file parsing
- **pdfplumber** — for PDF text extraction
- **PyMuPDF** (optional) — for PDF image extraction

```bash
pip install python-docx pdfplumber PyMuPDF
```

## Installation

### 1. Clone the repository

```bash
git clone https://github.com/Shan-Zhu/shuck-doc2md.git
```

### 2. Install dependencies

```bash
pip install python-docx pdfplumber PyMuPDF
```

### 3. Configure the right-click menu

Edit `install_menu.reg` to match your Python and script paths:

```reg
@="\"C:\\Python314\\pythonw.exe\" \"D:\\Tools\\doc2md\\convert.py\" \"%1\""
```

Replace:
- `C:\\Python314\\pythonw.exe` with your `pythonw.exe` path
- `D:\\Tools\\doc2md\\convert.py` with where you cloned this repo

Then double-click `install_menu.reg` to register the context menu.

### 4. Uninstall

Double-click `uninstall_menu.reg` to remove the context menu entries.

## Usage

### Right-click (recommended)

Right-click any `.docx` or `.pdf` file in Windows Explorer → click **"To Markdown"**.

### Command line

```bash
python convert.py "path/to/document.docx"
python convert.py "path/to/document.pdf"
```

## How It Works

| Source | Text | Images |
|--------|------|--------|
| `.docx` | Parsed via python-docx XML (headings, lists, tables, formatting) | Extracted from `w:drawing` and `v:imagedata` relationships |
| `.pdf` | Extracted via pdfplumber | Extracted via PyMuPDF (optional, graceful fallback) |

## License

[MIT](LICENSE)
