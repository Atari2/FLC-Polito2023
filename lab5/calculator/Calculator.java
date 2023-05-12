import java.util.HashMap;
import java.util.ArrayList;
import java.util.function.BiFunction;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

// TODO:
// - Respect order of operation
// - Improve errors by printing the tokens

class InvalidOperation extends Exception {
    public InvalidOperation(String errorMessage) {
        super(errorMessage);
    }
}

public class Calculator {
    public enum Op {
        PLUS, MINUS, MULT, DIV, POW, DOT
    }
    public enum OpType {
        Scalar, Vector, Mixed
    }

    parser p;
    HashMap<String, Double> variables = new HashMap<>();
    HashMap<String, ArrayList<Double>> vectors = new HashMap<>();

    BiFunction<Double, Double, Double>  get_op(Op op, OpType type) throws InvalidOperation {
        if (op == Op.DOT && type == OpType.Scalar) {
            throw new InvalidOperation("Dot operation is not valid between scalars");
        } else if (op == Op.POW && type == OpType.Vector) {
            throw new InvalidOperation("Pow operation is not valid between vectors");
        } else if (op != Op.MULT && op != Op.DIV && type == OpType.Mixed) {
            throw new InvalidOperation("Mixed operations are MULT and DIV only");
        }
        switch (op) {
            case PLUS -> {
                return Double::sum;
            }
            case MINUS -> {
                return (a, b) -> a - b;
            }
            case MULT, DOT -> {
                return (a, b) -> a * b;
            }
            case DIV -> {
                return (a, b) -> a / b;
            }
            case POW -> {
                return Math::pow;
            }
        }
        throw new InvalidOperation("Invalid operation");
    }

    public Calculator(parser p) {
        this.p = p;
    }

    public double handle_op(double lhs, double rhs, Op op) {
        try {
            return get_op(op, OpType.Scalar).apply(lhs, rhs);
        } catch (InvalidOperation exc) {
            p.report_error(exc.getMessage(), p.getCurSymbol());
            return 0.0;
        }
    }

    public ArrayList<Double> handle_op(ArrayList<Double> lhs, ArrayList<Double> rhs, Op op) {
        try {
            var func = get_op(op, OpType.Vector);
            return IntStream.range(0, Math.min(lhs.size(), rhs.size()))
                    .mapToObj(i -> func.apply(lhs.get(i), rhs.get(i)))
                    .collect(Collectors.toCollection(ArrayList::new));
        } catch (InvalidOperation exc) {
            p.report_error(exc.getMessage(), p.getCurSymbol());
            return new ArrayList<>();
        }
    }

    public ArrayList<Double> handle_op(ArrayList<Double> lhs, Double rhs, Op op) {
        try {
            if (op != Op.MULT && op != Op.DIV) {
                throw new InvalidOperation("Only vector x scalar valid operations are multiplication and division");
            }
            var func = get_op(op, OpType.Mixed);
            return lhs.stream().map(lh -> func.apply(lh, rhs))
                    .collect(Collectors.toCollection(ArrayList::new));
        } catch (InvalidOperation exc) {
            p.report_error(exc.getMessage(), p.getCurSymbol());
            return new ArrayList<>();
        }
    }

    public ArrayList<Double> handle_op(Double lhs, ArrayList<Double> rhs, Op op) {
        try {
            if (op != Op.MULT) {
                throw new InvalidOperation("Only scalar x vector valid operation is multiplication");
            }
            var func = get_op(op, OpType.Mixed);
            return rhs.stream().map(rh -> func.apply(lhs, rh))
                    .collect(Collectors.toCollection(ArrayList::new));
        } catch (InvalidOperation exc) {
            p.report_error(exc.getMessage(), p.getCurSymbol());
            return new ArrayList<>();
        }
    }

    public Double handle_dot(ArrayList<Double> lhs, ArrayList<Double> rhs) {
        try {
            var func = get_op(Op.DOT, OpType.Vector);
            return IntStream.range(0, Math.min(lhs.size(), rhs.size()))
                    .mapToObj(i -> func.apply(lhs.get(i), rhs.get(i)))
                    .reduce(Double::sum).orElse(0.0);
        } catch (InvalidOperation exc) {
            p.report_error(exc.getMessage(), p.getCurSymbol());
            return 0.0;
        }
    }

    public ArrayList<Double> get_vector(String name) {
        return vectors.get(name);
    }
    public Double get_variable(String name) {
        return variables.get(name);
    }
    public void add_variable(String name, Double value) {
        System.out.println("assignment: " + value);
        variables.put(name, value);
    }
    public void add_vector(String name, ArrayList<Double> value) {
        System.out.println("assignment: " + value);
        vectors.put(name, value);
    }

    static public ArrayList<Double> make_arraylist(Double obj) {
        ArrayList<Double> list = new ArrayList<>();
        list.add(obj);
        return list;
    }

    static public ArrayList<Double> join_arraylist(ArrayList<Double> list, Double obj) {
        list.add(obj);
        return list;
    }
    static public void print(Double obj) {
        System.out.println("scalar expression: " + obj);
    }

    static public void print(ArrayList<Double> obj) {
        System.out.println("vector expression: " + obj);
    }
}