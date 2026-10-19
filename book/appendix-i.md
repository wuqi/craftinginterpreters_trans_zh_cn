这里是 Lox 的完整文法。介绍语言各个部分的那些章节里都给出了相应的文法规则，而这里把它们汇总
到一处。

## 句法文法

句法文法用来把线性的词法单元序列解析成层层嵌套的语法树结构。它从第一条能匹配整个 Lox
程序（或单条 REPL 输入）的规则开始。

```ebnf
program        → declaration* EOF ;
```

### 声明

一个程序就是一串声明；声明是那些会绑定新标识符的语句，或者任何其他类型的语句。

```ebnf
declaration    → classDecl
               | funDecl
               | varDecl
               | statement ;

classDecl      → "class" IDENTIFIER ( "<" IDENTIFIER )?
                 "{" function* "}" ;
funDecl        → "fun" function ;
varDecl        → "var" IDENTIFIER ( "=" expression )? ";" ;
```

### 语句

剩下的语句规则会产生副作用，但不引入绑定。

```ebnf
statement      → exprStmt
               | forStmt
               | ifStmt
               | printStmt
               | returnStmt
               | whileStmt
               | block ;

exprStmt       → expression ";" ;
forStmt        → "for" "(" ( varDecl | exprStmt | ";" )
                           expression? ";"
                           expression? ")" statement ;
ifStmt         → "if" "(" expression ")" statement
                 ( "else" statement )? ;
printStmt      → "print" expression ";" ;
returnStmt     → "return" expression? ";" ;
whileStmt      → "while" "(" expression ")" statement ;
block          → "{" declaration* "}" ;
```

注意，`block` 是一条语句规则，但它也作为非终结符用在另外几条规则里，比如函数体之类的地方。

### 表达式

表达式产生值。Lox 有许多一元和二元运算符，优先级各不相同。有些语言的文法不把优先级关系
直接写进去，而是在别处另外说明。这里我们给每个优先级各用一条规则，把这件事写明白。

```ebnf
expression     → assignment ;

assignment     → ( call "." )? IDENTIFIER "=" assignment
               | logic_or ;

logic_or       → logic_and ( "or" logic_and )* ;
logic_and      → equality ( "and" equality )* ;
equality       → comparison ( ( "!=" | "==" ) comparison )* ;
comparison     → term ( ( ">" | ">=" | "<" | "<=" ) term )* ;
term           → factor ( ( "-" | "+" ) factor )* ;
factor         → unary ( ( "/" | "*" ) unary )* ;

unary          → ( "!" | "-" ) unary | call ;
call           → primary ( "(" arguments? ")" | "." IDENTIFIER )* ;
primary        → "true" | "false" | "nil" | "this"
               | NUMBER | STRING | IDENTIFIER | "(" expression ")"
               | "super" "." IDENTIFIER ;
```

### 辅助规则

为了让上面的规则干净一点，有一部分文法被拆成了几条复用的辅助规则。

```ebnf
function       → IDENTIFIER "(" parameters? ")" block ;
parameters     → IDENTIFIER ( "," IDENTIFIER )* ;
arguments      → expression ( "," expression )* ;
```

## 词法文法

词法文法由扫描器用来把字符合并成词法单元。如果说句法文法是[上下文无关的][context free]，
那么词法文法就是[正则的][regular]——注意那里没有任何递归规则。

[context free]: https://en.wikipedia.org/wiki/Context-free_grammar
[regular]: https://en.wikipedia.org/wiki/Regular_grammar

```ebnf
NUMBER         → DIGIT+ ( "." DIGIT+ )? ;
STRING         → "\"" <any char except "\"">* "\"" ;
IDENTIFIER     → ALPHA ( ALPHA | DIGIT )* ;
ALPHA          → "a" ... "z" | "A" ... "Z" | "_" ;
DIGIT          → "0" ... "9" ;
```
