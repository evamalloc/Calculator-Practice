//
//  CalModel.swift
//  Cal
//
//  Created by Yang Tian on 11/3/15.
//  Copyright © 2015 Jiao Chu. All rights reserved.
//

import Foundation

class CalModel {
    
    //MARK: emum op
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
        knowOps["÷"] = Op.BinaryOperation("÷", {$1 / $0}) //will crash when $0 is 0
        knowOps["√"] = Op.UnaryOperation("√", sqrt)
        knowOps["sin"] = Op.UnaryOperation("sin", sin)//this fun seems not proper
        knowOps["cos"] = Op.UnaryOperation("cos", cos)
        knowOps["tan"] = Op.UnaryOperation("tan", tan)
    }
    
    //
    private func cal(ops: [Op]) -> (result: Double?, leftOver: [Op]) {
        if !ops.isEmpty {
            var leftOver = ops
            
            let op = leftOver.removeLast()
            switch op {
            case .Operand(let operand):
                return (operand, leftOver) //get number and the rest stack
            case .UnaryOperation( _, let operation):
                let operandEvaluation = cal(leftOver)
                if let operand = operandEvaluation.result {
                    return ((operation(operand)), operandEvaluation.leftOver)
                }
            case .BinaryOperation( _, let operation):
                let op1Evaluation = cal(leftOver)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = cal(op1Evaluation.leftOver)
                    if let operand2 = op2Evaluation.result {
                        return(operation(operand1, operand2), op2Evaluation.leftOver)
                    }
                }
            }
        }
        return (0, ops)//when the stack is empty
    }
    
    //print
    func cal() -> Double? {
        let (result, leftOver) = cal(opStack)
        print("\(opStack): result is \(result!) and leftover is \(leftOver)")
        return result
    }
    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return cal()
    }
    func performCal(symbol: String) -> Double? {
        if let operation = knowOps[symbol] {
            opStack.append(operation)
        }
        return cal()
    }
    
    func emptyStack() {
        opStack.removeAll()
    }
//    //
//    var program: AnyObject {
//        get { //get the string version of enum Op
//            var returnValue = Array<String>()
//            for op in opStack {
//                returnValue.append(op.description)
//            }
//            return returnValue
//        }
//        set { //get enum Op from string version
//            if let opSymbols = newValue as? Array<String> {
//                var newOpstack = [Op]()
//                for symbol in opSymbols {
//                    if let op = knowOps[symbol] {
//                        newOpstack.append(op)
//                    } else if let operand = NSNumberFormatter().numberFromString(symbol)?.doubleValue {
//                        newOpstack.append(.Operand(operand))
//                    }
//                }
//            }
//        }
//    }

    
    
}

    














