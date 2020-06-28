# 나이브 베이즈 

- 설명변수 간의 독립을 가정.
- 수학적 개념
    - 조건부확률 : P(A|B) = P(A and B)/(B)
    - 베이즈 정리 = A_1..A_k가 배반사건일때, P(A_i|B) = P(A and B)/P(B) = P(B|A_i)P(A_i)/P(B|A_1)P(A_1)..P(B|A_k)P(A_k)
- 종류
    - Gaussian naive bayes classifier : 설명변수가 연속형인 경우 -> 정규분포임을 가정 
    - Multinomial naive bayes classifier : 설명변수가 범주형인 경우
        - Bernoulli naive bayes classifier : 설명변수가 이분형인 경우
        
