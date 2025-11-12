#!/bin/bash

PROJECT_NAME="UPiL-Language"
ROOT_DIR="$PWD/$PROJECT_NAME"

echo "🚀 Membuat project UPiL di $ROOT_DIR..."

# Buat root directory
mkdir -p "$ROOT_DIR"
cd "$ROOT_DIR"

# Struktur folder
mkdir -p src/main/kotlin/org/upl/{lexer,parser,interpreter,runtime,android,cli}
mkdir -p src/main/resources/examples
mkdir -p src/test/kotlin
mkdir -p android-app/app/src
mkdir -p docs

# File build.gradle.kts
cat > build.gradle.kts <<'EOL'
plugins {
    kotlin("jvm") version "1.9.0"
    application
}

group = "org.upl"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
}

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:1.7.3")
    implementation("com.google.code.gson:gson:2.10.1")
    testImplementation("org.jetbrains.kotlin:kotlin-test")
    testImplementation("org.junit.jupiter:junit-jupiter:5.9.2")
}

application {
    mainClass.set("org.upl.MainKt")
}

tasks.test {
    useJUnitPlatform()
}
EOL

# File settings.gradle.kts
cat > settings.gradle.kts <<'EOL'
rootProject.name = "UPiL-Language"
EOL

# File gradle.properties
cat > gradle.properties <<'EOL'
kotlin.code.style=official
EOL

# Wrapper Gradle
echo "📦 Inisialisasi Gradle Wrapper..."
gradle wrapper --gradle-version 8.4

# File Main.kt
cat > src/main/kotlin/org/upl/Main.kt <<'EOL'
package org.upl

import org.upl.lexer.Lexer
import org.upl.parser.Parser
import org.upl.interpreter.Interpreter

fun main() {
    println("=== UPiL Interpreter v1.0 ===")
    println("Ukong Programming Language")
    println()

    val interpreter = Interpreter()
    val sampleCode = """
        cetak("Halo dari UPiL!")
        nama = "Ukong"
        cetak("Namaku:", nama)
    """.trimIndent()

    try {
        val lexer = Lexer(sampleCode)
        val tokens = lexer.tokenize()

        println("Tokens:")
        tokens.forEach { println(it) }

        val parser = Parser(tokens)
        val ast = parser.parse()

        println("\nExecuting...")
        interpreter.interpret(ast)

    } catch (e: Exception) {
        println("Error: ${e.message}")
    }
}
EOL

# File Token.kt
cat > src/main/kotlin/org/upl/lexer/Token.kt <<'EOL'
package org.upl.lexer

enum class TokenType {
    STRING, NUMBER, BOOLEAN,
    CETAK, JIKA, LAINNYA, ULANGI, KALI, SELAMA,
    FUNGSI, KEMBALIKAN, MASUKKAN, BILANGAN,
    PLUS, MINUS, MULTIPLY, DIVIDE,
    EQUALS, NOT_EQUALS, GREATER, LESS,
    LPAREN, RPAREN, LBRACE, RBRACE,
    COLON, COMMA, NEWLINE,
    IDENTIFIER,
    EOF
}

data class Token(val type: TokenType, val value: String, val line: Int)
EOL

# File Lexer.kt
cat > src/main/kotlin/org/upl/lexer/Lexer.kt <<'EOL'
package org.upl.lexer

class Lexer(private val input: String) {
    private var pos = 0
    private var line = 1

    private val keywords = mapOf(
        "cetak" to TokenType.CETAK,
        "jika" to TokenType.JIKA,
        "lainnya" to TokenType.LAINNYA,
        "ulangi" to TokenType.ULANGI,
        "kali" to TokenType.KALI,
        "selama" to TokenType.SELAMA,
        "fungsi" to TokenType.FUNGSI,
        "kembalikan" to TokenType.KEMBALIKAN,
        "masukkan" to TokenType.MASUKKAN,
        "bilangan" to TokenType.BILANGAN,
        "benar" to TokenType.BOOLEAN,
        "salah" to TokenType.BOOLEAN
    )

    fun tokenize(): List<Token> {
        val tokens = mutableListOf<Token>()

        while (pos < input.length) {
            when {
                input[pos].isWhitespace() -> skipWhitespace()
                input[pos] == '\n' -> {
                    tokens.add(Token(TokenType.NEWLINE, "\\n", line))
                    line++
                    pos++
                }
                input[pos] == '"' -> tokens.add(readString())
                input[pos].isDigit() -> tokens.add(readNumber())
                input[pos].isLetter() -> tokens.add(readIdentifier())
                input[pos] == '=' -> {
                    tokens.add(Token(TokenType.EQUALS, "=", line))
                    pos++
                }
                input[pos] == '+' -> {
                    tokens.add(Token(TokenType.PLUS, "+", line))
                    pos++
                }
                input[pos] == '-' -> {
                    tokens.add(Token(TokenType.MINUS, "-", line))
                    pos++
                }
                input[pos] == '*' -> {
                    tokens.add(Token(TokenType.MULTIPLY, "*", line))
                    pos++
                }
                input[pos] == '/' -> {
                    tokens.add(Token(TokenType.DIVIDE, "/", line))
                    pos++
                }
                input[pos] == '(' -> {
                    tokens.add(Token(TokenType.LPAREN, "(", line))
                    pos++
                }
                input[pos] == ')' -> {
                    tokens.add(Token(TokenType.RPAREN, ")", line))
                    pos++
                }
                else -> pos++
            }
        }

        tokens.add(Token(TokenType.EOF, "", line))
        return tokens
    }

