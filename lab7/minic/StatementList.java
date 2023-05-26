import java.util.ArrayList;
import java.util.stream.Collectors;

public class StatementList extends Instruction {
    ArrayList<Instruction> ins;
    public StatementList(StatementList ins, Instruction other) {
        super(Type.StmtList);
        this.ins = ins.ins;
        this.ins.add(other);
    }
    public StatementList(Instruction other) {
        super(Type.StmtList);
        this.ins = new ArrayList<>();
        this.ins.add(other);
    }

    @Override
    public String toString() {
        return ins.stream().map(Instruction::toString).collect(Collectors.joining("\n"));
    }
}
