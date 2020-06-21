# 미분의 개념

- 평균 변화율 : f(b) - f(a) / b - a
- 순간 변화율  : 평균 변화율의 극한값 
- f(x) = c => f'(x) = 0 , c는 상수, 이때 f'(x)는 도함수라고함
- f(x) = x^n => f'(x) = nx^n-1 , n은 자연수 
- f(x) = x^k => f'(x) = kx^k-1 , k는 유리수(자연수 뿐만 아니라 유리수도 가능)
- {cf(x)}' = c(f'(x))
- {f(x) +- g(x)}' = f'(x) +- g'(x)
- {f(x)g(x)}' = f'(x)g(x) + f(x)g'(x)
- 합성함수 미분 : f(g(x))' = f'(g(x))g'(x)
- 지수함수 미분 
    - {e^x}' = e^x
    - {a^x}' = a^x lna (lan는 밑이 2인 로그)
- 로그함수 미분
    -  {lnx}' = 1/x
    - {log_a_x}' = 1/xlna 
    
- 미분의 활용 : 극대값, 극소값 미분값은 접선의 기울도함수를 통하여 미분가능한 함수의 극대값 극소값을 구할 수 있음. (f'(X) = 0 인 것 찾기)
    
<br>

# Likelihood

> Likelihood funtion , 가능도함수, 우도함수 

- 확률분포함수 (Probability distribution function) : 모수를 알 때, 확률변수의 실현값을 예측하고자 함.
    - 종류 
        - 확률밀도함수 (Probability desnsity function) : 연속형 확률변수의 확률 분포함수 
        - 확률질량함수 : 이산형 확률변수의 확률 분포함수. 
            - f(x) = P(X = x)
        - 누적분포함수 : 누적 확률 분포함수, 특별한 값보다 작거나 클 확률 
            - F(x) =  P(X <= x)
- 가능도함수(Likelihood function) : 확률변수의 실현값을 알 때 모수를 추정하고자 함 

<br>

# Maximum Likelhood Estimator (MLE)

> Likelihood를 최대로 만드는 모수 값

- 주로 모수에 hat을 붙여 표한 ^u0 표현 
- MLE 구하기 
    1. likelihood 구성
    2. 미분하기 용이하도록 log Likelihood 구성 
    3. 미분 실행
    4. 미분한 함수가 0이 되게 하는 ^u0를 구해냄 

# 행렬과 백터

- Vector : 행 또는 열의 수가 1인 경우 
    - row vector : 행의 수가 1인 행렬
    - column vector : 열의 수가 1인 경우 

- Transpose : 행과열을 바꿈
- symmetric : A = A^T 가 같은 경우, 정방행렬 
- Scalar : 1 by 1 
- Identity matrix : 단위 행렬 
- Diagonal matrix : 단위 행렬에서 대각 원소만 다른 형태 
- Equality : 모든 i,jdp 관하여 a_ij = b_ij이면 A=B
- 행렬곱 
    - 상수배 : B = kA <=> b_ij = ka_ij
    - A = (m*p), B = (p*n),
    - C = AB, C = (m*n) 
    - c_ij = a_i1*b_1j + a_i2*b_2j ....
    - 일반적으로 AB != BA 
- 내적
    - row vector와 column vector의 곱이 상수
- 곱의 성질
    - A(B+C) =  AB+ AC
    - A(BC) = (AB)C
    - (AB)^T = B^T*A^T
    - AB = 0 이더라도 A,B 어느것도 0이 아닐 수 있음.
- Trace 
    - tr(A) = 대각 원소를 모두 더함 
    - tr(A^T) = tr(A)
    - tr(kA) = ktr(A)
    - tr(I_n)=n 
- A,B가 정사각행렬인 경우
    - tr(A+B) = tr(A) + tr(B)
    - tr(AB) = tr(BA)
    - tr(ABC) = tr(BCA) = tr(CAB)
- 역행렬 : AB = BA = I_n
- 역행렬의 성질 = I^-1 = I
- (A^-1)^-1 = A
- AB=I, BA =I
- Idempotent : 자기자신을 제곱했을떄 자기자신이 나오는 행렬 AA=A

<br>

# 행렬 미분

- 미분 표기법의 종류 
    - Numerator layout : 미분 당하는 변수(혹은 함수)를 기준으로 결과의 형태를 표기 
    - Denumerator layout : 미분 하는 변수(혹은 함수)를 기준으로 결과의 형태를 표기 
- 핵심은 의도한 미분을 수행했을 때 결과값의 차원이 핵심. 

# 회귀분석

- 오차제곱합 : R(B) = (y-XB)^T * (y-XB) 
- 최소제곱합 : 오차제곱합을 최소로 하는 ^B를 구하고자함. 이때 미분을 통해 구함


프로젝트 구성
- 서술형 : 최대우도추정량, 불편추정량
- 서술형 : 오차정규성, 오차등분산성, 반응함수, 회귀선
- Python : 최소제곱법 구현
- Python : 최소제곱법 시각화
