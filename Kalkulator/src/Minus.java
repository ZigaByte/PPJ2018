import java.util.Map;

public class Minus extends Izraz{
	private Izraz e1;
	private Izraz e2;
	
	public Minus(Izraz e1, Izraz e2) {
		super();
		this.e1 = e1;
		this.e2 = e2;
	}
	
	@Override
	public Izraz poenostavi() {
		e1 = e1.poenostavi();
		e2 = e2.poenostavi();
		if(e1 instanceof Konstanta && e2 instanceof Konstanta)
			return new Konstanta(eval(null));
		return this;
	}

	@Override
	public Double eval(Map<String, Double> env) {
		return e1.eval(env) - e2.eval(env);
	}

	@Override
	public String toString() {
		return "(- " + e1 + " " + e2 + ")";
	}
	
}
