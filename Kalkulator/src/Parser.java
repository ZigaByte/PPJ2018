import java.io.BufferedReader;
import java.io.IOException;
import java.io.StreamTokenizer;
import java.io.StringReader;

public class Parser {
    public static class Error extends Exception {
        public Error(String message) {
            super(message);
        }
    }

    public static Izraz parse(String s) throws IOException, Error {
        StreamTokenizer lexer = new StreamTokenizer(new BufferedReader(new StringReader(s)));
        lexer.resetSyntax();
        lexer.parseNumbers();
        lexer.ordinaryChar('-');
        lexer.wordChars('a', 'z');
        lexer.wordChars('A', 'Z');
        lexer.whitespaceChars(' ', ' ');
        return izraz(lexer);
    }

    // <izraz> ::= <aditivni> EOF
    public static Izraz izraz(StreamTokenizer lexer) throws IOException, Error {
        Izraz e = aditivni(lexer);
        if (lexer.nextToken() != StreamTokenizer.TT_EOF) {
            throw new Error("pričakoval EOF, dobil: " + lexer.toString());
        } else {
            return e;
        }
    }

    // <aditivni> ::= <multiplikativni> <aditivni'>
    public static Izraz aditivni(StreamTokenizer lexer) throws IOException, Error {
        Izraz e = multiplikativni(lexer);
        return aditivni(lexer, e);
    }

    // <aditivni'> ::= epsilon | + <multiplikativni> <aditivni'>
    public static Izraz aditivni(StreamTokenizer lexer, Izraz e1) throws IOException, Error {
        Izraz e2;
        switch (lexer.nextToken()) {
            case '+':
                // imamo še vsaj en člen, dodaj ga trenutnemu izrazu in nadaljuj
                e2 = multiplikativni(lexer);
                return aditivni(lexer, new Plus(e1, e2));
            case '-':
                // imamo še vsaj en člen, dodaj ga trenutnemu izrazu in nadaljuj
                e2 = multiplikativni(lexer);
                return aditivni(lexer, new Minus(e1, e2));
            default:
                // prišli smo do konca, vrni zgrajen izraz
                lexer.pushBack();
                return e1;
        }
    }

    // <multiplikativni> ::= <nasprotni> <multiplikativni'>
    public static Izraz multiplikativni(StreamTokenizer lexer) throws IOException, Error {
        Izraz e = nasprotni(lexer);
        return multiplikativni(lexer, e);
    }

    // <multiplikativni'> ::= epsilon | * <nasprotni> <multiplikativni'>
    public static Izraz multiplikativni(StreamTokenizer lexer, Izraz e1) throws IOException, Error {
        Izraz e2;
        switch (lexer.nextToken()) {
            case '*':
                // imamo še vsaj en člen, dodaj ga trenutnemu izrazu in nadaljuj
                e2 = nasprotni(lexer);
                return multiplikativni(lexer, new Krat(e1, e2));
            default:
                // prišli smo do konca, vrni zgrajen izraz
                lexer.pushBack();
                return e1;
        }
    }

    // <nasprotni> ::= - <nasprotni> | <potencni>
    public static Izraz nasprotni(StreamTokenizer lexer) throws IOException, Error {
        if (lexer.nextToken() == '-') {
            Izraz e = nasprotni(lexer);
            return new UnarniMinus(e);
        } else {
            lexer.pushBack();
            Izraz e = potencni(lexer);
            return e;
        }
    }
    
    // <potencni> ::= <osnovni> ^ <potencni>
    public static Izraz potencni(StreamTokenizer lexer) throws IOException, Error{
        Izraz e1 = osnovni(lexer);
        switch (lexer.nextToken()) {
            case '^':
                Izraz e2 = potencni(lexer);
                return new Potenca(e1, e2);
            default:
                lexer.pushBack();
                return e1;
        }
    }

    // <osnovni> ::= ( <aditivni> ) | <konstanta> | <spremenljivka>
    public static Izraz osnovni(StreamTokenizer lexer) throws IOException, Error {
        switch (lexer.nextToken()) {
            case '(':
                Izraz e = aditivni(lexer);
                if (lexer.nextToken() != ')') {
                    throw new Error("pričakoval ')', dobil " + lexer.toString());
                } else {
                    return e;
                }
            case StreamTokenizer.TT_NUMBER:
                lexer.pushBack();
                return konstanta(lexer);
            case StreamTokenizer.TT_WORD:
                lexer.pushBack();
                return spremenljivka(lexer);
            default:
                lexer.pushBack();
                throw new Error("pričakoval osnovni izraz, dobil " + lexer.toString());
        }
    }

    // <konstanta> ::= <float>
    public static Izraz konstanta(StreamTokenizer lexer) throws IOException, Error {
        if (lexer.nextToken() == StreamTokenizer.TT_NUMBER) {
            return new Konstanta(lexer.nval);
        } else {
            lexer.pushBack();
            throw new Error("pričakoval konstanto, dobil " + lexer.toString());
        }
    }

    // <spremenljivka> ::= [a-zA-Z]+
    public static Izraz spremenljivka(StreamTokenizer lexer) throws IOException, Error {
        if (lexer.nextToken() == StreamTokenizer.TT_WORD) {
            return new Spremenljivka(lexer.sval);
        } else {
            lexer.pushBack();
            throw new Error("pričakoval spremenljivko, dobil " + lexer.toString());
        }
    }
}
