public class IfInstruction extends Instruction {
    Expression expr;
    Instruction stmt;
    Instruction elsestmt;

    public IfInstruction(Expression expr, Instruction stmt) {
        super(Type.Jump);
        this.expr = expr;
        this.stmt = stmt;
    }
    public IfInstruction(Expression expr, Instruction stmt, Instruction elsestmt) {
        super(Type.Jump);
        this.expr = expr;
        this.stmt = stmt;
        this.elsestmt = elsestmt;
    }

    @Override
    public String toString() {
        Label l = LabelDispenser.getNewLabel();
        Label elsel = LabelDispenser.getNewLabel();
        if (elsestmt != null) {
            return expr.toString() + "\nGOTOF " + l.name() + "\n" + stmt.toString() + "GOTO " + elsel.name() + "\n" + l + elsestmt.toString();
        } else {
            return expr.toString() + "\nGOTOF " + l.name() + "\n" + stmt.toString() + l;
        }
    }
}
