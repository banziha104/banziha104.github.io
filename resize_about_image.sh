#!/bin/bash

# About 페이지 이미지 리사이즈 스크립트
# 사용법: ./resize_about_image.sh <이미지파일경로>

if [ $# -eq 0 ]; then
    echo "사용법: $0 <이미지파일경로>"
    echo "예시: $0 ~/Downloads/image.jpg"
    exit 1
fi

INPUT_FILE="$1"
OUTPUT_FILE="images/aboutPage.jpeg"
TARGET_WIDTH=1200
TARGET_HEIGHT=800

# 입력 파일 존재 확인
if [ ! -f "$INPUT_FILE" ]; then
    echo "오류: 파일을 찾을 수 없습니다: $INPUT_FILE"
    exit 1
fi

echo "이미지 처리 중: $INPUT_FILE"
echo "출력 파일: $OUTPUT_FILE"
echo "크기: ${TARGET_WIDTH}x${TARGET_HEIGHT}"

# Python PIL을 사용한 리사이즈
python3 << EOF
from PIL import Image
import sys

try:
    # 이미지 열기
    img = Image.open("$INPUT_FILE")
    
    # RGB로 변환 (JPEG 저장을 위해)
    if img.mode != 'RGB':
        img = img.convert('RGB')
    
    # 리사이즈 (고품질 리샘플링)
    img_resized = img.resize(($TARGET_WIDTH, $TARGET_HEIGHT), Image.Resampling.LANCZOS)
    
    # 저장
    img_resized.save("$OUTPUT_FILE", "JPEG", quality=95, optimize=True)
    
    print(f"✓ 완료! {img.size[0]}x{img.size[1]} -> ${TARGET_WIDTH}x${TARGET_HEIGHT}")
    print(f"✓ 저장됨: $OUTPUT_FILE")
    
except Exception as e:
    print(f"오류 발생: {e}")
    sys.exit(1)
EOF

if [ $? -eq 0 ]; then
    echo ""
    echo "이미지가 성공적으로 처리되었습니다!"
    echo "about.md에서 banner_image를 'aboutPage.jpeg'로 변경하시겠습니까? (y/n)"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        if [ -f "about.md" ]; then
            # macOS용 sed 명령어
            sed -i '' 's/banner_image:.*/banner_image: aboutPage.jpeg/' about.md
            echo "✓ about.md가 업데이트되었습니다!"
        fi
    fi
else
    echo "이미지 처리 중 오류가 발생했습니다."
    exit 1
fi
