---
layout: post
title:  "Kotlin의 Enum 어디까지 써봤니?"
date:   2020-05-05
banner_image: kotlin/2020-05-05-kotlin-enum.png
tags: [kotlin, enum]
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
> 무엇보다도 __<mark>추상클래스임을 인지</mark>__ 하는 것이 중요합니다. 

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

```kotlin

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

    // zero-base index, PLASTIC은 첫 번째이므로 0이 반환됩니다.
    // 0, Int
    println(GarbageType1.PLASTIC.ordinal) 

    // IRON 세 번째 이므로 2가 반환 됩니다.
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

```

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
> 아래 코드의 문제점은 Enum이 가지는 __<mark>책임(쓰레기의 종류를 분류하는 책임)이 <br> sell함수에 전가</mark>__ 되어 있다는 부분입니다. 

```kotlin 

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
    // 이 부분을 Enum에서 처리한다면 코드가 더 직관적으로 될 것입니다. 
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

```

<br>

# Enum의 각 요소 별로 기능 정의하기 

Enum이 Flag 이외의 기능을 하지 않는게 꼴보기 싫으신가요? ~~Enum이 꿀빤다...후...~~ <br>
Enum 또한 __<mark> 추상클래스이기 때문에 메소드를 가질 수 </mark>__ 있습니다. <br>
Enum에게 기능을 제공해 줌으로써, sell 함수에게 전가된 책임을 가져올 수 있습니다. <br>
~~일해라 Enum d(^~^)b~~
 
<br>

### 1.멤버 변수로 추가하기

> 멤버변수로 함수를 받는 방법입니다. <br>
> 아래 sell부분이 굉장히 깔끔해진것을 볼 수 있습니다 <br>
> 문제점이 하나 있는데, __<mark>다른 멤버변수에 접근할 수 없기 때문에</mark>__ <br>
> 아래 방법들보다는 활용도가 떨어집니다. 

```kotlin

enum class GarbageType3(
    val koName : String,
    val calculate : (Int) -> Int // 멤버변수로 추가해줍니다.
){
    PLASTIC("플라스틱",{
        // this.koName 에 접근할 수 없음.
        when (it) {
            in 0..10 -> 100
            in 10..29 -> 150
            in 30..kotlin.Int.MAX_VALUE -> 200
            else -> throw EnumValueMisMathedException()
        }
    }),
    GLASS("유리",{
        when (it) {
            in 0..10 -> 100
            in 10..29 -> 150
            in 30..kotlin.Int.MAX_VALUE -> 200
            else -> throw EnumValueMisMathedException()
        }
    }),
    IRON("고철",{
        when (it) {
            in 0..10 -> 100
            in 10..29 -> 150
            in 30..kotlin.Int.MAX_VALUE -> 200
            else -> throw EnumValueMisMathedException()
        }
    });
}

fun main() {
    val pair = 20 to GarbageType3.PLASTIC

    val totalPrice = sell(pair)

    println("총 가격은 $totalPrice 입니다.")
}

// 판매 가격 알아내기
private fun sell(pair: Pair<Int, GarbageType3>): Int {
    val (weight, type) = pair

    // 분류의 책임이 사라져 굉장히 클-린해졌습니다 !
    val price= type.calculate(weight)

    return weight * price
}


```

### 2.인터페이스 구현

> Enum 또한 추상클래스이기 때문에, __<mark>Interface를 구현할 수 있습니다.</mark>__ <br>
> 오버라이딩하기 때문에 멤버변수에 접근할 수 있고 최상위의 sell함수와 GarbageType 간의 의존성을 낮출 수 있어 굉장히 좋은 방법입니다. 다만 복잡도만 증가 시킬 수 있음으로 상황에 맞춰 사용하면 좋습니다 <br>

```kotlin

// 인터페이스를 정의합니다.
interface Calculable {
    fun calculate(weight: Int): Int
}

enum class GarbageType4(
    val koName: String
) : Calculable { // enum이 Calculable 인터페이스를 상속 받습니다. 
    PLASTIC("플라스틱") {
        // 각 멤버가 인터페이스에 정의된 메소드를 구현해줍니다. 
        override fun calculate(weight: Int): Int = when (weight) {
            in 0..10 -> 100
            in 10..29 -> 150
            in 30..Int.MAX_VALUE -> 200
            else -> throw EnumValueMisMathedException()
        }
    },
    GLASS("유리") {
        override fun calculate(weight: Int): Int = when (weight) {
            in 0..10 -> 100
            in 10..29 -> 150
            in 30..kotlin.Int.MAX_VALUE -> 200
            else -> throw EnumValueMisMathedException()
        }
    },
    IRON("고철") {
        override fun calculate(weight: Int): Int = when (weight) {
            in 0..10 -> 100
            in 10..29 -> 150
            in 30..kotlin.Int.MAX_VALUE -> 200
            else -> throw EnumValueMisMathedException()
        }
    }
}


fun main() {
    val pair = 20 to GarbageType4.PLASTIC

    val totalPrice = sell(pair)

    println("총 가격은 $totalPrice 입니다.")
}

// 이제 sell 함수에서 Calculable 인터페이스를 인자로 받습니다.
private fun sell(pair: Pair<Int, Calculable>): Int {
    val (weight, type) = pair

    // 분류의 책임이 사라져 굉장히 클-린해졌습니다 !
    val price = type.calculate(weight)

    return weight * price
}

```

