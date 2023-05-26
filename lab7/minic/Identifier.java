public class Identifier {
    String name;
    Object inner; // may be String or Integer

    public Identifier(String name) {
        this.name = name;
        this.inner = null;
    }

    public Identifier(String name, String inner) {
        this.name = name;
        this.inner = inner;
    }

    public Identifier(String name, Integer index) {
        this.name = name;
        this.inner = index;
    }

    public String getName() {
        return name;
    }

    @Override
    public String toString() {
        if (inner != null) {
            return name + "[" + inner + "]";
        } else {
            return name;
        }
    }
}
