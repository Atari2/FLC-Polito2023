class PrintCommand {
    String to_print;
    PrintCommand(String to_print) {
        this.to_print = to_print;
    }
    void execute() {
        System.out.println(to_print);
    }
}