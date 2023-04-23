package csymbol;

public enum CType {
    INT,
    DOUBLE;

    public String toString() {
        switch (this) {
            case INT: return "int";
            case DOUBLE: return "double";
            default: return "unknown";
        }
    }
}