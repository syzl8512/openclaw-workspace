# 样本分析知识库系统

> 文档版本: 1.0
> 更新日期: 2026-03-01
> 状态: ✅ 已部署测试通过

---

## 系统架构

```
┌─────────────────────────────────────────────────────────────────┐
│                        用户端 (Feishu/命令)                       │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                    本地Mac Mini (OpenClaw)                       │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────────┐ │
│  │ 文档解析    │  │ 16维分析    │  │ 样本分析Skill           │ │
│  │ (MinerU)   │──│ (LLM)       │──│ (feishu-sample-receiver)│ │
│  └─────────────┘  └─────────────┘  └─────────────────────────┘ │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                    Ubuntu Server (192.168.1.118)                │
│  ┌───────────────────┐    ┌───────────────────────────────────┐ │
│  │ Embedding服务     │    │ PostgreSQL + pgvector            │ │
│  │ (Jina API)       │    │ (样本数据存储)                     │ │
│  │ 端口: 8081       │    │ 端口: 5432                        │ │
│  └───────────────────┘    └───────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
```

---

## 组件说明

### 1. 文档解析 (MinerU)
- **位置**: 本地Mac Mini
- **功能**: 解析PDF/Word/Excel文档为Markdown
- **命令**: `mineru parse <文件路径>`

### 2. Embedding向量化服务
- **位置**: Ubuntu Server
- **端口**: 8081
- **API**: 
  - `POST /embed` - 向量化文本
  - `GET /health` - 健康检查
- **模型**: jina-embeddings-v2-base-zh
- **维度**: 768维

### 3. 向量数据库 (PostgreSQL + pgvector)
- **位置**: Ubuntu Server
- **端口**: 5432
- **数据库**: sample_knowledge
- **用户**: sample_user / sample123
- **表**: samples (包含embedding列)

### 4. 16维分析框架

| 编号 | 维度 | 说明 |
|------|------|------|
| 1 | 政策领域 | 所属政策分类 |
| 2 | 区域范围 | 适用地理范围 |
| 3 | 适用对象 | 目标受众群体 |
| 4 | 时间特征 | 时间有效性 |
| 5 | 重要程度 | 优先级 |
| 6 | 执行难度 | 实施复杂度 |
| 7 | 资金需求 | 预算规模 |
| 8 | 责任部门 | 牵头机构 |
| 9 | 配合部门 | 协作机构 |
| 10 | 考核指标 | 评估标准 |
| 11 | 风险等级 | 风险程度 |
| 12 | 创新程度 | 创新属性 |
| 13 | 行业特征 | 产业分类 |
| 14 | 发展趋势 | 时间走向 |
| 15 | 关联文件 | 相关文档 |
| 16 | 摘要 | 内容概要 |

---

## 使用方法

### 方式1: 通过Feishu发送文档

1. 在飞书群聊中发送文档（PDF/Word）
2. 系统自动识别并解析
3. 进行16维分析
4. 存储到向量数据库

### 方式2: 手动调用API

#### Embedding向量化
```bash
curl -X POST http://192.168.1.118:8081/embed \
  -H "Content-Type: application/json" \
  -d '{"texts": ["湖北省政府工作报告", "乡村振兴战略"]}'
```

#### 向量相似度检索
```bash
# 首先获取查询的embedding
EMBEDDING=$(curl -s -X POST http://192.168.1.118:8081/embed \
  -H "Content-Type: application/json" \
  -d '{"texts": ["数字经济"]}' | python3 -c "import sys,json; print(json.load(sys.stdin)['embeddings'][0])")

# 然后在PostgreSQL中检索
PGPASSWORD=sample123 psql -U sample_user -d sample_knowledge -h localhost -c \
  "SELECT title, 1 - (embedding <=> '$EMBEDDING'::vector) as similarity 
   FROM samples 
   ORDER BY embedding <=> '$EMBEDDING'::vector 
   LIMIT 5;"
```

---

## 目录结构

```
/Users/agent/Documents/syzl8512/01_工作/样本分析/
├── 知识库/
│   ├── 需求分析报告.md
│   ├── 系统详细设计.md
│   └── 系统开发计划.md
├── scripts/
│   ├── ubuntu-deploy.sh      # Ubuntu部署脚本
│   └── sample-test.sh       # 测试脚本
├── skills/
│   ├── feishu-sample-receiver/
│   ├── sample-analyzer/
│   └── document-parser/
└── README.md                # 本文档
```

---

## 测试记录

### 2026-03-01 测试结果

| 测试项 | 结果 | 详情 |
|--------|------|------|
| Embedding服务 | ✅ | 返回768维向量 |
| PostgreSQL连接 | ✅ | 正常查询 |
| pgvector | ✅ | 向量检索正常 |

---

## 维护指南

### 查看服务状态
```bash
# Ubuntu SSH连接
ssh apple@ximi.space -p 2221

# 查看embedding服务
curl http://localhost:8081/health

# 查看PostgreSQL
PGPASSWORD=sample123 psql -U sample_user -d sample_knowledge -h localhost -c '\dt'
```

### 重启服务
```bash
# 重启embedding服务
pkill -f 'python3 app.py'
cd /opt/embedding-service
nohup python3 app.py > /tmp/embedding.log 2>&1 &

# 重启PostgreSQL
sudo systemctl restart postgresql
```

---

## 常见问题

### Q: embedding返回维度不对
A: 检查使用的模型版本，jina-embeddings-v2-base-zh是768维

### Q: PostgreSQL连接失败
A: 检查用户权限 `psql -c "GRANT ALL ON DATABASE sample_knowledge TO sample_user;"`

### Q: 内存不足
A: Ubuntu只有8GB内存，不建议本地运行大模型，使用jina API云端服务

---

## 联系方式

- 主人: 张梁
- 系统: OpenClaw
- 部署日期: 2026-03-01
