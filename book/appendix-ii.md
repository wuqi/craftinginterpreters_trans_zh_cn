为了让你长点见识，这里是[我们写的那个小脚本][generator]产出的代码——那个脚本用来自动生成
jlox 的语法树类。

[generator]: representing-code.html#给树做元编程

## 表达式

表达式是我们最先见到的语法树节点，在[《表示代码》][representing-code]里登场。主要的 Expr
类定义了访问者接口，用来分派到具体的表达式类型，并把其他表达式子类作为嵌套类装在里面。

^code expr

### 赋值表达式

变量赋值在[《语句与状态》][assignment]里登场。

^code expr-assign

### 二元表达式

二元运算符在[《表示代码》][representing-code]里登场。

^code expr-binary

### 调用表达式

函数调用表达式在[《函数》][function-calls]里登场。

^code expr-call

### Get 表达式

属性访问，也就是「get」表达式，在[《类》][properties-on-instances]里登场。

^code expr-get

### 分组表达式

用括号把表达式分组，在[《表示代码》][representing-code]里登场。

^code expr-grouping

### 字面量表达式

字面量值表达式在[《表示代码》][representing-code]里登场。

^code expr-literal

### 逻辑表达式

逻辑运算符 `and` 和 `or` 在[《控制流》][logical-operators]里登场。

^code expr-logical

### Set 表达式

属性赋值，也就是「set」表达式，在[《类》][properties-on-instances]里登场。

^code expr-set

### Super 表达式

`super` 表达式在[《继承》][calling-superclass-methods]里登场。

^code expr-super

### This 表达式

`this` 表达式在[《类》][classes-this]里登场。

^code expr-this

### 一元表达式

一元运算符在[《表示代码》][representing-code]里登场。

^code expr-unary

### 变量表达式

变量访问表达式在[《语句与状态》][variable-syntax]里登场。

^code expr-variable

## 语句

语句构成另一套独立的语法树节点层级。我们在[《语句与状态》][statements-and-state]里加上了
开头几个。

^code stmt

### 块语句

定义局部作用域的花括号块语句在[《语句与状态》][block-syntax-and-semantics]里登场。

^code stmt-block

### 类语句

类声明在——不出所料——[《类》][class-declarations]里登场。

^code stmt-class

### 表达式语句

表达式语句在[《语句与状态》][statements]里登场。

^code stmt-expression

### 函数语句

函数声明在——你猜对了——[《函数》][function-declarations]里登场。

^code stmt-function

### If 语句

`if` 语句在[《控制流》][conditional-execution]里登场。

^code stmt-if

### Print 语句

`print` 语句在[《语句与状态》][statements]里登场。

^code stmt-print

### Return 语句

你得先有个函数才能从中返回，所以 `return` 语句在[《函数》][return-statements]里登场。

^code stmt-return

### 变量语句

变量声明在[《语句与状态》][variable-syntax]里登场。

^code stmt-var

### While 语句

`while` 语句在[《控制流》][while-loops]里登场。

^code stmt-while

[representing-code]: representing-code.html
[assignment]: statements-and-state.html#赋值
[function-calls]: functions.html#函数调用
[properties-on-instances]: classes.html#实例上的属性
[logical-operators]: control-flow.html#逻辑运算符
[calling-superclass-methods]: inheritance.html#调用超类方法
[classes-this]: classes.html#this
[variable-syntax]: statements-and-state.html#变量的语法
[statements-and-state]: statements-and-state.html
[block-syntax-and-semantics]: statements-and-state.html#块的语法与语义
[class-declarations]: classes.html#类声明
[statements]: statements-and-state.html#语句
[function-declarations]: functions.html#函数声明
[conditional-execution]: control-flow.html#条件执行
[return-statements]: functions.html#return-语句
[while-loops]: control-flow.html#while-循环
