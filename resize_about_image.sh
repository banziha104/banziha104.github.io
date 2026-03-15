#!/bin/bash

# 이미지 리사이즈 스크립트
# 사용법: 
#   ./resize_about_image.sh <이미지파일경로> [about|profile]
#   about: About 페이지 배너 이미지 (1200x800)
#   profile: 프로필 사진 (365x365, 기본값)

if [ $# -eq 0 ]; then
    echo "사용법: $0 <이미지파일경로> [about|profile]"
    echo "예시:"
    echo "  $0 ~/Downloads/image.jpg about    # About 페이지 이미지"
    echo "  $0 ~/Downloads/image.jpg profile  # 프로필 사진"
    echo "  $0 ~/Downloads/image.jpg          # 프로필 사진 (기본값)"
    exit 1
fi

INPUT_FILE="$1"
MODE="${2:-profile}"

if [ "$MODE" = "about" ]; then
    OUTPUT_FILE="images/aboutPage.jpeg"
    TARGET_WIDTH=1200
    TARGET_HEIGHT=800
    MODE_NAME="About 페이지 배너"
elif [ "$MODE" = "profile" ]; then
    OUTPUT_FILE="images/authorimage.jpeg"
    TARGET_WIDTH=365
    TARGET_HEIGHT=365
    MODE_NAME="프로필 사진"
else
    echo "오류: 모드는 'about' 또는 'profile'만 가능합니다."
    exit 1
fi

# 입력 파일 존재 확인
if [ ! -f "$INPUT_FILE" ]; then
    echo "오류: 파일을 찾을 수 없습니다: $INPUT_FILE"
    exit 1
fi

echo "========================================="
echo "$MODE_NAME 이미지 처리"
echo "========================================="
echo "입력 파일: $INPUT_FILE"
echo "출력 파일: $OUTPUT_FILE"
echo "크기: ${TARGET_WIDTH}x${TARGET_HEIGHT}"
echo ""

# Python PIL을 사용한 리사이즈
python3 << EOF
from PIL import Image
import sys

try:
    # 이미지 열기
    img = Image.open("$INPUT_FILE")
    original_size = img.size
    
    # RGB로 변환 (JPEG 저장을 위해)
    if img.mode != 'RGB':
        img = img.convert('RGB')
    
    # 프로필 사진인 경우 정사각형으로 크롭 후 리사이즈
    if "$MODE" == "profile":
        # 정사각형으로 크롭 (중앙 기준)
        width, height = img.size
        size = min(width, height)
        left = (width - size) // 2
        top = (height - size) // 2
        right = left + size
        bottom = top + size
        img = img.crop((left, top, right, bottom))
    
    # 리사이즈 (고품질 리샘플링)
    target_width = $TARGET_WIDTH
    target_height = $TARGET_HEIGHT
    img_resized = img.resize((target_width, target_height), Image.Resampling.LANCZOS)
    
    # 저장
    output_file = "$OUTPUT_FILE"
    img_resized.save(output_file, "JPEG", quality=95, optimize=True)
    
    print(f"✓ 완료! {original_size[0]}x{original_size[1]} -> {target_width}x{target_height}")
    print(f"✓ 저장됨: {output_file}")
    
except Exception as e:
    print(f"오류 발생: {e}")
    sys.exit(1)
EOF

if [ $? -eq 0 ]; then
    echo ""
    echo "========================================="
    echo "✓ 이미지가 성공적으로 처리되었습니다!"
    echo "========================================="
    
    if [ "$MODE" = "about" ]; then
        echo ""
        echo "about.md에서 banner_image를 'aboutPage.jpeg'로 변경하시겠습니까? (y/n)"
        read -r response
        if [[ "$response" =~ ^[Yy]$ ]]; then
            if [ -f "about.md" ]; then
                # macOS용 sed 명령어
                sed -i '' 's/banner_image:.*/banner_image: aboutPage.jpeg/' about.md
                echo "✓ about.md가 업데이트되었습니다!"
            fi
        fi
    elif [ "$MODE" = "profile" ]; then
        echo ""
        echo "프로필 사진이 업데이트되었습니다!"
        echo "_config.yml의 author_image는 이미 '/images/authorimage.jpeg'로 설정되어 있습니다."
    fi
else
    echo ""
    echo "오류: 이미지 처리 중 문제가 발생했습니다."
    exit 1
fi
