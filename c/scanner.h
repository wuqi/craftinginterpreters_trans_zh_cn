//> Scanning on Demand scanner-h
#ifndef clox_scanner_h
#define clox_scanner_h
//> token-type

typedef enum {
// 单字符词法单元。
  TOKEN_LEFT_PAREN, TOKEN_RIGHT_PAREN,
  TOKEN_LEFT_BRACE, TOKEN_RIGHT_BRACE,
  TOKEN_COMMA, TOKEN_DOT, TOKEN_MINUS, TOKEN_PLUS,
  TOKEN_SEMICOLON, TOKEN_SLASH, TOKEN_STAR,
// 一或两个字符的词法单元。
  TOKEN_BANG, TOKEN_BANG_EQUAL,
  TOKEN_EQUAL, TOKEN_EQUAL_EQUAL,
  TOKEN_GREATER, TOKEN_GREATER_EQUAL,
  TOKEN_LESS, TOKEN_LESS_EQUAL,
// 字面量。
  TOKEN_IDENTIFIER, TOKEN_STRING, TOKEN_NUMBER,
// 关键字。
  TOKEN_AND, TOKEN_CLASS, TOKEN_ELSE, TOKEN_FALSE,
  TOKEN_FOR, TOKEN_FUN, TOKEN_IF, TOKEN_NIL, TOKEN_OR,
  TOKEN_PRINT, TOKEN_RETURN, TOKEN_SUPER, TOKEN_THIS,
  TOKEN_TRUE, TOKEN_VAR, TOKEN_WHILE,

  TOKEN_ERROR, TOKEN_EOF
} TokenType;
//< token-type
//> token-struct

typedef struct {
  TokenType type;
  const char* start;
  int length;
  int line;
} Token;
//< token-struct

void initScanner(const char* source);
//> scan-token-h
Token scanToken();
//< scan-token-h

#endif
