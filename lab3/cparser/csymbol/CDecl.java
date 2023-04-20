package csymbol;

public class CDecl {
    CType type;
    String name;
    Boolean isArray;
    int size;

    public CDecl(CType type, String name, Integer size) {
        this.type = type;
        this.name = name;
        this.isArray = true;
        this.size = size;
    }

    public CDecl(CType type, String name) {
        this.type = type;
        this.name = name;
        this.isArray = false;
        this.size = 0;
    }

    public CType getType() {
        return type;
    }

    public String toString() {
        return type + " " + name + (isArray ? "[" + Integer.toString(size) + "]" : "");
    }
}
