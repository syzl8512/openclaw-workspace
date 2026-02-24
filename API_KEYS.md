# API Keys 配置模板

⚠️ **安全警告**: 此文件只包含模板，不要提交实际 Keys 到 GitHub！

实际 Keys 应保存在本地 `.env` 文件中。

---

## 🔑 主账号
- **邮箱**: syzl8512@gmail.com
- **密码**: Sy123457@

---

## 🤖 AI/大语言模型

### OpenAI
| 用途 | 环境变量 |
|------|---------|
| GPT-5.0 | OPENAI_API_KEY |

### DeepSeek
| 用途 | 环境变量 |
|------|---------|
| PDF转Markdown | DEEPSEEK_API_KEY_PDF |
| 英语书籍 | DEEPSEEK_API_KEY_BOOKS |

### Google Gemini
| 用途 | 环境变量 |
|------|---------|
| 主账号 | GEMINI_API_KEY_MAIN |
| 备用 | GEMINI_API_KEY_BAK |

### 豆包
| 用途 | 环境变量 |
|------|---------|
| 通用 | DOUBAO_API_KEY |
| Code | DOUBAO_CODE_API_KEY |

### 智谱 BigModel
| 用途 | 环境变量 |
|------|---------|
| API | BIGMODEL_API_KEY |

### Kimi
| 用途 | 环境变量 |
|------|---------|
| API | KIMI_API_KEY |

### 阿里千问
| 用途 | 环境变量 |
|------|---------|
| API | QWEN_API_KEY |

### 硅基流动
| 用途 | 环境变量 |
|------|---------|
| API | SILICONFLOW_API_KEY |

### MiniMax
| 用途 | 环境变量 |
|------|---------|
| API | MINIMAX_API_KEY |

---

## 🔧 MCP Servers
| 服务 | 环境变量 |
|------|---------|
| zai-mcp | Z_AI_API_KEY |
| web-search-prime | BIGMODEL_TOKEN |
| Context7 | CONTEXT7_API_KEY |

---

## 📄 文档处理
| 服务 | 环境变量 |
|------|---------|
| MinerU | MINERU_API_KEY |

---

## 🎨 图像生成
| 服务 | 环境变量 |
|------|---------|
| 魔搭社区 | MODELSCOPE_TOKEN |

---

## 🔊 语音服务
| 服务 | 环境变量 |
|------|---------|
| fish.audio TTS | FISHAUDIO_API_KEY |

---

## 🗺️ 地图服务
| 服务 | 环境变量 |
|------|---------|
| 高德地图 | AMAP_API_KEY |

---

## 💾 数据库
| 项目 | URL |
|------|-----|
| Ai-english | https://xiedxagxeqasxkejbflf.supabase.co |
| everyday task | https://rebdrbguuxayrzxzzhbz.supabase.co |

---

## 📱 其他服务
| 服务 | 环境变量 |
|------|---------|
| Finnhub | FINNHUB_API_KEY |

---

## 💡 .env 文件模板

```bash
# AI Models
OPENAI_API_KEY=sk-xxxx
DEEPSEEK_API_KEY=sk-xxxx
GEMINI_API_KEY=AIzaSyxxxx
SILICONFLOW_API_KEY=sk-xxxx

# Services
MINERU_API_KEY=eyJ0eXBl...
AMAP_API_KEY=85ce00fxxxx
FISHAUDIO_API_KEY=0d57614xxxx
FINNHUB_API_KEY=d4a00tprxxxx
```

