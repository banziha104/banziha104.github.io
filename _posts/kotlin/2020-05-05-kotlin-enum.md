---
layout: post
title:  "Kotlin의 Enum 어디까지 써봤니?"
date:   2020-05-05
banner_image: kotlin/Desk.jpg
tags: [tips, work]
---

> *죄송합니다. 이거 보여주려고 반말로 어그로 끌었습니다.*<br>
> *내가 알던 그 기능 없는 찐따 깡통 같던 옛날 자바의 Enum 맞나?* <br/>
> *Enum 은 전설이다.. 가슴이 웅장해진다..*

<!--more-->

<br>

## Kotlin Enum
    
 Enum 클래스는 많은 언어에서 지원하고 있으며, 조금 C언어나 Java 1.5 버전등 오래된 언어에서는 주로 대부분 데이터 타입을 분류하는 <mark>Flag</mark> 역할과 <mark>상수를 저장하는</mark> 역할 두 가지의 역할로 사용하고 있습니다. <br>
 
Swift, Kotlin 등 현대 언어에서의 Enum에는 추가적으로 강력한 기능들이 존재하는데, 예전 방식에 영향을 받아 Kotlin에서도 Flag와 상수값 저장 두가지 역할을 주로 수행하도록 구현되는 것 같습니다. <br> ~~본인도 포함~~ <br>

Kotlin Enum에 대해 견문을 조금 더 넓혀보는 기회를 만들어보고자 포스팅하였습니다.

<br>

## Kotlin의 Enum 기본 사용법

> Kotlin의 Enum은 Comparable 인터페이스를 구현하는 Abstract Class입니다. <br>
> Comparable을 구현함으로써 비교가 가능해지지만, <br>
> 그것보다는 추상클래스임을 인지하는 것이 중요합니다. 

- Enum 클래스 멤버
    - 변수 
        - name : 호출하는 Enum value의 이름을 반환합니다. 
        - ordinal : 호출하는 Enum value의 인덱스를 반환합니다.
    - 함수 : 자체적인 함수는 없고, 상속받은 함수들만 있습니다. 
        - Cloneable -> clone()
        - Comparable -> compareTo() : 두 Enum value 간 인덱스의 차를 반환합니다 
        - Any -> 있는 equals, hashCode, toString
    
- kotlin 1.1 부터 추가된 확장함수들 
    - enumValues<Enum<T>>() : 해당 Enum의 value를 배열로 만들어 반환합니다. 
    - enumValueOf<Enum<T>>(name : String) : 해당 enum에 name의 이름을 가진 요소를 찾아 반환합니다.  
    
#### 말이 어려워서 그렇지.. 아래 예제 보시면 금방 이해 되실 겁니다. 

{% highlight kotlin %}

enum class GarbageType1(
    val koName : String
){
    PLASTIC("플라스틱"),
    GLASS("유리"),
    IRON("고철")
}

fun main() {
    // 위에 정의한 IRON 이라는 이름값을 얻을 수 있습니다.
    //"IRON", String
    println(GarbageType1.IRON.name) 

    // zero-base index, PLASTIC은 첫 번째 임으로 0이 반환됩니다.
    // 0, Int
    println(GarbageType1.PLASTIC.ordinal) 

    // IRON 세 번째 임으로 2가 반환 됩니다.
    // 2, Int 
    println(GarbageType1.IRON.ordinal) 

    // 아래 두 함수는 kotlin 1.1 버전부터 지원됩니다
    /***
     * Enum의 요소를 차례로 배열로 만들어줍니다
     * array == arrayOf(
     *    GarbageType1.PLASTIC,
     *    GarbageType1.GLASS,
     *    GarbageType1.IRON
     * )
     */
    val array = enumValues<GarbageType1>()

    // iterable이기 때문에 map, filter 등 도 가능합니다.
    array
        .filter { it.koName == "플라스틱" }
        .map { it.koName }
    
    /***
     * GarbageType1에 PLASTIC 이라는 이름을 가진 요소를 반환합니다.
     * type == GarbageType1.PLASTIC
     */
    val type = enumValueOf<GarbageType1>("PLASTIC") 
}

{% endhighlight %}

<br>

## Enum 실제 사용 (예시 프로젝트)

> 해당 고물의 종류와 무게를 입력받아, 아래표를 기반으로 총 가격이 얼마인지 <br>
> 알려주는 프로그램을 만들어보면서 Enum에 대해 더 알아 보겠습니다. 


| 분류     | 10kg 미만 | 10kg이상 30kg미만 | 30kg 초과  |
|----------|-----------|-------------------|------------|
| 플라스틱 | 100원     | 150원             | 200원      |
| 유리     | 150원     | 250원             | 300원      |
| 고철     | 200원     | 250원             | 300원      |

*단위 : kg당*

<br>

## 고전적인 방식 

> Enum 의 고전적인 처리방법은 Enum을 Flag 삼아 조건분기를 처리하는 것입니다. <br>
> 아래 코드의 문제점은 Enum이 가지는 책임(쓰레기의 종류를 분류하는 책임)이 <br> 
> sell함수에 전가되어 있다는 부분입니다. 

{% highlight kotlin %}

enum class GarbageType2(
    val koName: String
) {
    PLASTIC("플라스틱"),
    GLASS("유리"),
    IRON("고철")
}

fun main() {
    // 플라스틱 20키로를 표현했습니다.
    val pair = 20 to GarbageType2.PLASTIC

    // 총 가격을 구해옵니다.
    val totalPrice = sell(pair)

    // 총 가격은 3000입니다 출력 
    println("총 가격은 $totalPrice 입니다.")
}

// 판매 가격 알아내기
private fun sell(pair: Pair<Int, GarbageType2>): Int {
    // 분해할당으로 weight는 20, type GarbageType2.PLASTIC이 할당됩니다.
    val (weight, type) = pair

    // 현재 가져온 고물의 종류와 무게로 kg당 얼마인지 가져옵니다.
    // Enum을 아이템을 분류하는 Flag로 삼아 조건 분기합니다.
    val price = when (type) {
        GarbageType2.PLASTIC -> {
            when (weight) {
                in 0..10 -> 100
                in 10..29 -> 150
                in 30..Int.MAX_VALUE -> 200
                else -> throw EnumValueMisMathedException()
            }
        }
        GarbageType2.GLASS -> {
            when(weight){
                in 0..10 -> 150
                in 10..29 -> 250
                in 30..Int.MAX_VALUE -> 300
                else -> throw EnumValueMisMathedException()
            }
        }
        GarbageType2.IRON -> {
            when(weight){
                in 0..10 -> 100
                in 10..29 -> 150
                in 30..Int.MAX_VALUE -> 200
                else -> throw EnumValueMisMathedException()
            }
        }
    }
    return weight * price
}

{% endhighlight %}

<br>

## Enum에게 함수 쥐어주기 

> Enum이 Flag 이외의 기능을 하지 않는게 꼴보기 싫으신가요? ~~Enum이 꿀빤다...후...~~ <br>
> Enum 또한 추상클래스이기 때문에 기능을 가질 수 있습니다. <br>
> Enum에게 기능을 제공해 줌으로써, sell 함수에게 전가된 책임을 가져올 수 있습니다. <br>
> ~~일해라 Enum d(^~^)b~~

## 인터페이스 상속

## 




{% highlight kotlin %}

val a = 10

fun test(a Int) : String{
    return "$a"
}

test(a)

{% endhighlight %}
                    
