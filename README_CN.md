# shuck-doc2md

<p align="center">
  <a href="README.md">English</a> | <b>中文</b>
</p>

一个轻量级的 Windows 右键菜单工具，将 **Word (.docx)** 和 **PDF** 文件转换为 **Markdown**，并自动提取图片。

在 Windows 资源管理器中右键点击任意 `.docx` 或 `.pdf` 文件 → **"To Markdown"** → 即可在原文件旁生成 `.md` 文件和图片文件夹。

## 功能特性

- **DOCX 转 Markdown** — 支持标题、加粗/斜体、列表、表格、行内图片
- **PDF 转 Markdown** — 提取文本内容，按页分隔，提取嵌入图片
- **图片提取** — 所有图片保存到 `{文件名}_images/` 文件夹，并在 Markdown 中正确引用
- **就地输出** — `.md` 文件和图片文件夹直接生成在原文件同目录下
- **Windows 右键菜单** — 在资源管理器中一键转换
- **系统通知** — 通过 Windows 10/11 Toast 通知显示转换结果

## 输出结构

```
文档目录/
├── 报告.docx
├── 报告.md                ← 生成的 Markdown 文件
└── 报告_images/           ← 提取的图片
    ├── image_001.png
    ├── image_002.jpg
    └── ...
```

## 环境要求

- **Python 3.10+**
- **python-docx** — 解析 Word 文件
- **pdfplumber** — 提取 PDF 文本
- **PyMuPDF**（可选）— 提取 PDF 图片

```bash
pip install python-docx pdfplumber PyMuPDF
```

## 安装

### 1. 克隆仓库

```bash
git clone https://github.com/Shan-Zhu/shuck-doc2md.git
```

### 2. 安装依赖

```bash
pip install python-docx pdfplumber PyMuPDF
```

### 3. 配置右键菜单

编辑 `install_menu.reg`，将路径修改为你本机的实际路径：

```reg
@="\"C:\\Python314\\pythonw.exe\" \"D:\\Tools\\doc2md\\convert.py\" \"%1\""
```

替换：
- `C:\\Python314\\pythonw.exe` → 你的 `pythonw.exe` 路径
- `D:\\Tools\\doc2md\\convert.py` → 你克隆仓库的实际路径

然后双击 `install_menu.reg` 注册右键菜单。

### 4. 卸载

双击 `uninstall_menu.reg` 即可移除右键菜单。

## ��用方法

### 右键菜单（推荐）

在 Windows 资源管理器中右键点击任意 `.docx` 或 `.pdf` 文件 → 点击 **"To Markdown"**。

### 命令行

```bash
python convert.py "文档路径/报告.docx"
python convert.py "文档路径/报告.pdf"
```

## 工作原理

| 源文件 | 文本提取 | 图片提取 |
|--------|----------|----------|
| `.docx` | 通过 python-docx 解析 XML（标题、列表、表格、格式） | 从 `w:drawing` 和 `v:imagedata` 关系中提取 |
| `.pdf` | 通过 pdfplumber 提取 | 通过 PyMuPDF 提取（可选，未安装时自动跳过） |

## 开源协议

[MIT](LICENSE)
