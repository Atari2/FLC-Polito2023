import java.util.ArrayList;
import java.util.HashMap;

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

    Declaration.Decltype wantedType;
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
        this.wantedType = rhs.wantedType;
    }
    public Expression(Expression obj) {
        super(Type.Expression);
        this.value = obj;
        this.op = Operation.Parens;
        this.wantedType = obj.wantedType;
    }
    public Expression(Identifier id, HashMap<String, Declaration> decls) {
        super(Type.Expression);
        this.value = id;
        this.op = Operation.Id;
        this.wantedType = decls.get(id.getName()).getType();
    }
    public Expression(Integer val) {
        super(Type.Expression);
        this.value = val;
        this.op = Operation.Integer;
        this.wantedType = Declaration.Decltype.Int;
    }
    public Expression(Double val) {
        super(Type.Expression);
        this.value = val;
        this.op = Operation.Double;
        this.wantedType = Declaration.Decltype.Double;
    }

    public boolean typeCheck(HashMap<String, Declaration> decls) {
        if (lhs != null && rhs != null) {
            return lhs.getType(decls) == rhs.getType(decls);
        } else {
            return true;
        }
    }

    private Declaration.Decltype conflateType(Declaration.Decltype lhs, Declaration.Decltype rhs) {
        if (rhs == lhs) {
            return rhs;
        } else {
            return Declaration.Decltype.Double;
        }
    }

    public void setType(Declaration.Decltype wantedType) {
        this.wantedType = wantedType;
    }

    public Declaration.Decltype getType(HashMap<String, Declaration> decls) throws RuntimeException {
        switch (this.op) {
            case Not:
                return this.rhs.getType(decls);
            case Comparison:
            case Min:
            case Maj:
            case MinEq:
            case MajEq:
            case And:
            case Or, Integer:
                return Declaration.Decltype.Int;
            case Plus:
            case Minus:
            case Mult:
            case Div:
                return conflateType(lhs.getType(decls), rhs.getType(decls));
            case Id:
                Identifier id = (Identifier)this.value;
                Declaration decl = decls.get(id.getName());
                if (decl == null)
                    throw new RuntimeException("Unexpected non-existent identifier in expression");
                return decl.getType();
            case Parens:
                return ((Expression)this.value).getType(decls);
            case Double:
                return Declaration.Decltype.Double;
        }
        throw new RuntimeException("Invalid expression type");
    }

    String switchOnExpr(Declaration.Decltype wantedType) {
        switch (this.op) {
            case And:
                return this.lhs.innerToString(wantedType) + " " + this.rhs.innerToString(wantedType) + " &&";
            case Or:
                return this.lhs.innerToString(wantedType) + " " + this.rhs.innerToString(wantedType) + " ||";
            case Not:
                return this.rhs.innerToString(wantedType) + " !";
            case Comparison:
                return this.lhs.innerToString(wantedType) + " " + this.rhs.innerToString(wantedType) + " ==";
            case Min:
                return this.lhs.innerToString(wantedType) + " " + this.rhs.innerToString(wantedType) + " <";
            case Maj:
                return this.lhs.innerToString(wantedType) + " " + this.rhs.innerToString(wantedType) + " >";
            case MinEq:
                return this.lhs.innerToString(wantedType) + " " + this.rhs.innerToString(wantedType) + " <=";
            case MajEq:
                return this.lhs.innerToString(wantedType) + " " + this.rhs.innerToString(wantedType) + " >=";
            case Plus:
                return this.lhs.innerToString(wantedType) + " " + this.rhs.innerToString(wantedType) + " +";
            case Minus:
                return this.lhs.innerToString(wantedType) + " " + this.rhs.innerToString(wantedType) + " -";
            case Mult:
                return this.lhs.innerToString(wantedType) + " " + this.rhs.innerToString(wantedType) + " *";
            case Div:
                return this.lhs.innerToString(wantedType) + " " + this.rhs.innerToString(wantedType) + " /";
            case Id:
            case Parens:
                return this.value.toString();
            case Integer:
                switch (wantedType) {
                    case Double:
                        return Double.valueOf(((Integer)this.value).doubleValue()).toString();
                    case Int:
                        return this.value.toString();
                }
            case Double:
                switch (wantedType) {
                    case Double:
                        return this.value.toString();
                    case Int:
                        return Integer.valueOf(((Double)this.value).intValue()).toString();
                }
        }
        return "INVALID EXPRESSION";
    }

    public String innerToString(Declaration.Decltype wantedType) {
        return switchOnExpr(wantedType);
    }

    @Override
    public String toString() {
        return "EVAL " + switchOnExpr(wantedType);
    }
}
