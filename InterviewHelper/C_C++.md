<!-- TOC -->

- [一 常见关键字](#一-常见关键字)
    - [1.1 static](#11-static)
    - [1.2 const](#12-const)
        - [1.2.1 const修饰成员变量](#121-const修饰成员变量)
        - [1.2.2 const修饰函数参数](#122-const修饰函数参数)
        - [1.2.3 const修饰成员函数](#123-const修饰成员函数)
        - [1.2.4 const修饰函数返回值](#124-const修饰函数返回值)
    - [1.3 volatile](#13-volatile)
        - [1.3.1 volatile的作用](#131-volatile的作用)
        - [1.3.2 volatile指针](#132-volatile指针)
        - [1.3.3 多线程下的volatile](#133-多线程下的volatile)

<!-- /TOC -->

# 一 常见关键字

## 1.1 static



## 1.2 const

const 允许指定一个语义约束，编译器会强制实施这个约束，允许程序员告诉编译器某值是保持不变的。如果在编程中确实有某个值保持不变，就应该明确使用const，这样可以获得编译器的帮助。

### 1.2.1 const修饰成员变量

```C++
#include<iostream>
using namespace std;
int main(){
    int a1=3;                   //non-const data
    const int a2=a1;            //const data

    int * a3 = &a1;             //non-const data,non-const pointer
    const int * a4 = &a1;       //const data,non-const pointer
    int * const a5 = &a1;       //non-const data,const pointer
    int const * const a6 = &a1; //const data,const pointer
    const int * const a7 = &a1; //const data,const pointer

    return 0;
}
```

const修饰指针变量时：

 1. 只有一个const，如果const位于*左侧，表示指针所指数据是常量，不能通过解引用修改该数据；指针本身是变量，可以指向其他的内存单元。
 2. 只有一个const，如果const位于*右侧，表示指针本身是常量，不能指向其他内存地址；指针所指的数据可以通过解引用修改。
 3. 两个const，*左右各一个，表示指针和指针所指数据都不能修改。

### 1.2.2 const修饰函数参数

传递过来的参数在函数内不可以改变，与上面修饰变量时的性质一样。

```C++
void testModifyConst(const int _x) {
     _x=5;　　　//编译出错
}
```

### 1.2.3 const修饰成员函数

1. const修饰的成员函数不能修改任何的成员变量(mutable修饰的变量除外)
2. const成员函数不能调用非onst成员函数，因为非const成员函数可以会修改成员变量

```C++
#include <iostream>
using namespace std;
class Point{
    public :
    Point(int _x):x(_x){}

    void testConstFunction(int _x) const{

        //错误，在const成员函数中，不能修改任何类成员变量
        x=_x;

        //错误，const成员函数不能调用非onst成员函数，因为非const成员函数可以会修改成员变量
        modify_x(_x);
    }

    void modify_x(int _x){
        x=_x;
    }

    int x;
};
```

### 1.2.4 const修饰函数返回值

1) 指针传递

如果返回const data,non-const pointer，返回值也必须赋给const data,non-const pointer。因为指针指向的数据是常量不能修改。

```C++
const int * mallocA(){  //const data,non-const pointer
    int *a=new int(2);
    return a;
}

int main()
{
    const int *a = mallocA();
    //int *b = mallocA();  ///编译错误
    return 0;
}
```

2) 值传递

如果函数返回值采用“值传递方式”，由于函数会把返回值复制到外部临时的存储单元中，加const 修饰没有任何价值。所以，**对于值传递来说，加const没有太多意义**。

所以：

- **不要把函数int GetInt(void) 写成const int GetInt(void)**
- **不要把函数A GetA(void) 写成const A GetA(void)，其中A 为用户自定义的数据类型**

在编程中要尽可能多的使用const，这样可以获得编译器的帮助，以便写出健壮性的代码。

## 1.3 volatile

### 1.3.1 volatile的作用

volatile关键字是一种类型修饰符，用它声明的类型变量表示可以被某些编译器未知的因素更改，比如：操作系统、硬件或者其它线程等。由于访问寄存器的速度要快过RAM，所以编译器一般都会作减少存取外部RAM的优化。遇到这个关键字声明的变量，编译器对访问该变量的代码就不再进行优化，从而可以提供对特殊地址的稳定访问。**当要求使用 volatile 声明的变量的值的时候，系统总是重新从它所在的内存读取数据，即使它前面的指令刚刚从该处读取过数据。而且读取的数据立刻被保存**。

```C++
#include <stdio.h>
void main()
{
    int i = 10;
    int a = i;
    printf("i = %d", a);
    // 下面汇编语句的作用就是改变内存中 i 的值
    // 但是又不让编译器知道
    __asm {
        mov dword ptr [ebp-4], 20h
    }

    int b = i;
    printf("i = %d", b);
}
```

然后，在 Debug 版本模式运行程序，输出结果如下：

    i = 10
    i = 32

在 Release 版本模式运行程序，输出结果如下：

    i = 10
    i = 10

输出的结果明显表明，Release 模式下，编译器对代码进行了优化，第二次没有输出正确的 i 值。把 i 的声明加上 volatile 关键字，在 Debug 和 Release 版本运行程序，输出为：

    i = 10
    i = 10

其实不只是“内嵌汇编操纵栈”这种方式属于编译无法识别的变量改变，另外更多的可能是多线程并发访问共享变量时，一个线程改变了变量的值，怎样让改变后的值对其它线程 visible。一般说来，volatile用在如下的几个地方：

1. **中断服务程序中修改的供其它程序检测的变量需要加volatile**
2. **多任务环境下各任务间共享的标志应该加volatile** 
3. **存储器映射的硬件寄存器通常也要加volatile说明，因为每次对它的读写都可能由不同意义**

### 1.3.2 volatile指针

和 const 修饰词类似，const 有常量指针和指针常量的说法，volatile 也有相应的概念：

- 修饰由指针指向的对象、数据是 const 或 volatile 的：

```C++
const char* cpch;
volatile char* vpch;
```

- 指针自身的值——一个代表地址的整数变量，是 const 或 volatile 的：

```C++
char* const pchc;
char* volatile pchv;
```

注意：

1. **可以把一个非volatile int赋给volatile int，但是不能把非volatile对象赋给一个volatile对象**
2. **除了基本类型外，对用户定义类型也可以用volatile类型进行修饰**
3. **C++中一个有volatile标识符的类只能访问它接口的子集，一个由类的实现者控制的子集。用户只能用const_cast来获得对类型接口的完全访问。此外，volatile向const一样会从类传递到它的成员**

### 1.3.3 多线程下的volatile

有些变量是用volatile关键字声明的。当两个线程都要用到某一个变量且该变量的值会被改变时，应该用volatile声明，该关键字的作用是防止优化编译器把变量从内存装入CPU寄存器中。如果变量被装入寄存器，那么两个线程有可能一个使用内存中的变量，一个使用寄存器中的变量，这会造成程序的错误执行。volatile的意思是让编译器每次操作该变量时一定要从内存中真正取出，而不是使用已经存在寄存器中的值，如下：

> volatile  BOOL  bStop  =  FALSE;

(1) 在一个线程中：

```C++
while(  !bStop  )  {  ...  }
bStop  =  FALSE;
return;
```

(2) 在另外一个线程中，要终止上面的线程循环：

```C++
bStop  =  TRUE;
while(  bStop  );  //等待上面的线程终止，如果bStop不使用volatile申明，那么这个循环将是一个死循环，因为bStop已经读取到了寄存器中，寄存器中bStop的值永远不会变成FALSE，加上volatile，程序在执行时，每次均从内存中读出bStop的值，就不会死循环了。
```
