public class Label {
    int num;
    public Label(int num) {
        this.num = num;
    }
    public String name() {
        return "L" + num;
    }
    @Override
    public String toString() {
        return "L" + num + ": ";
    }
}
