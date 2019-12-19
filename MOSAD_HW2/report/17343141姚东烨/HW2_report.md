# HW2
------
### 实验目的

1. 学习掌握Objective-C愈发，掌握基础字符串操作。
2. OO知识——多态与继承



### 实验内容

给定三个用户张三，李四，王五。

给定四种语言英语、日语、德语、西班牙语。

实现场景输出（log形式即可）：随机选择一个用户和一种语言学习，从**当前日期**开始，随机产生时间进行学习，输出学习进度直至学习完毕。每个语言共8个tour，每个tour共4个unit，每次学习一个unit。

要求：

- 随机选定人名、语言后，一次性输出所有结果。

- 随机事件指的是每次随机1-5天，每次学习时间在前一次的基础上加上刚刚随机出的天数。
- 需要用到多态。

输出例子：张三 某年某月某日 学习日语 tour 1 unit 1。

![example2[1]](https://gitee.com/yaody7/pics/blob/master/example2%5B1%5D.png)



### 实验过程

> ##### 1. 查询Objective-C使用教程，了解类、数组、字符串以及NSDate等的使用
>
> > **类：**
> >
> > 在.h文件中声明，利用**@interface**
> >
> > 在.m文件中进行实现，利用**@implementation**
> >
> > 成员变量使用**{}**括住声明
> >
> > 成员函数使用 **-（type）函数名**进行声明
>
> > **数组：**
> >
> > 使用NSArray。利用arrayWithObjects的api可以直接往数组里面放入指针。
> >
> > 如：`NSArray *per=[NSArray arrayWithObjects:z,l,w, nil];`
>
> >**字符串：**
> >
> >使用NSString。
> >
> >使用方法：
> >
> >`NSString *name;`
> >
> >`    name=@"张三";`
> >
> >注意在字符串前需要加上**@**
>
> > **NSDate：**
> >
> > 使用到的api：
> >
> > - NSDateFomatter：创建日期格式
> > - dateWithTimeInterval：计算时间间隔
> > - sinceDate：距离某个时间点
>
> > **函数调用：**[实例 函数名]
>
> > **创建实例：**[类 new]

> ##### 2. 创建Language类，作为多种语言的基类，并创建子类（举英语作为例子）
>
> > `@interface Language: NSObject`
> > `{`
> >    ` NSString *mytype;`
> > `}`
> > `-(NSString *)mytype;`
> > `@end`
> >
> > `@interface English: Language`
> > `-(NSString *)mytype;`
> > `@end`

> ##### 3. 创建Person类，作为多个人的基类，并创建子类（举张三作为例子）
>
> > `@interface Person: NSObject`
> > `{`
> >    ` NSString *name;`
> > `}`
> > `-(NSString *)name;`
> > `@end`
> >
> > `@interface zhangsan: Person`
> > `-(NSString *)name;`
> > `@end`

> ##### 4. 实现类，即实现多态过程
>
> > 举语言作为例子：
> >
> > `@implementation Language`
> >
> > `-(NSString*)mytype`
> > `{`
> >     `return mytype;`
> > `}`
> > `@end`
> >
> > `@implementation English`
> >
> > `-(NSString*)mytype`
> > `{`
> >    ` mytype=@"英语";`
> >     `return mytype;`
> > `}`
> > `@end`
> >
> > **说明：**每一个子类重写mytype函数，做的事情就是更改mytype成员变量并返回

> ##### 5. 创建实例，并将实例装入数组中
>
> > `zhangsan *z =[zhangsan new];`
> >
> > `NSArray *per=[NSArray arrayWithObject:z,l,w,nil];`

> ##### 6.使用arc4random生成随机数，并通过介绍的NSDate等api生成日期，使用两重循环，并利用NSLog进行输出。
>
> > `NSLog(@"%@ %@ 学习%@ tour %zd unit %zd",[per[perposition] name],dateString,[lan[lanposition] mytype],i,j);`



## 实验结果

![1567477527(1)](https://gitee.com/yaody7/pics/blob/master/1567477527(1).png)



## 实验心得

​		本次实验，我开始正式学习Objective-C。本次作业主要考察我们类的知识、字符串使用和一些其他的小Objective-C的使用。通过PPT和网络查询，我学到了许多Objective-C独有的表达方式。比如在调用成员函数的时候，在我们之前使用C时，我们会用**对象.函数名**来调用函数，而Objective-C则使用**[对象，函数名]**来进行调用。不仅如此，就连简单的创建实例，Objective-C也和C有着很大的不同。在课程学习之初，老师告诉我们Objective-C是C的严格超集，我还打算着实在不会就直接用C写吧。但是在真正做作业时，还是希望自己能多掌握一门语言。所以只能够在课件和网络查询中苦苦摸索。希望在接下来的学习中能继续钻研Objective-C，争取充分掌握这门语言，希望自己在之后的实验中能做的更好。