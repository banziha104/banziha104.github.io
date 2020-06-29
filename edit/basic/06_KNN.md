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

- Cross-validation
    - 과적합 방지
    - error를 과소추정하는 성향이 있음.
    - 데이터를 나누어 번갈아 가며 Training과 Test Set 역할을 한다.
    - k결정은 Test error를 작게하는 k.
    - test error는 과적합으로 인해 높게 시작, 낮아지다가 미적합으로 높아지는 지점이있음. (그때의 k를 채택)
- 차원의 저주 : 변수가 늘어남에 따라 설명할 수 있는 영역이 작아짐.
- 차원축소 Principal Component Analysis, Canonical Correlation Analysis 등의 차원축소후 K-NN을 진행

