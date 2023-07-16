import java.util.ArrayList;

class CompareExpr {
    public Integer value;
    public ArrayList<Compare> comps;
    public CompareExpr(Integer value, ArrayList<Compare> comps) {
        this.value = value;
        this.comps = comps;
    }
}