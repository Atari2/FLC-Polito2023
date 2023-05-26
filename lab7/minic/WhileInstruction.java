public class WhileInstruction extends Instruction {
    Expression expr;
    Instruction stmt;
    public WhileInstruction(Expression expr, Instruction stmt) {
        super(Type.Jump);
        this.expr = expr;
        this.stmt = stmt;
    }

    @Override
    public String toString() {
        Label wl = LabelDispenser.getNewLabel();
        Label el = LabelDispenser.getNewLabel();
        return wl + expr.toString() + "\nGOTOF " + el.name() + "\n" + stmt.toString() + "\nGOTO " + wl.name() + "\n" + el;
    }
}
