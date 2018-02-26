import java.io.IOException;
import java.util.HashMap;
import java.util.NoSuchElementException;
import java.util.Scanner;

public class Kalkulator {
	public static void main(String[] args) throws IOException {
		HashMap<String, Double> env = new HashMap<String, Double>();
		env.put("x", 42.0);
		env.put("y", 42.0);
		
		Scanner stdin = new Scanner(System.in);
		while (true) {
			try {
				System.out.print("Izraz: ");
				String s = stdin.nextLine();
				if (s.isEmpty())
					break;
				Izraz e = Parser.parse(s);
				System.out.println("Izpis: " + e);
				Izraz p = e.poenostavi();
				System.out.println("Poenostavljen: " + p);
				
				Double v = e.eval(env);
				System.out.println("Vrednost: " + v);
			} catch (Parser.Error e) {
				System.err.println(e.getMessage());
			} catch (NoSuchElementException e) {
				break;
			}
		}
		stdin.close();
	}
}
