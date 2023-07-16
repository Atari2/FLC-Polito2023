import java.util.ArrayList;
class Element {
    public String name;
    public ArrayList<Component> components;
    public Element(String name, ArrayList<Component> components) {
        this.name = name;
        this.components = components;
    }
}