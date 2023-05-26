public class Declaration extends Instruction {
    public enum Decltype {
        Int,
        Double
    }
    Variable var;
    Decltype decltype;
    private String decltypeToString() {
        switch (decltype) {
            case Double:
                return "DOUBLE";
            case Int:
                return "INT";
        }
        return "INVALID";
    }
    public Declaration(Variable var, Decltype decltype) {
        super(Type.Declaration);
        this.var = var;
        this.decltype = decltype;
    }

    public String getName() {
        return var.getName();
    }
    public Integer getSize() {
        return var.getSize();
    }

    public Decltype getType() {
        return decltype;
    }

    @Override
    public String toString() {
        return decltypeToString() + " " + var;
    }
}
