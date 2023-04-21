package csymbol;

public enum CType {
    INT,
    DOUBLE;

    public String toString() {
        return switch (this) {
            case INT -> "int";
            case DOUBLE -> "double";
            default -> "unknown";
        };
    }
}