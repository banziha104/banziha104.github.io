# 불균형 데이터

> 다수 클래스가 소수 클래스의 수보다 월등히 많은 학습 상황을 의미, 분류 성능이 저하되는 문제가 발생 

- IR = majority / minority 
- 모델이 소수의 데이터를 무시하는 경향이 생김. 
- 해결법
    - Resampling method : 전처리 단계에서 실행 
        - Over Sampling : 소수의 데이터를 부풀리는 방법
        - Under Sampling : 다수의 데이터를 줄이는 방법
        - Hybrid resampling : Over & Under Sampling 혼합
    - Cost-sensitive learning : 알고리즘 단계에서 실행
        - Class 의 오분류에 대한 cost의 가중치를 조절하는 
        