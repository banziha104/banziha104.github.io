# Support Vector Machine 

> Boundary 에 집중, margin을 최대화 하는 boundary를 찾는 것.

- 정확히 구분되지 않는 경우가 존재하는 경우, 적당한 Error를 허용하고 , 이를 최소화하도록 boundary를 결정 
- 범주형 변수
    - Support Vector classifier
- 연속형 변수
    - Support Vector regression
- SVM : Margin 안에 포함되거나, 반대 방향으로 분류된 점들
- SVR : Margin 바깥에 위치한 점 들.
- Decision boundary : h_a(x)
- Decision rule : h_a(x) >0 , h_a(x) < 0
- Largrange multiplier : 
    - 라그랑주 승수의 기본 : 최적화 문제를 풀떄 , f(x,y)를 최대화 하는 동시에 g(x,y)=c로 한정하고 싶은 경우
    - g(x,y) = c 와 f(x,y) =k 가 접점이 될 때, 극대, 극가소 됨. 
    - f와 g의 변화량이 상수배 되는 지점
    - L(x,y,lambda) = f(x,y) - lambda(g(x,y) - c)
- 정의 : f(x) = x^TB+B_0=0
    - B와 B_0을 유일하게 만들기 위해서 ||B||=1 조건이 필요 
    - margin을 최대로 만드는 계수값을 구하는 문제
    
- Decision rule
    - y = 1,(x_i^t)B + B_0 > 0
    - y = -1, (x_i^t)B + B_0 < 0 
- Karush-Kuhn-Tucker conditions 를 만족할 경우 a_i가 좋은 성질을 가짐. -> global minimum이 보장됨.
    - a_i는 margin 끝에 정확히 점이 위치할 때만, 0이 아닌 값을 가질 수 있음.
    - 이 점들을 support vectors라고 함.
- SVM with Kernel : 선형관계가 아닌 경우 사용 
    - d^th-degree polynomial 
    - Gaussian Kernel 

- 장점 
    - 데이터의 분포가정이 힘든경우에 좋음
    - 예측의 정확도가 높음
- 단점
    - C를 결정해야함
    - 모형 구축에 시간이 오래 걸림.
    
- One-Class SVM
    - 종속변수 정보가 없는 자료를 요약하는 데 SVM을 사용
    - 
