import java.util.Map;

public class UnarniMinus extends Izraz {
    private Izraz e;

    public UnarniMinus(Izraz e) {
        super();
        this.e = e;
    }
    
    @Override
    public Izraz poenostavi() {
    	e = e.poenostavi();
    	if(e instanceof Konstanta){
    		return new Konstanta(e.eval(null));
    	}
    	return this;
    }

    @Override
    public Double eval(Map<String, Double> env) {
        return -e.eval(env);
    }

    @Override
    public String toString() {
        return "(- " + e + ")";
    }
}
