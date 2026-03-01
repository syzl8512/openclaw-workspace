#!/bin/bash
# 样本分析测试脚本 - P0阶段验证
# 用法: ./sample-test.sh [文件路径]

BASE_DIR="/Users/agent/Documents/syzl8512/01_工作/样本分析"
TEMP_DIR="$BASE_DIR/00_临时"
KNOWLEDGE_DIR="$BASE_DIR/01_知识库"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "=========================================="
echo "   样本分析 P0 阶段测试"
echo "=========================================="

# 检查参数
if [ -z "$1" ]; then
    echo -e "${RED}用法: $0 [文件路径]${NC}"
    echo ""
    echo "示例:"
    echo "  $0 /Users/agent/Documents/syzl8512/01_工作/样本分析/样本库/省政府文件/人工智能-医疗工信厅联科函〔2026〕3号.pdf"
    exit 1
fi

FILE_PATH="$1"
FILE_NAME=$(basename "$FILE_PATH")
FILE_EXT="${FILE_NAME##*.}"
FILE_BASENAME="${FILE_NAME%.*}"

echo -e "${GREEN}输入文件: $FILE_PATH${NC}"
echo "文件名: $FILE_NAME"
echo "扩展名: $FILE_EXT"

# 步骤1: 复制到待处理目录
echo ""
echo "========== 步骤1: 复制到待处理目录 =========="
mkdir -p "$TEMP_DIR/待处理"
cp "$FILE_PATH" "$TEMP_DIR/待处理/"
echo -e "${GREEN}✓ 已复制到: $TEMP_DIR/待处理/$FILE_NAME${NC}"

# 步骤2: 记录元信息
echo ""
echo "========== 步骤2: 记录元信息 =========="
METADATA_FILE="$TEMP_DIR/待处理/${FILE_NAME}.meta.json"

cat > "$METADATA_FILE" << EOF
{
  "file_name": "$FILE_NAME",
  "file_type": "$FILE_EXT",
  "file_size": $(stat -f%z "$FILE_PATH" 2>/dev/null || stat -c%s "$FILE_PATH" 2>/dev/null),
  "download_time": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "source": "本地文件",
  "status": "pending_analysis"
}
EOF

echo -e "${GREEN}✓ 元信息已保存: $METADATA_FILE${NC}"
cat "$METADATA_FILE"

# 步骤3: 创建分析结果占位
echo ""
echo "========== 步骤3: 准备分析环境 =========="
mkdir -p "$KNOWLEDGE_DIR/01_原始样本/省政府文件"
mkdir -p "$KNOWLEDGE_DIR/02_分析结果/内容分析"
mkdir -p "$KNOWLEDGE_DIR/02_分析结果/格式分析"
mkdir -p "$KNOWLEDGE_DIR/05_Skill库/汇报材料"

# 检查是否有MinerU可用
echo ""
echo "========== 步骤4: 尝试解析文档 =========="
if command -v python3 &> /dev/null; then
    echo "Python3 可用"
    # 尝试检测MinerU
    if python3 -c "import mineru" 2>/dev/null; then
        echo "MinerU 已安装"
    else
        echo -e "${YELLOW}注意: MinerU未安装，将使用降级方案${NC}"
    fi
else
    echo -e "${YELLOW}注意: Python3不可用${NC}"
fi

echo ""
echo "========== P0 阶段验证完成 =========="
echo ""
echo "测试完成！"
echo ""
echo "下一步:"
echo "  1. 安装MinerU: pip install -U mineru"
echo "  2. 运行分析: /样本分析 $TEMP_DIR/待处理/$FILE_NAME"
echo "  3. 查看结果: ls -la $KNOWLEDGE_DIR/"
