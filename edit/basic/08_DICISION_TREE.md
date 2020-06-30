# Decision Tree

- 변수들로 기준을 만들고 이것을 통하여 샘플을 분류하고 분류된 집단의성질을 통하여 추정하는 모형 
- 장점 : 해석력이 높음. 직관적. 범용성
- 단점 : 높은 변동성. 샘플에 민감할 수 있음.
- 용어
    - Node : 분류의 기준이 되는 변수
        - Parent Node : 상위 노드 
        - Child Node : 하위 노드
        - Root Node : 상위 노드가 없는 가장 위의 노드
        - Leaf node (tip) : 하위노드가 없는 가장 아래의 노드
        - Internal node : Leaf node가 아닌 노드 
    - Edge : 샘플을 분류하는 조건이 위치하는 곳
    - Depth - Root node에서 특정 노드까지 도달하기 위해 거쳐야하는 Edge의 수 
- 범주형 변수 - 분류 트리
- 연속형 변수 - 회귀 트리
- 엔트로피 
    - -plog_2^p-(1-p)log_2(1-p)
    - 엔트로피가 높다 : 많이 섞여 있다.
    - 엔트로피가 낮다 : 분류가 되어져 있다.
- Information Gain = Entropy_before - Entropy_after
    - 어떠한 변수를 가장 상위로 쓸 것인가
    - 일반적으로는 웨이트를 줘서 사용 
        - 가중 평균을 통해 구함.
    - weight 안주고 IG값 그대로 사용해도 상관없음.
    
- Classification Tree
    - Tree 조건에 따라 , x가 가질 수 있는 영역을 Block으로 나누는 개념 
 - R_m의 구성
    - 범주형 : 범주에 따라
    - 연속형 : 여러개의 영역을 임의로 나눔
    - 나누어진 영역들에 대하여, 아래 measure를 가장 좋은 값으로 만드는 변수와 기준을 선택 
        - 엔트로피
        - 오분률율
        - Gini Index 

- Regression Tree
    - Tree 조건에 따라, 나누어진 영역안에 속하는 샘플의 특성을 통하여 Y를 추정 
