# OpenClaw Skills 完整总结

> 最后更新: 2026-02-24

---

## 📦 Skills 安装方式

### 方式1: 从 ClawHub 安装
```bash
clawhub install <skill-name>
```

### 方式2: 手动复制
将 skill 文件夹复制到 `~/.openclaw/workspace/skills/` 目录

### 方式3: Git 同步
所有 skills 已推送到 GitHub，MacMini 可直接克隆：
```bash
git clone https://github.com/syzl8512/openclaw-workspace.git
```

---

## 📋 所有 Skills 一览

| # | Skill名称 | 功能描述 | 状态 |
|---|-----------|----------|------|
| 1 | document-summarizer | 文档摘要/问答/出题 | 🆕 新建 |
| 2 | writing-assistant | 写作润色/语法检查 | 🆕 新建 |
| 3 | ppt-generator | AI生成PPT | 🆕 新建 |
| 4 | web-translator | 网页双语翻译 | 🆕 新建 |
| 5 | data-visualizer | 数据可视化 | 🆕 新建 |
| 6 | deep-research | 深度研究/报告 | 🆕 新建 |
| 7 | tavily-search | Tavily网络搜索 | ✅ 已安装 |
| 8 | aliyun-tts | 阿里云语音合成 | ✅ 已安装 |
| 9 | edge-tts | Edge语音合成 | ✅ 已安装 |
| 10 | data-analysis | 数据分析 | ✅ 已安装 |
| 11 | excel-xlsx | Excel处理 | ✅ 已安装 |
| 12 | word-docx | Word处理 | ✅ 已安装 |
| 13 | pptx | PPTX处理 | ✅ 已安装 |
| 14 | markdown-converter | Markdown转换 | ✅ 已安装 |
| 15 | mineru | PDF解析 | ✅ 已安装 |
| 16 | notebooklm-cli | NotebookLM | ✅ 已安装 |
| 17 | supabase | 数据库操作 | ✅ 已安装 |
| 18 | gaodemapskill | 高德地图 | ✅ 已安装 |
| 19 | sheet-cog | 表格处理 | ✅ 已安装 |
| 20 | claude-optimised | CLAUDE.md优化 | ✅ 已安装 |
| 21 | backend-patterns | 后端架构 | ✅ 已安装 |
| 22 | coding | 编程 | ✅ 已安装 |
| 23 | research | 研究 | ✅ 已安装 |
| 24 | productivity | 效率 | ✅ 已安装 |
| 25 | social | 社交 | ✅ 已安装 |

---

## 🆕 新建 Skills 详细说明

### 1. document-summarizer (文档摘要)

**功能**: 对PDF、文档、网页内容进行智能摘要、问答、知识点提取

**触发关键词**: 总结、摘要、提取要点、问答、出题

**调用方式**:
```
用户: 帮我总结这个PDF的重点
→ 读取文件 → 提取关键信息 → 返回摘要

用户: 这个文档里说了什么?
→ 读取文件 → 理解内容 → 简要回答

用户: 帮我出3道考试题
→ 分析知识点 → 生成题目 → 给出答案
```

**工作流**:
1. 用户上传文件或提供URL
2. 用 `read` 或 `web_fetch` 获取内容
3. 根据用户需求构造提示词
4. 调用AI处理
5. 返回结果

---

### 2. writing-assistant (写作助手)

**功能**: AI写作润色，类似Quillbot

**触发关键词**: 润色、改写、语法检查、翻译、正式、口语

**调用方式**:
```
用户: 帮我检查语法 "I goes to school yesterday"
→ 指出错误: goes→went, 解释原因

用户: 帮我改成学术风格 "This thing is very important"
→ This matter is of significant importance
```

**工作流**:
1. 用户提供文本
2. 选择功能（语法/改写/翻译）
3. 调用AI处理
4. 返回结果

---

### 3. ppt-generator (PPT生成)

