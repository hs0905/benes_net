#!/bin/bash

# 표준 에러를 3번 파일 디스크립터로 리다이렉션
exec 3>&2

# 임시 파일 생성. algo_verify의 출력을 저장할 것.
TMP_RESULTS=$(mktemp)

COMPLETED=0  # 완료된 조합의 수를 추적하기 위한 변수
MAX_COMBINATIONS=100000000  # 처리할 최대 조합 수

# draw_progress_bar 함수는 주어진 진행 상태에 따라 진행률 막대를 표시합니다.
draw_progress_bar() {
    local _progress=$1  # 현재 진행률
    local _total=$2  # 전체 작업 수
    local _filled=$(($_progress * 50 / $_total))  # 채울 막대의 길이 계산
    local _empty=$((50 - _filled))  # 빈 막대의 길이 계산

    # 진행률 막대 및 퍼센티지를 표준 에러에 출력
    printf "[" >&3
    printf "%${_filled}s" '' | tr ' ' '#' >&3
    printf "%${_empty}s" '' >&3
    printf "] %d%%\r" $(($_progress * 100 / $_total)) >&3
}

# table_generator의 출력을 읽으면서 각 조합에 대해 작업 수행
./table_generator16 | while IFS= read -r combination; do
    COMPLETED=$((COMPLETED + 1))  # 완료된 작업 수 업데이트
    draw_progress_bar $COMPLETED $MAX_COMBINATIONS  # 진행률 막대 업데이트

    # 각 조합을 algo_verify에 전달하고 결과를 임시 파일에 저장
    echo "$combination" | ./algo_verify >> $TMP_RESULTS

    # 100만개를 초과하면 종료
    if [ $COMPLETED -ge $MAX_COMBINATIONS ]; then
        break
    fi
done

# 임시 파일에서 "good" 및 "bad"의 발생 횟수를 계산
success=$(grep -c "good" $TMP_RESULTS)
fail=$(grep -c "bad" $TMP_RESULTS)

# 임시 파일 삭제
rm $TMP_RESULTS

# 결과 출력
echo
echo "Success: $success, Fail: $fail"
