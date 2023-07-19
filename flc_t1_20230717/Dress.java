import java.util.ArrayList;

class Dress {
    public String name;
    public ArrayList<Prod> prod_list;

    public Dress(String name, ArrayList<Prod> prod_list) {
        this.name = name;
        this.prod_list = prod_list;
    }
    public Double getPrice(String name) {
        return this.prod_list.stream().filter((p) -> p.name.equals(name)).findFirst().get().price;
    }
}