**功能**: AI生成PPT，类似Gamma

**触发关键词**: 生成PPT、做PPT、制作演示、做slides

**调用方式**:
```
用户: 帮我做一个"AI发展历史"的PPT
→ 生成大纲 → 调用API → 返回PPT链接

用户: 把这个文档转成PPT
→ 提取要点 → 生成PPT → 返回结果
```

**工作流**:
1. 获取用户需求（主题/内容/页数）
2. 生成PPT大纲
3. 调用Gamma API生成PPT
4. 返回PPT链接

**注意**: 需要Gamma API Key

---

### 4. web-translator (网页翻译)

**功能**: 网页双语对照翻译，类似沉浸式翻译

**触发关键词**: 翻译网页、双语阅读、翻译这个页面

**调用方式**:
```
用户: 翻译 https://example.com
→ 获取内容 → 中英对照排版 → 返回

用户: 帮我读这个英文页面
→ 获取 → 翻译 → 解释要点
```

**工作流**:
1. 用户提供URL
2. 用 `web_fetch` 获取内容
3. AI翻译并保持原文对照格式
4. 返回双语对照结果

---

### 5. data-visualizer (数据可视化)

**功能**: 数据可视化生成，类似Flourish

**触发关键词**: 可视化、做图表、生成图表、数据展示

**调用方式**:
```
用户: 把这些数据做成图表
→ 数据: A:100, B:200, C:150
→ 生成条形图 → 返回链接
```

**工作流**:
1. 用户提供数据（CSV/Excel/描述）
2. 选择图表类型
3. 生成可视化配置
4. 返回图表链接

**支持图表类型**:
- 条形图/柱状图
- 折线图
- 饼图
- 地图
- 散点图
- 动态排名图

---

### 6. deep-research (深度研究)

**功能**: 深度研究助手，类似Perplexity/DeepResearch

**触发关键词**: 研究一下、深度分析、调研、写报告

**调用方式**:
```
用户: 研究一下AI在教育领域的应用
→ 搜索相关论文/报告 → 获取详情 → 综合分析 → 返回万字报告
```

**工作流**:
1. 用户给出研究主题
2. 搜索相关权威来源
3. 获取关键页面内容
4. AI综合分析
5. 生成结构化研究报告

**报告结构**:
- 概述
- 核心发现
- 详细分析
- 数据来源
- 结论与建议

---

## ✅ 常用 Skills 调用示例

### 网络搜索
```bash
node scripts/search.mjs "AI发展趋势"
node scripts/search.mjs "最新新闻" --topic news
```

### 文档转换
```bash
uvx markitdown input.pdf -o output.md
python -m markitdown presentation.pptx
```

### 语音合成
```bash
tts "你好世界"  # 使用内置tts工具
```

### 地图查询
```bash
python amap_tool.py search --keywords "餐厅" --city "北京"
```

---

## 🔧 常用工具 (非Skill)

OpenClaw 内置工具，无需安装：

| 工具 | 用途 |
|------|------|
| read | 读取文件 |
| write | 写入文件 |
| exec | 执行命令 |
| web_fetch | 获取网页 |
| web_search | 网络搜索 |
| message | 发送消息 |
| browser | 浏览器控制 |
| tts | 文字转语音 |
| feishu_* | 飞书API操作 |

---

## 📤 同步到MacMini

### 方式1: Git拉取 (推荐)
```bash
# 在MacMini上执行
cd ~/.openclaw/workspace
git pull origin master
```

### 方式2: 手动复制
从本环境复制 skills 目录到 MacMini:
```bash
scp -r skills/ user@macmini:/root/.openclaw/workspace/
```

---

## 📝 注意事项

1. 部分Skills需要环境变量配置（如API Key）
2. 部分Skills需要安装依赖（如node、python）
3. 新建的6个Skills主要依赖AI能力，配置简单

---

*此文档自动生成*