### 3.추상 메소드로 추가하기 

> Enum은 __<mark>추상클래스이기 때문에, 추상메소드를 선언 및 구현할 수 있습니다.</mark>__ <br>
> 오버라이딩하기때문에 멤버변수에 접근이 가능합니다. 

```kotlin


enum class GarbageType5(
    val koName: String
) {
    PLASTIC("플라스틱") {
        // 각 멤버가 인터페이스에 정의된 메소드를 구현해줍니다.
        override fun calculate(weight: Int): Int = when (weight) {
            in 0..10 -> 100
            in 10..29 -> 150
            in 30..Int.MAX_VALUE -> 200
            else -> throw EnumValueMisMathedException()
        }
    },
    GLASS("유리") {
        override fun calculate(weight: Int): Int = when (weight) {
            in 0..10 -> 100
            in 10..29 -> 150
            in 30..Int.MAX_VALUE -> 200
            else -> throw EnumValueMisMathedException()
        }
    },
    IRON("고철") {
        override fun calculate(weight: Int): Int = when (weight) {
            in 0..10 -> 100
            in 10..29 -> 150
            in 30..Int.MAX_VALUE -> 200
            else -> throw EnumValueMisMathedException()
        }
    }; // !!!!*중요* 요소들을 선언한 후에는 반드시 세미콜론을 찍어야 기능을 정의할 수 있습니다!!!!!!
    abstract fun calculate(weight: Int) : Int
}


fun main() {
    val pair = 20 to GarbageType5.PLASTIC

    val totalPrice = sell(pair)

    println("총 가격은 $totalPrice 입니다.")
}

private fun sell(pair: Pair<Int, GarbageType5>): Int {
    val (weight, type) = pair

    // 분류의 책임이 사라져 굉장히 클-린해졌습니다 !
    val price = type.calculate(weight)

    return weight * price
}

```

<br>

# Enum에 동일한 로직을 가지는 기능 추가하기 

> 총 비용을 계산하는 calculate 함수의 경우에는 모두가 로직이 달랐음으로 <br>
> 각 요소에서 구현해주었습니다. 그러나 만약 __<mark>로직이 동일한 경우에는 enum 클래스 자체에서 구현이 가능합니다</mark>__
> 가격 측정이 귀찮아서 10kg미만 가격에 모두 팔아버리는 dump() 메소드를 구현해보겠습니다.


<br>

### 1. Interface로 구현하기 

> calculate는 요소별로 로직이 다른 함수이고, dump는 모든 요소가 같은 로직을 공유합니다. <br>
> 각 요소별로 구현하는 것은 생산성과 가독성이 떨어짐으로 enum class 자체에서 구현합니다. <br>
> __<mark>요소 정의 끝에 세미콜론 찍는 것 잊으시면 안됩니다!</mark>__

```kotlin

// 인터페이스를 정의합니다.
interface Calculable2 {
    fun calculate(weight: Int): Int
    fun dump(weight: Int) : Int
}

enum class GarbageType6(
    val koName: String,
    val dumpingPrice : Int // 10kg미만일때 가격을 추가해줍니다
) : Calculable2 {
    PLASTIC("플라스틱",100) {
        // 각 멤버가 인터페이스에 정의된 메소드를 구현해줍니다.
        override fun calculate(weight: Int): Int = when (weight) {
            in 0..10 -> 100
            in 10..29 -> 150
            in 30..Int.MAX_VALUE -> 200
            else -> throw EnumValueMisMathedException()
        }
    },
    GLASS("유리",150) {
        override fun calculate(weight: Int): Int = when (weight) {
            in 0..10 -> 100
            in 10..29 -> 150
            in 30..kotlin.Int.MAX_VALUE -> 200
            else -> throw EnumValueMisMathedException()
        }
    },
    IRON("고철",200) {
        override fun calculate(weight: Int): Int = when (weight) {
            in 0..10 -> 100
            in 10..29 -> 150
            in 30..kotlin.Int.MAX_VALUE -> 200
            else -> throw EnumValueMisMathedException()
        }
    }; // !!!!*중요* 요소들을 선언한 후에는 반드시 세미콜론을 찍어야 기능을 정의할 수 있습니다!!!!!!

    // 각 요소가 구현하지 않고, enum class 자체에서 구현합니다
    override fun dump(weight: Int): Int = dumpingPrice * weight

}


fun main() {
    val pair = 20 to GarbageType6.PLASTIC
    val (weight, type) = pair

    // plastic의 멤버변수 dumpingPrice가 100원이므로 "총 가격은 2000입니다."가 출력됩니다.
    println("총 가격은 ${type.dump(weight)} 입니다.")
}

```

