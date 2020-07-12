# Pandas


- Pandas Series : 인덱싱된 데이터의 1차원 배열
    - NumPy와의 차이는 인덱스 존재 여부. NumPy는 암묵적 인덱스, Series에는 명시적 인덱스가 있음.
    
```python

data = pd.Series([0,1,2,3]) # 배열에서 생성
data.values # numpy 배열
data2 = pd.Series({'name' : 'lee', 'age' : 29}) # 딕셔너리 생성
data3 = pd.Series([0,1,2,3], index=['a','b','c','d']) 

```

- Pandas DataFrame : 이름을 가진 2차원 배열 

```jupyterpython

number = {'a' : 1, 'b' :2 , 'c' : 3 , 'd' : 4, 'e' : 5}
name = {'a' : "가" , 'b' : '나', 'c' : '다' , 'd' : '라' , 'e' : '마'}

df = pd.DataFrame({'name' : name, 'number' : number}) # DataFrame 생성
df.index # 인데스
df.columns # colums 값 가져오기 

```

- Pandas Index : 판다스는 명시적 인덱스를 포함, 
    - loc : 명시적인 인덱스를 참조하는 인덱싱과 슬라이싱 
    - iloc : 암묵적인 인덱싱과 슬라이싱 
- NaN : 누락된 데이터
- isnull() : 누락값을 가르키는 부울 마스크
- notnull() : isNull의 반대 
- dropna() : 데이터의 필터를 적용한 버전을 반환
- fillna() : 누락 값을 채우거나 전가된 데이터 사본을 반환
- Pandas MultiIndex 생성 

```python

df = pd.DataFrame(np.random.rand(4,2), index=[['a','a','b','b'],[1,2,1,2]],columns=['data1','data2'])

```

- 데이터 세트 결합
    - Concat
    - Append