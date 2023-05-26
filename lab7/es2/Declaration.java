import java.util.Stack;


public class Declaration {
    Stack<Modifier> modifiers;
    Type type;

    String name;

    public Declaration(String name, Stack<Modifier> ptrMod, Stack<Modifier> arrMod) {
        this.name = name;
        this.modifiers = new Stack<>();
        for (Modifier mod : ptrMod) {
            this.modifiers.push(mod);
        }
        for (Modifier mod : arrMod) {
            this.modifiers.push(mod);
        }
    }

    public void setType(Type type) {
        this.type = type;
    }

    public String toString() {
        StringBuilder builder = new StringBuilder();
        int size = modifiers.size();
        while (!modifiers.empty()) {
            Modifier mod = modifiers.pop();
            builder.append(mod.makeString());
        }
        builder.append('[');
        builder.append(type.toString());
        builder.append(']');
        builder.append(")".repeat(size));
        return "var " + name + " :" + builder;
    }
}
