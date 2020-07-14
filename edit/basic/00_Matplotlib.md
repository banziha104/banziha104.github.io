# Matplotlib

- %matplotlib notebook 노트북 내에 대화형 플롯 삽입
- %matplotlib inline 노트북에 플롯의 정적 이미지 삽입

- 스타일 및 저장하기 

```python
plt.style.use('classic') # 스타일 정하기
x = np.linspace(0,10,100)
fig = plt.figure()
plt.plot(x, np.sin(x),'-') 
fig.savefig('my_figure.png') # 저장하기 
```

<br>

- 서브플롯 

```python

# 두개의 플롯 이용하기

plt.figure()
plt.subplot(2,1,1)
plt.plot(x,np.sin(x))
plt.subplot(2,1,2)
plt.plot(x,np.cos(x))

fig, ax = plt.subplot(2) # 두개의 축 객체의 배열
ax[0].plot(x,np.sin(x))
ax[1].plot(x,np.cos(x));

```

<br>

- 액시스 조정
 
```python
plt.style.use('seaborn-whitegrid')
fig = plt.figure()
ax = plt.axes()

x = np.linspace(0,10,1000)
ax.plot(x,np.sin(x))
plt.xlim(-1,11) # axis  설정하기
plt.ylim(-1.5,-1.5)
plt.axis([-1,11,-1.5,-1.5]) # 위와 동일하게 축설정
plt.axis('tight') # 타이트하게 그래프를 만듬 , eqaul을 쓸경우 가로세로 비율을 균등하게 설정 .


```

<br>

- 라벨 붙이기
 
```python

plt.plot(x, np.sin(x))
plt.title("사인 함수") # 이름 붙이기
plt.xlabel("x") # 라벨 붙이기
plt.ylabel("sin(x)")

```

<br>

- 범례생성

```python

plt.plot(x,np.sin(x), '-g', label='sin(x)')
plt.plot(x,np.cos(x), ':b', label='cos(x)')
plt.legend() # 범례를 생성 

```

<br>


- 마커 종류 

```python

rng = np.random.RandomState(0)
for marker in ['o','.',',','x','+','v','^','<','>','s','d']:
    plt.plot(rng.rand(5),rng.rand(5),marker,label="maker={0}".format(marker))
    plt.legend(numpoints=1)
    plt.xlim(0,1.8)

```

<br>

- 산점도 : scatter 메소드 이용 

```python

rng =np.random.RandomState(0)
x = rng.randn(100)
y = rng.randn(100)
colors = rng.rand(100)
sizes = 1000 * rng.rand(100)
plt.scatter(x,y,c=colors,s=sizes,alpha=0.3,cmap='viridis')
plt.colorbar() # 색상 척도 표시

```
