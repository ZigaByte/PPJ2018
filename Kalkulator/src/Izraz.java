import java.util.Map;

public abstract class Izraz {
	public abstract Double eval(Map<String, Double> env);
	
	public abstract Izraz poenostavi();
	
	public abstract String toString();
}
