public class Instruction {
    public enum Type {
        Declaration,
        Expression,
        Jump,
        Assignment,
        Print,
        StmtList,
    }
    Type type;

    public Instruction(Type type) {
        this.type = type;
    }
}
