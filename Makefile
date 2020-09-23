JAVA=java
JAVAC=javac
JFLEX=$(JAVA) -jar jflex-1.8.2/lib/jflex-full-1.8.2.jar
CUPJAR=./java-cup-11b.jar
CUP=$(JAVA) -jar $(CUPJAR)
CP=.:$(CUPJAR)

default: run

.SUFFIXES: $(SUFFIXES) .class .java

.java.class:
		$(JAVAC) -cp $(CP) $*.java

FILE=    Lexer.java      parser.java    sym.java \
    LexerTest.java

run: basicTerminals.txt basicRegex.txt basicFails.txt \
		commentTest.txt advanced.txt advanced-invalid.txt

basicTerminals.txt: all
		$(JAVA) -cp $(CP) LexerTest basicTerminals.txt > basicTerminals-output.txt
		cat basicTerminals.txt
		cat -n basicTerminals-output.txt

basicRegex.txt: all
		$(JAVA) -cp $(CP) LexerTest basicRegex.txt > basicRegex-output.txt
		cat basicRegex.txt
		cat -n basicRegex-output.txt

basicFails.txt: all
		$(JAVA) -cp $(CP) LexerTest basicFails.txt > basicFails-output.txt
		cat basicFails.txt
		cat -n basicFails-output.txt

commentTest.txt: all
		$(JAVA) -cp $(CP) LexerTest commentTest.txt > commentTest-output.txt
		cat advanced.txt
		cat -n advanced-output.txt

advanced.txt: all
		$(JAVA) -cp $(CP) LexerTest advanced.txt > advanced-output.txt
		cat advanced.txt
		cat -n advanced-output.txt

advanced-invalid.txt: all
		$(JAVA) -cp $(CP) LexerTest advanced-invalid.txt > advanced-invalid-output.txt
		cat advanced-invalid.txt
		cat -n advanced-invalid-output.txt

all: Lexer.java parser.java $(FILE:java=class)

clean:
		rm -f *.class *~ *.bak Lexer.java parser.java sym.java

Lexer.java: grammar.jflex
		$(JFLEX) grammar.jflex

parser.java: tokens.cup
		$(CUP) -interface < tokens.cup

parserD.java: tokens.cup
		$(CUP) -interface -dump < tokens.cup