<br>

### 2. 추상클래스로 구현하기
> 동일한 로직을 가지는 경우에는 추상메소드로 선언하지 않고, 바로 메소드를 정의합니다. <br>
> 그 외에는 인터페이스와 동일합니다. __<mark>요소 정의 끝에 세미콜론 찍는 것까지도요!</mark>__

```kotlin 

// 인터페이스를 정의합니다.

enum class GarbageType7(
    val koName: String,
    val dumpingPrice : Int // 10kg미만일때 가격을 추가해줍니다
) {
    PLASTIC("플라스틱",100) {
        // 각 멤버가 인터페이스에 정의된 메소드를 구현해줍니다.
        override fun calculate(weight: Int): Int = when (weight) {
            in 0..10 -> 100
            in 10..29 -> 150
            in 30..Int.MAX_VALUE -> 200
            else -> throw EnumValueMisMathedException()
        }
    },
    GLASS("유리",150) {
        override fun calculate(weight: Int): Int = when (weight) {
            in 0..10 -> 100
            in 10..29 -> 150
            in 30..kotlin.Int.MAX_VALUE -> 200
            else -> throw EnumValueMisMathedException()
        }
    },
    IRON("고철",200) {
        override fun calculate(weight: Int): Int = when (weight) {
            in 0..10 -> 100
            in 10..29 -> 150
            in 30..kotlin.Int.MAX_VALUE -> 200
            else -> throw EnumValueMisMathedException()
        }
    }; // !!!!*중요* 요소들을 선언한 후에는 반드시 세미콜론을 찍어야 기능을 정의할 수 있습니다!!!!!!
    abstract fun calculate(weight: Int) : Int
    // 동일한 로직을 사용하는 경우에는, abstract 하지 않고 바로 구현하면됩니다.
    fun dump(weight: Int): Int = dumpingPrice * weight

}


fun main() {
    val pair = 20 to GarbageType7.PLASTIC
    val (weight, type) = pair

    // plastic의 멤버변수 dumpingPrice가 100원이므로 "총 가격은 2000입니다."가 출력됩니다.
    println("총 가격은 ${type.dump(weight)} 입니다.")
}

```

<br>

# Companion Object 사용하기 

> Enum은 추상클래스이기 때문에 Companion Object를 사용 및 정의할 수 있습니다. <br>
> 다음은 Enum을 순회하면서 정보를 알려주는 print 함수를 정의했습니다. 

```kotlin



// 인터페이스를 정의합니다.

enum class GarbageType8(
    val koName: String,
    val dumpingPrice : Int // 10kg미만일때 가격을 추가해줍니다
) {
    PLASTIC("플라스틱",100) {
        // 각 멤버가 인터페이스에 정의된 메소드를 구현해줍니다.
        override fun calculate(weight: Int): Int = when (weight) {
            in 0..10 -> 100
            in 10..29 -> 150
            in 30..Int.MAX_VALUE -> 200
            else -> throw EnumValueMisMathedException()
        }
    },
    GLASS("유리",150) {
        override fun calculate(weight: Int): Int = when (weight) {
            in 0..10 -> 100
            in 10..29 -> 150
            in 30..kotlin.Int.MAX_VALUE -> 200
            else -> throw EnumValueMisMathedException()
        }
    },
    IRON("고철",200) {
        override fun calculate(weight: Int): Int = when (weight) {
            in 0..10 -> 100
            in 10..29 -> 150
            in 30..kotlin.Int.MAX_VALUE -> 200
            else -> throw EnumValueMisMathedException()
        }
    };
    abstract fun calculate(weight: Int) : Int

    companion object{
        fun print() {
            enumValues<GarbageType8>()
                .map { "${it.koName}은(는) 10kg에 ${it.dumpingPrice}" }
                .forEach { println(it) }
        }

    }
}


fun main() {
    /**
     * Companion object이기 때문에 바로 접근이가능합니다
     * 플라스틱은(는) 10kg에 100
     * 유리은(는) 10kg에 150
     * 고철은(는) 10kg에 200 
     * 출력 
     */

    GarbageType8.print()
}

```

<br>

# 정리하기 
 
> Enum은 추상클래스로서 인터페이스를 구현할 수도 있고, 추상메소드를 지닐 수 있습니다. <br>
> 단순히 Flag 역할과 상수를 담는 그릇이 아닌 파워풀한 Kotlin Enum을 사용해보시면 좋을 것 같습니다 (^~^)b 

 첫 글로 최근 프로젝트에서 Enum을 많이 써서 Enum을 썼더니 생각보다 시간이 많이들어서 <br>
어린이날이 다 날라갔네요.. ㅠㅠ... 다들 코로나 조심하세요~! <br>
피드백은 언제나 환영입니다! __<mark>댓글 또는 메일로 주니어 개발자 지도 부탁드립니다 (__) 꾸벅</mark>__

#### [전체 소스 코드](https://github.com/banziha104/blogsample/tree/master/enumsample/src) 주소입니다.  
