---
name: document-parser
description: 文档解析器 - 使用MinerU解析PDF/Word，支持表格和图表识别
version: 1.0.0
author: syzl8512
triggers:
  - "解析文档"
  - "提取内容"
---

# 文档解析器 (Document Parser)

使用MinerU API解析PDF/Word文档，提取文本、表格和结构化内容。

## 功能

1. **多格式支持**：PDF、Word、PPT、图片
2. **表格识别**：自动识别和提取表格结构
3. **版面分析**：多栏、图文混排自动处理
4. **降级方案**：如解析失败，自动降级到纯文本处理

## 使用方式

### 命令行

```bash
# 解析PDF
python3 -m mineru parse /path/to/file.pdf

# 解析Word
python3 -m mineru parse /path/to/file.docx

# 批量解析
python3 -m mineru batch /path/to/files/
```

### Python API

```python
import os
import json

# 设置Token
os.environ["MINERU_TOKEN"] = "your_token_here"

from mineru import MagicPDF

# 初始化
pdf = MagicPDF("your_token_here")

# 解析PDF
result = pdf.parse("document.pdf")
# 返回: full.md, content_list.json, images/
```

## 输出结构

```
output/
├── full.md           # 完整Markdown
├── content_list.json # 结构化内容
├── images/           # 提取的图片
└── layout.json       # 版面分析结果
```

### content_list.json 结构

```json
{
  "content_list": [
    {
      "type": "text",
      "text": "段落文本内容",
      "bbox": [x1, y1, x2, y2]
    },
    {
      "type": "table",
      "table_body": [["单元格1", "单元格2"], ["行2-1", "行2-2"]],
      "table_header": ["表头1", "表头2"],
      "bbox": [x1, y1, x2, y2]
    },
    {
      "type": "image",
      "image_path": "images/page_1/img_1.jpg",
      "bbox": [x1, y1, x2, y2]
    }
  ]
}
```

## 参数说明

| 参数 | 类型 | 说明 |
|------|------|------|
| url | string | 文件URL（支持http/https） |
| enable_formula | bool | 启用公式识别（默认true） |
| enable_table | bool | 启用表格识别（默认true） |
| layout_model | string | 版面模型：doclayout_yolo（快）/layoutlmv3（准） |
| language | string | 语言：en/ch/auto |
| model_version | string | 模型版本：pipeline/vlm/MinerU-HTML |

## 表格数据提取

### 提取表格内容

```python
import json

# 读取content_list.json
with open("content_list.json") as f:
    data = json.load(f)

# 提取所有表格
tables = []
for item in data["content_list"]:
    if item["type"] == "table":
        tables.append({
            "header": item.get("table_header", []),
            "body": item.get("table_body", [])
        })

# 转换为DataFrame
import pandas as pd
for i, table in enumerate(tables):
    df = pd.DataFrame(table["body"], columns=table["header"])
    print(f"表格 {i+1}:")
    print(df)
```

### 提取关键指标

```python
def extract_metrics(table):
    """从表格中提取关键指标"""
    metrics = {}
    keywords = ["收入", "增长", "同比", "率", "额", "数"]
    for row in table.get("body", []):
        for cell in row:
            if any(kw in str(cell) for kw in keywords):
                metrics[cell] = row  # 简单提取
    return metrics
```

## Excel处理

对于Excel文件，直接使用openpyxl：

```python
import openpyxl

def parse_excel(file_path):
    """解析Excel文件"""
    wb = openpyxl.load_workbook(file_path)
    sheets = {}
    
    for sheet_name in wb.sheetnames:
        sheet = wb[sheet_name]
        data = []
        
        # 读取表头
        headers = [cell.value for cell in sheet[1]]
        
        # 读取数据行
        for row in sheet.iter_rows(min_row=2, values_only=True):
            if any(row):
                data.append(dict(zip(headers, row)))
        
        sheets[sheet_name] = {
            "headers": headers,
            "data": data,
            "row_count": sheet.max_row - 1,
            "col_count": sheet.max_column
        }
    
    return sheets
```

## 存储路径

```
01_工作/样本分析/
├── 00_临时/
│   └── 待处理/          ← 输入文件
├── 01_知识库/
│   ├── 01_原始样本/   ← 归档源文件
│   └── 02_分析结果/   ← 解析结果
│       ├── 内容分析/
│       └── 格式分析/
└── scripts/            ← 解析脚本
```

## 错误处理

| 错误 | 处理 |
|------|------|
| 网络超时 | 重试3次，失败则跳过 |
| 解析失败 | 降级到纯文本提取 |
| Token无效 | 提示检查Token |
| 文件过大 | 提示拆分为多个文件 |

## 依赖

- Python 3.10+
- mineru >= 2.0
- openpyxl (Excel处理)
- pandas (数据处理)

---

*version: 1.0.0*
