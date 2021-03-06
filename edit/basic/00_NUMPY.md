# IPython

> 대화형 파이썬 

- help(), ? = 문서 확인
- ?? : 소스코드 접근
- * : 와일드카드 매핑
- 파이썬 매직 명령어
    - %paste : 붙여 넣기
    - %run : 외부 코드 실행
    - %timeit : 코드 실행 시간 측정 
    
<br>

# NumPy 

<br>

## 배열 속성 지정 

> 배열의 크기, 모양, 메모리 소비량, 데이터 타입을 결정 

- ndim : 차원의 갯수
- shape : 각 차원의 크기
- size : 전체 배열의 크기 
    
```jupyterpython

import numpy as np

x3 = np.random.randint(10,size=(3,4,6))

print(x3.ndim) # 3
print(x3.shape) # (3,4,5)
print(x3.size) # 60

```
<br>

## 배열 인덱싱 

> 개별 배열 요솟값을 가져오고 설정한다

```jupyterpython
x1[0]
x1[-1] # 뒤에서부터 인덱싱
x2[0,0] # 다차원 배열에서는 콤마로 구분된 인덱스 튜플을 이용해 접근 
```

<br>

# 배열 슬라이싱 

> 큰 배열 내에 있는 작은 하위 배열을 가져오고 설정한다.

- 기본형태 x\[start:stop:step]
- 사본이아닌 뷰를 반환.
- 사본을 만들때는 .copy() 메소드 활용 

```jupyterpython

x[:5] # 첫 다섯개
x[5:] # 인덱스 5다음의 요소 
x[::2] # 하나 걸러 하나씩의 요소로 구성된 배열
x[1::2] # 인덱스 1에서 시작해 하나 걸러 하나씩 요소로 구성된 배열 
x[::-1] # 모든 요소를 거꾸로 나열 
x[5::-2] # 인덱스 5부터 하나걸러 하나씩 요소를 거꾸로 나열 
x2[:2,:3] # 다차원배열 
x2[::-1,::-1] 

```

<br>

# 배열 재구조화 
 
> 해당 배열의 형상을 변경

- reshape 메소드를 활용

```jupyterpython
grid = np.arrage(1,10).reshpe((3,3)) # 3x3 그리드로 변경 
x = np.array([1,2,3])

x.reshape((1,3)) # 행 벡터
x.reshape((3,1)) # 열 벡터 
```

# 배열 결합 및 분할 배열 

> 여러 배열을 하나로 결합하고, 하나의 배열을 여러개로 분할 

```jupyterpython

# 합치기

x = np.array([1,2,3])
y = np.array([3,2,1])
np.concatenate([x,y]) # 1,2,3,32,1

x = np.array([1,2,3])
grid = np.array([9,8,7],[6,5,4])
np.vstack([x,grid]) # 배열을 수직으로 쌓음
np.hstack([x,grid]) # 배열을 수평으로 쌓음

# 분할하기

upper, lower = np.split(grid,[2)

```

<br>

# 유니버셜 함수

```jupyterpython

x = np.array([-2,-1,0,1,2])
y = np.zeros(10)
x2 = x + 5 # 5씩 더함
x3 = np.abs(x) # 절대값 함수
x4 = np.sin(x) # 삼각함수
x5 = np.exp(x) # 지수함수
x6 = np.log(x) # 로그함수
# x7 = np.power(2,x,out=y[::2]) # 출력지정
x7 = np.add.reduce(x) # x의 모든 요소 합
x8 = np.multiply.reduce(x) # x의 모든 요소의 곱
x9 = np.min(x) #최소값
x10 = np.max(x) #최대값 
x11 = x.min(axis=0) # 열에 관한 최소값 

```

<br>

# 브로드케스팅 

- 두 배열의 차원 수가 다르면 작은 수의 차원을 가진 배열 형상의 앞쪽을 1로 채운다
- 두 배열의 형상이 어떤 차원에서도 일치하지 않는다면 해당 차원의 형상이 1인 배열이 다른 형상과 일치하도록 늘어난다.
- 임의의 차원에서 크기가 일치하지 않고 1도 아니라면 오류 발생 