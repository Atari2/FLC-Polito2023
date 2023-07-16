import java.util.ArrayList;
import java.util.Collections;
class MaterialType {
    public ArrayList<Material> materials;
    public String name;
    public MaterialType(String name, ArrayList<Material> materials) {
        this.name = name;
        this.materials = materials;
    }
    public String getHighest() {
        return materials.stream().max((lhs, rhs) -> Double.compare(lhs.price, rhs.price)).get().name;
    }
    public String getLowest() {
        return materials.stream().min((lhs, rhs) -> Double.compare(lhs.price, rhs.price)).get().name;
    }
    public Material getMaterial(String material) {
        return materials.stream().filter(m -> m.name.equals(material)).findFirst().get();
    }
}