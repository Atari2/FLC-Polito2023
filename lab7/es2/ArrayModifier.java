public class ArrayModifier implements Modifier {
    int size;

    @Override
    public String makeString() {
        return "array(" + size + ",";
    }

    public ArrayModifier(int size) {
        this.size = size;
    }
}
