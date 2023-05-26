import java_cup.runtime.Symbol;

import java.util.ArrayList;

public class Variable {
    public String name;
    public ArrayList<Integer> sizes;

    public Variable(String name, ArrayList<Integer> sizes) {
        this.name = name;
        this.sizes = sizes;
    }

    private String sizeString() {
        StringBuilder ret = new StringBuilder();
        for (int s : sizes) {
            ret.append("[").append(s).append("]");
        }
        return ret.toString();
    }

    public String getName() { return name; }
    public Integer getSize() { return sizes.size() > 0 ? sizes.get(0) : 0; }

    @Override
    public String toString() {
        return name + sizeString();
    }
}
