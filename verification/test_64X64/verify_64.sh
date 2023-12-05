#!/bin/bash

GOOD_COUNT=0
BAD_COUNT=0
TOTAL_TASKS=$(./table_generator64 | wc -l)  # 총 작업 수
CURRENT_TASK=0

while IFS= read -r line; do
    ((CURRENT_TASK++))

    # 읽은 줄을 algo_display에 전달하고 그 결과를 switch_veri로 전달
    RESULT=$(echo "$line" | ./algo_display | ./switch_veri)

    # 결과 검사 및 카운트
    if echo "$RESULT" | grep -q "good"; then
        ((GOOD_COUNT++))
    elif echo "$RESULT" | grep -q "bad"; then
        ((BAD_COUNT++))
    fi

    # 진행률 표시
    echo -ne "Progress: $CURRENT_TASK/$TOTAL_TASKS ($((CURRENT_TASK * 100 / TOTAL_TASKS))%)\\r"

done < <(./table_generator64)

# 결과 출력
echo -e "\nTotal good: $GOOD_COUNT"
echo "Total bad: $BAD_COUNT"
