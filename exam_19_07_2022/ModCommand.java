class ModCommand implements Command {
    String power_type;
    Double val;

    public ModCommand(String power_type, Double val) {
        this.power_type = power_type;
        this.val = val;
    }

    public void execute(BatteryFuel bf) {
        if (power_type.equals("BATTERY")) {
            bf.battery = bf.battery + val;
        } else if (power_type.equals("FUEL")) {
            bf.fuel = bf.fuel + val;
        }
        bf.displayCurrent();
    }
}