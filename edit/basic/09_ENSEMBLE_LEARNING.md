# Ensemble Learning 

  > 여러 개의 기본모델을 활용하여 하나의 새로운 모델을 만들어내는 개념

- 기본 모
    - weak learner
    - classifier
    - base learner
    - single learner
- 대수의 법칙 : 무작위로 뽑은 표본 전체 모집단의 평균과 가능성이 높아진다.
- 다양한 learner를 만들면 전체의 모델의 성능이 좋아짐.
- 각각의 base leaner 들은 0.5 이상의 정확도를 가져아함.
- 각각의 분류기는 독립이어야함
- 총 분류기의 수는 이론적으로 무한대이어야함 
- 테스트 데이터에 대해 다양한 예측값을 수렴하기 위해 overfitting이 잘되는 모델을 기본적으로 사용
- 종류 
    - Bagging : 모델을 다양하게 만들기 위해 데이터를 재구성 
    - RandomForest : 모델을 다양하게 만들기 위해 데이터 뿐만아니라 변수도 재구성
    - Boosting : 맞추기 어려운 데이터에 대해 좀더 가중치를 두어 학습하는 개념
        - AdaBoost
        - Gradient boosting
    - Stacking : 모델의 output값을 새로운 독립변수로 사용
    
<br>

# Bagging

>  모델을 다양하게 만들기 위해 데이터를 재구성 


<br>

- 전체 데이터에서 bootstrap (복원추출) 함
- 추출되지 않은 데이터는 Test로 사용
- 트리 vs 배깅
    - 깊이 성장한 트리 : 분산 증가, 편향 감소
    - 배깅 
        - 트리들의 편향 유지, 분산 감소
        - 노이즈에 강건해짐 -> 모델의 성능이 높아짐
        - 모형해석이 어려움
- 단점 : 
    - 배깅트리의 분산은 트리들의 분산과 그들의k 공분산으로 이루어짐.
    - 트리가 증가함에 따라 어ㅗ히려 모델 전체의 분산이 증가 할 수도 있음.
    
<br>

# Random Forest 

> 데이터 뿐만 아니라 변수도 random하게 뽑아서 다양한 모델을 만듬(base learner의 공분산을 줄임)

- 뽑의 변수의 수를 hyper parameter 
- 모델의 분산을 줄여 일반적으로 Bagging보다 성능이 좋음.

<br>

# Boosting

> 오분류된 데이터에 초점을 맞추어 더 많은 가중치를 주는 방식 

- 초기에는 모든 데이터가 동일한 가중치를 가지지만, round가 종료된 후 가중치와 중요도를 계산
- 복원추출 시에 가중치 분포를 고려
- 오분류된 데이터가 가중치를 더 얻게 됨에 따라 다음 round에서 더 많이 고려됨
- AdaBoost
    - 모든 가중치를 동일하게 0.1로 설정
    - 오분류된 데이터에 가중치를 크게, 정분류된 데이터에 가중치를 작게 설정
    - 좋은 성능을 보이는 weak learner를 기준으로 최종
- Gradient Boost
    - 이전 Round의 합성 분류기의 데이터 별 오류를 예측하는 새로운 약한 분류기를 학습 
    - 예측 가능한 노이즈를 제거 
    - h0는 y를 예측 
    - 다음 라운드에서 h1가 y가 아닌 오차(error)를 예측함
    - 다음 라운드에서 h2가 error2를 예측
    - 이를 반복하면 small error가 만들어짐.
    - Negative gradient(residual)을 최소화 시키면서 학습 시키기 때문에 gradient boosting이라 부름.
- Gradient Boosting 종류 
    - 일반적으로 CatBoost == LightGBM > XGBoost
    -  XGBoost
        -  Regularization Term이 추가 되어서 모델이 과적합 되는 것을 막아줌 
    - LightGBM 
        - leaf-wise loss 사용 , Xgboost 대비 2배 이상 빠른 속도, 
        - Overfitting에 민감하여, 대량의 학습데이터가 필요함.
    - CatBoost
        - 잔차 추정의 분산을 최소화 하면서 bias를 피하는 boosting 기법 

<br>

# Stacking 

> 모델의 output 값을 새로운 독립변수로 사용

- Mata Leaner라고 불리우며, 다양한 모델을 결합하여 사용하는 기법
- 성능은 좋으나, 학습비용이 매우 높음.

<br>

# Shape Value

> 중요변수 추출 

- 연합 게임 이론의 Shapley value에서 따옮.
- player에게 기여도에 따른 payout을 배당.
- Emsemble Learing 모델들은 중요 feature 를 추출 할 수 있는 알고리즘이 내장.
- 모델에 알고리즘이 내장되어있음. 
- Weight : 변수 별 데이터를 분리하는데 쓰인 수
- Cover : 변수 별 데이터를 분리하는 데 쓰인 횟수(해당 변수로 분리된 데이터의 수로 가중치)
- Gain : Feature를 사용했을 때 줄어드는 평균적인 training loss
- Feature importance의 기준
    - 특정 feature가 영향이 많이 가도록 모델을  수정하였다면, 중요도 측정 시 해당 Feature의 중요도가 줄지 않아야함. 
