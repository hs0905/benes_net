#!/bin/bash

GOOD_COUNT=0
BAD_COUNT=0

while IFS= read -r line; do
    # 읽은 줄을 algo_display에 전달하고 그 결과를 switch_veri로 전달
    RESULT=$(echo "$line" | ./algo_display | ./switch_veri)

    # 결과 검사 및 카운트
    if echo "$RESULT" | grep -q "good"; then
        ((GOOD_COUNT++))
    elif echo "$RESULT" | grep -q "bad"; then
        ((BAD_COUNT++))
    fi
done < <(./table_generator8)

# 결과 출력
echo "Total good: $GOOD_COUNT"
echo "Total bad: $BAD_COUNT"

