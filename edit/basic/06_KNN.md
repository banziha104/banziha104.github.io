# K-Nearest neighborhood

> 주변의 관측치에 대한 정보를 이용해 분류 또는 회귀 

- k는 어떻게 정하는 가?
    - 너무큰 k : 미세한 경계부분을 잘못 분류
    - 너무 작은 k 
        - 이상치의 영향을 크게 받을 것
        - 패턴이 직관적이지 않을 것
- 중요한 변수를 선별할 필요가 있음.
- Majority voting : 영역안에 많은 카테고리를 채택
    - 거리에 반비례하는 Weight를 줄 필요가 있음.
- 종속 변수
    - 범주형 변수 : 가장 많이나타는 범주로 y를 추정
        - Tie 문제를 막기 위해 k는 홀수로 정하는 것이 좋다
    - 연속형 변수 : 평균으로 y를 추정
        - Inverse distance weighted average 고려가능.
- 거리
    - 설명 변수
        - 범주 변수 
            - Hamming distance : sum_{j=1}^{J}{I(x_j != y_j)
         - 연속형 변수
            - Euclidian distance : 대각선
            - Manhattan distance : 가로세로 

- 