    private fun readString(): Token {
        pos++
        val start = pos
        while (pos < input.length && input[pos] != '"') pos++
        val value = input.substring(start, pos)
        pos++
        return Token(TokenType.STRING, value, line)
    }

    private fun readNumber(): Token {
        val start = pos
        while (pos < input.length && input[pos].isDigit()) pos++
        return Token(TokenType.NUMBER, input.substring(start, pos), line)
    }

    private fun readIdentifier(): Token {
        val start = pos
        while (pos < input.length && (input[pos].isLetterOrDigit() || input[pos] == '_')) pos++
        val value = input.substring(start, pos)
        val type = keywords[value] ?: TokenType.IDENTIFIER
        return Token(type, value, line)
    }

    private fun skipWhitespace() {
        while (pos < input.length && input[pos].isWhitespace() && input[pos] != '\n') pos++
    }
}
EOL

# File ASTNode.kt
cat > src/main/kotlin/org/upl/parser/ASTNode.kt <<'EOL'
package org.upl.parser

import org.upl.lexer.TokenType

sealed class ASTNode {
    data class Program(val statements: List<ASTNode>) : ASTNode()
    data class Print(val value: ASTNode) : ASTNode()
    data class Variable(val name: String, val value: ASTNode) : ASTNode()
    data class NumberLiteral(val value: Int) : ASTNode()
    data class StringLiteral(val value: String) : ASTNode()
    data class Identifier(val name: String) : ASTNode()
}
EOL

# File Parser.kt
cat > src/main/kotlin/org/upl/parser/Parser.kt <<'EOL'
package org.upl.parser

import org.upl.lexer.*

class Parser(private val tokens: List<Token>) {
    private var pos = 0

    fun parse(): ASTNode.Program {
        val statements = mutableListOf<ASTNode>()
        while (!isAtEnd()) {
            statements.add(parseStatement())
            skipNewlines()
        }
        return ASTNode.Program(statements)
    }

    private fun parseStatement(): ASTNode {
        return when (current().type) {
            TokenType.CETAK -> parsePrint()
            else -> parseAssignment()
        }
    }

    private fun parsePrint(): ASTNode.Print {
        consume(TokenType.CETAK)
        consume(TokenType.LPAREN)
        val value = parseExpression()
        consume(TokenType.RPAREN)
        return ASTNode.Print(value)
    }

    private fun parseAssignment(): ASTNode {
        val name = consume(TokenType.IDENTIFIER).value
        consume(TokenType.EQUALS)
        val value = parseExpression()
        return ASTNode.Variable(name, value)
    }

    private fun parseExpression(): ASTNode {
        return when (current().type) {
            TokenType.NUMBER -> {
                val value = consume(TokenType.NUMBER).value.toInt()
                ASTNode.NumberLiteral(value)
            }
            TokenType.STRING -> {
                val value = consume(TokenType.STRING).value
                ASTNode.StringLiteral(value)
            }
            else -> ASTNode.Identifier(consume(TokenType.IDENTIFIER).value)
        }
    }

    private fun current() = tokens[pos]
    private fun isAtEnd() = current().type == TokenType.EOF
    private fun consume(type: TokenType): Token {
        if (current().type != type) {
            throw RuntimeException("Expected $type but got ${current().type}")
        }
        return tokens[pos++]
    }

    private fun skipNewlines() {
        while (current().type == TokenType.NEWLINE) pos++
    }
}
EOL

# File Interpreter.kt
cat > src/main/kotlin/org/upl/interpreter/Interpreter.kt <<'EOL'
package org.upl.interpreter

import org.upl.parser.*

class Interpreter {
    private val variables = mutableMapOf<String, Any>()

    fun interpret(program: ASTNode.Program) {
        for (statement in program.statements) {
            execute(statement)
        }
    }

    private fun execute(node: ASTNode): Any? {
        return when (node) {
            is ASTNode.Print -> {
                val value = evaluate(node.value)
                println(value)
                value
            }
            is ASTNode.Variable -> {
                val value = evaluate(node.value)
                variables[node.name] = value!!
                value
            }
            else -> throw RuntimeException("Unknown node: $node")
        }
    }

    private fun evaluate(node: ASTNode): Any? {
        return when (node) {
            is ASTNode.NumberLiteral -> node.value
            is ASTNode.StringLiteral -> node.value
            is ASTNode.Identifier -> variables[node.name] ?: "undefined"
            else -> throw RuntimeException("Cannot evaluate: $node")
        }
    }
}
EOL

# File example1.upl
cat > src/main/resources/examples/example1.upl <<'EOL'
cetak("Halo dari UPiL!")
nama = "Ukong"
cetak("Namaku:", nama)
EOL

# File README.md
cat > README.md <<'EOL'
# UPiL - Ukong Programming Language

UPiL adalah bahasa pemrograman sederhana berbasis Kotlin dengan syntax dalam Bahasa Indonesia, dirancang untuk pemula dan pengguna Android.

## Fitur
- Sintaks dalam Bahasa Indonesia
- Dukungan Android (sensor, kamera, UI)
- Interpreter ringan
- Cocok untuk pemula

## Cara Run
```bash
./gradlew run
EOL
