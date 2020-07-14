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
    - Concat : 두 객체를 합침. pd에 있음.
        - verify_intergrity : True 로 설정할 경우 중복인덱스일 때 에러 발생
        - ignore_index : 인덱스 무시 
        - keys : 다중인 덱스  
        - join : default는 Outer 합집합 , inner를 통해 교집합으로 변경가능
    - Append : 두 객체를 합침. 각 객체에 있음, 원래의 객체를 변경하지 않고 새로운 객체를 만듬. 
- 병합과 조인 : pd.merge()
    - 일대일 조인 
    - 다대일 조인
    - 다대다 조인  
    - 병합키 지정 
        - on : 열 이름 또는 행 이름을 명시함
        - left_on, right_on : 다른 열 이름을 가진 두 세트를 병합때 두 열의 이름을 지정.     할
        - left_index, right_index : 열을 병합하는 대신 인덱스로 병합할때 사용 
        - join() : 기본적으로 인덱스를 기반으로 하는 조인 메소드가 구현되어져 있음.
        - how : inner, outer, left , right 가 있으면, 내부 외부 레프트 라이트 조인을 의미.
        - suffixes : 열 이름이 겹치는 경우 접미사를 별도로 붙여줌 
- 집계와 분류 
    - sum, mean, median, min, max 와 같은 집계연산자 지원 
    - std,var 표준 편차와 분산 
    - groupby() : 그룹핑, 순회가능함. 
        - aggregate() : 집계 계산 , df.groupby('key').aggregate({'data':'min', 'data':'max'})
        - filter() : 필터링 
        - apply() : 임의의 함수를 그룹 결과에 적용할 때 사용         
    
- 피벗 테이블 : 표 형태의 데이터로 작업하는 스프레드시트와 비슷한 작업.
    - aggrunc : 집계 제어를 명시, sum, mean 등
    
```python

pt = titanic.pivot_table('survived',index='sex',columns='class')

```
