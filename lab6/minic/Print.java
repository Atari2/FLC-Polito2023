public class Print extends Instruction {
    Identifier id;
    public Print(Identifier id) {
        super(Type.Print);
        this.id = id;
    }

    @Override
    public String toString() {
        return "PRINT " + id.toString();
    }
}
