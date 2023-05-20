import java.util.ArrayList;

public class Expression extends Instruction {
    public enum Operation {
        And,
        Or,
        Not,
        Comparison,
        Min,
        Maj,
        MinEq,
        MajEq,
        Plus,
        Minus,
        Mult,
        Div,
        Id,
        Integer,
        Double,
        Parens
    }
    Expression lhs;
    Expression rhs;
    Operation op;

    Object value;

    public Expression(Expression lhs, Expression rhs, Operation op) {
        super(Type.Expression);
        this.lhs = lhs;
        this.rhs = rhs;
        this.op = op;
    }
    public Expression(Expression rhs, Operation op) {
        super(Type.Expression);
        this.lhs = null;
        this.rhs = rhs;
        this.op = op;
    }
    public Expression(Expression obj) {
        super(Type.Expression);
        this.value = obj;
        this.op = Operation.Parens;
    }
    public Expression(Identifier id) {
        super(Type.Expression);
        this.value = id;
        this.op = Operation.Id;
    }
    public Expression(Integer val) {
        super(Type.Expression);
        this.value = val;
        this.op = Operation.Integer;
    }
    public Expression(Double val) {
        super(Type.Expression);
        this.value = val;
        this.op = Operation.Double;
    }

    String switchOnExpr() {
        switch (this.op) {
            case And:
                return this.lhs.innerToString() + " " + this.rhs.innerToString() + " &&";
            case Or:
                return this.lhs.innerToString() + " " + this.rhs.innerToString() + " ||";
            case Not:
                return this.rhs.innerToString() + " !";
            case Comparison:
                return this.lhs.innerToString() + " " + this.rhs.innerToString() + " ==";
            case Min:
                return this.lhs.innerToString() + " " + this.rhs.innerToString() + " <";
            case Maj:
                return this.lhs.innerToString() + " " + this.rhs.innerToString() + " >";
            case MinEq:
                return this.lhs.innerToString() + " " + this.rhs.innerToString() + " <=";
            case MajEq:
                return this.lhs.innerToString() + " " + this.rhs.innerToString() + " >=";
            case Plus:
                return this.lhs.innerToString() + " " + this.rhs.innerToString() + " +";
            case Minus:
                return this.lhs.innerToString() + " " + this.rhs.innerToString() + " -";
            case Mult:
                return this.lhs.innerToString() + " " + this.rhs.innerToString() + " *";
            case Div:
                return this.lhs.innerToString() + " " + this.rhs.innerToString() + " /";
            case Id:
            case Integer:
            case Parens:
            case Double:
                return this.value.toString();
        }
        return "INVALID EXPRESSION";
    }

    public String innerToString() {
        return switchOnExpr();
    }

    @Override
    public String toString() {
        return "EVAL " + switchOnExpr();
    }
}
