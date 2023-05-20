public class Assignment extends Instruction {
    Identifier id;
    Expression expr;

    public Assignment(Identifier id, Expression expr) {
        super(Type.Assignment);
        this.id = id;
        this.expr = expr;
    }
    public Assignment(Identifier id) {
        super(Type.Assignment);
        this.id = id;
        this.expr = null;
    }

    @Override
    public String toString() {
        if (expr != null) {
            return expr + "\nASS " + id.toString();
        } else {
            return "ASS " + id.toString();
        }
    }
}
