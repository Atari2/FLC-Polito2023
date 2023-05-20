public class LabelDispenser {
    static int labelNum = 1;

    static Label getNewLabel() {
        return new Label(labelNum++);
    }
}
