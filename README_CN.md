# shuck-doc2md

<p align="center">
  <a href="README.md">English</a> | <b>中文</b>
</p>

一个轻量的 Windows 工具，将 **Word (.docx)** 和 **PDF** 一键转换为 **Markdown**，自动提取图片。右键点击文档 → **"To Markdown"** → 搞定。

## 功能

- **DOCX 转 Markdown** — 标题、加粗/斜体、列表、表格、图片
- **PDF 转 Markdown** — 文本提取 + 分页 + 图片提取
- **图片提取** — 自动保存到 `{文件名}_images/` 并在 Markdown 中引用
- **就地输出** — `.md` 和图片直接生成在原文件旁边
- **右键菜单** — 资源管理器中一键转换
- **系统通知** — Windows 10/11 Toast 通知提示结果

## 输出结构

```
文档目录/
├── 报告.docx
├── 报告.md                ← 生成的 Markdown
└── 报告_images/           ← 提取的图片
    ├── image_001.png
    └── image_002.jpg
```

## 安装

### 方式一：便携 EXE（无需 Python）

1. 从 [Releases](https://github.com/Shan-Zhu/shuck-doc2md/releases) 下载最新压缩包
2. 解压到任意目录
3. 双击 **`setup.bat`** 注册右键菜单
4. 卸载时双击 **`uninstall.bat`**

### 方式二：源码运行（需 Python 3.10+）

```bash
git clone https://github.com/Shan-Zhu/shuck-doc2md.git
cd shuck-doc2md
pip install python-docx pdfplumber PyMuPDF
```

编辑 `install_menu.reg`，将路径改为你本机的：

```reg
@="\"C:\\Python314\\pythonw.exe\" \"D:\\Tools\\doc2md\\convert.py\" \"%1\""
```

双击 `install_menu.reg` 注册。卸载用 `uninstall_menu.reg`。

## 使用

**右键** 任意 `.docx` 或 `.pdf` 文件 → **"To Markdown"**

或命令行：

```bash
# Python 版
python convert.py "文档路径/报告.docx"

# EXE 版
doc2md.exe "文档路径/报告.pdf"
```

## 自行构建 EXE

```bash
pip install pyinstaller
python build_exe.py
```

输出在 `dist/doc2md.exe`。

## 工作原理

| 源文件 | 文本 | 图片 |
|--------|------|------|
| `.docx` | python-docx 解析 XML（标题、列表、表格、格式） | 从 `w:drawing` 和 `v:imagedata` 提取 |
| `.pdf` | pdfplumber 提取文本 | PyMuPDF 提取图片（可选，未安装自动跳过） |

## 开源协议

[MIT](LICENSE)
