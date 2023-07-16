
import java.util.ArrayList;
class UseCommand implements Command {
    String power_type;
    ArrayList<Cons> cons;

    public UseCommand(String power_type, ArrayList<Cons> cons) {
        this.power_type = power_type;
        this.cons = cons;
    }
    public void execute(BatteryFuel bf) {
        for (Cons c : cons) {
            if (power_type.equals("BATTERY")) {
                bf.battery = bf.battery - c.km * c.unit_per_km;
            } else if (power_type.equals("FUEL")) {
                bf.fuel = bf.fuel - c.km * c.unit_per_km;
            }
            bf.displayCurrent();
        }
    }
}