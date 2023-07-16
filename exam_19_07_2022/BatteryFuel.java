class BatteryFuel {
    public Double battery;
    public Double fuel;
    public BatteryFuel(Double battery, Double fuel) {
        this.battery = battery;
        this.fuel = fuel;
    }
    public void displayCurrent() {
        System.out.println("battery=" + battery + " fuel=" + fuel);
    }
}