%%
%class SchemeLexer
%standalone
%line
%column

LineTerminator=\r|\n|\r\n
InputCharacter=[^\r\n]
WhiteSpace={LineTerminator}|[\s\t\f]
Comment=;{identifier}*|;{WhiteSpace}{identifier}*
empty =[]
operator=["+"|"-"|"!"|"$"|"%"|"&"|"*"|"/"|":"|"<"|"="|">"|"?"|"~"|"_"|"."]
paranthesis=[(|)|[|]]
syntatic_keyword={expression_keyword}|"else"|"=>"|"define"|"unquote"|"unquote-splicing"
expression_keyword="quote"|"lambda"|"if"|"set!"|"begin"|"cond"|"and"|"or"|"case"|"let"
|"let*"|"letrec"|"do"|"delay"|"quasiquote"


/*Programs*/ 

program = {form}*
form = {definition}|{expression}


/*Definitions*/ 

definition={variable_definition}|{syntax_definition}|("begin"{definition}*)|("let-syntax"({syntax_binding}*){definition}*)|("letrec-syntax"({syntax_binding}*){definition}*)|{derived_definition}
variable_definition=("define"{variable}{expression})|("define"({variable}{variable}*){body})|("define"({variable}{variable}*.{variable}){body})
variable={identifier}
body={definition}*{expression}+
syntax_definition=("define-syntax"{keyword}{transformer_expression})
keyword={identifier}
syntax_binding=({keyword}{transformer_expression})


/*Expressions*/ 

expression={constant}|{variable}|("quote"{datum})|'{datum}|("lambda"{formals}{body})|("if"{expression}{expression}{expression})|("if"{expression}{expression})|("set!"{variable}{expression})|{application}|("let-syntax"({syntax_binding}*){expression}+)|("letrec-syntax"({syntax_binding}*){expression}+)|{derived_expression}
constant={boolean}|{number}|{character}|{string}
formals={variable}|({variable}*)|({variable}+.{variable})
application=({expression}{expression}*)


/*Identifiers*/ 

identifier={initial}{subsequent}*|{operator}
initial={letter}|"!"|"$"|"%"|"&"|"*"|"/"|":"|"<"|"="|">"|"?"|"~"|"_"|"^"|"#"
subsequent={initial}|{digit}|\.|\+|\-
letter=[a-zA-Z]
digit=[0-9]*


/*Data*/ 

datum={boolean}|{number}|{character}|{string}|{symbol}|{list}|{vector}
boolean=#t|#f|T|F
number={num2}|{num8}|{num10}|{num16}
character=#\\[a-zA-Z0-9]|#\\{special_initial}|#\\n|#\\""
string="{string_character}*"
string_character=\"|"\\"
symbol={identifier}
list=({datum}*)|({datum}+.{datum})|{abbreviation}
abbreviation='{datum}|`{datum}|,{datum}|,@{datum}
vector=#({datum}*)


/*Numbers*/ //radixes: 2, 8, 10, and 16, with 10 the default

//Base 2
num2={prefix2}{complex2}
complex2={real2}|{real2}@{real2}|{real2}+{imag2}|{real2}\-{imag2}|\+{imag2}|\-{imag2}
imag2=i|{ureal2}i
real2={sign}{ureal2}
ureal2={uinteger2}|{uinteger2}"/"{uinteger2}|{decimal2}
uinteger2={digit2}+#*
prefix2={radix2}{exactness}|{exactness}{radix2}
decimal2={uinteger2}{exponent}|.{digit2}+#*{suffix}|{digit2}+.{digit}*#*{suffix}|{digit}+#+.#*{suffix}

//Base 8 
num8={prefix8}{complex8}
complex2={real8}|{real8}@{real8}|{real8}+{imag8}|{real8}\-{imag8}|\+{imag8}|\-{imag8}
imag8=i|{ureal8}i
real8={sign}{ureal8}
ureal8={uinteger8}|{uinteger8}"/"{uinteger8}|{decimal8}
uinteger8={digit8}+#*
prefix8={radix8}{exactness}|{exactness}{radix8}
decimal8={uinteger8}{exponent}|.{digit8}+#*{suffix}|{digit8}+.{digit}*#*{suffix}|{digit}+#+.#*{suffix}

//Base 10
num10={prefix10}{complex10}
complex10={real10}|{real10}@{real10}|{real10}+{imag10}|{real10}\-{imag10}|\+{imag10}|\-{imag10}
imag10=i|{ureal10}i
real10={sign}{ureal10}
ureal10={uinteger10}|{uinteger10}"/"{uinteger10}|{decimal10}
uinteger10={digit10}+#*
prefix10={radix10}{exactness}|{exactness}{radix10}
decimal10={uinteger10}{exponent}|.{digit10}+#*{suffix}|{digit10}+.{digit}*#*{suffix}|{digit}+#+.#*{suffix}

//Base 16
num16={prefix16}{complex16}
complex16={real10}|{real16}@{real16}|{real16}+{imag16}|{real16}\-{imag16}|\+{imag16}|\-{imag16}
imag16=i|{ureal16}i
real16={sign}{ureal16}
ureal16={uinteger16}|{uinteger16}"/"{uinteger16}|{decimal16}
uinteger16={digit16}+#*
prefix16={radix16}{exactness}|{exactness}{radix16}
decimal16={uinteger16}{exponent}|.{digit16}+#*{suffix}|{digit16}+.{digit}*#*{suffix}|{digit}+#+.#*{suffix}

suffix={empty}|{exponent}
exponent={exponent}{sign}{digit}+
exponentmarker=e|s|f|d|l
sign={empty}|\+|-
exactness={empty}|#i|#e
radix2=#b
radix8=#o
radix10={empty}|#d
radix16=#x
digit2=0|1
digit8=[0-7]
digit10={digit}
digit16={digit}|a|b|c|d|e|f

%%

<YYINITIAL> {

	{WhiteSpace} {
      System.out.println("WhiteSpace: \""+yytext()+"\" at line "+yyline);
	}
	
	{operator} {
      System.out.println("Operator: \""+yytext()+"\" at line "+yyline);
	}
	{syntatic_keyword} {
      System.out.println("Keyword: \""+yytext()+"\" at line "+yyline);
	}

	{identifier} {
    System.out.println("Identifier: \""+yytext()+"\" at line " + yyline);
	}
  
	{digit} {
      System.out.println("Number: \""+yytext()+"\" at line " + yyline);
	}  

	{boolean} {System.out.println("Keyword: boolean");}
		  
	"(" {System.out.println("Left Parenthesis: " + yytext());}
	")" {System.out.println("Right Parenthesis: " + yytext());}
	"[" {System.out.println("Left Bracket: " + yytext());}
	"]" {System.out.println("Right Bracket: " + yytext());}
	
	{Comment} {
      System.out.println("Comment: \""+yytext()+"\" at line "+yyline);
	}	
 
 }