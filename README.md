#Calculator_Practice 
>This project is a simple calculator which support stack.

#Code Example
>Operand and operator will be stored in an array, this makes the app can support countinues number input.
```
private enum Op: CustomStringConvertible {
case Operand(Double)
case UnaryOperation(String, Double -> Double)
case BinaryOperation(String, (Double, Double) -> Double)
//case LeftBracket
//case RightBracket

//for display
var description: String {
switch self {
case .Operand(let operand):
return "\(operand)"
case .UnaryOperation(let operation, _):
return operation
case .BinaryOperation(let operation, _):
return operation
//            case .LeftBracket:
//                return "("
//            case .RightBracket:
//                return ")"
}
}
}

private var opStack = [Op]()
//knowOps: operation symbol and the fun of that symbol
private var knowOps = [String: Op]()
init() {
knowOps["+"] = Op.BinaryOperation("+", +)
knowOps["−"] = Op.BinaryOperation("−", { $1 - $0 })
knowOps["×"] = Op.BinaryOperation("×", *)
knowOps["÷"] = Op.BinaryOperation("÷", { $1 / $0})
knowOps["√"] = Op.UnaryOperation("√", sqrt)
knowOps["sin"] = Op.UnaryOperation("sin", sin)//this fun seems not proper
knowOps["cos"] = Op.UnaryOperation("cos", cos)
knowOps["tan"] = Op.UnaryOperation("tan", tan)
}
```

#Tests
>how to use this calculator: Press numbers buttons then press enter, enter will store the numbers into the stack, press the operation button will calculator one or two numbers from the top of the stack depends on it's unary or binary operation. Press C button will clear all history and start new. 
eg: 3 enter 4 enter, then +, will be 7, leave 7 on stack.
