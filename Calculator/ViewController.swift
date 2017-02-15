import UIKit

// Basic math functions
func add(_ a: Double, b: Double) -> Double {
    let result = a + b
    return result
}
func sub(_ a: Double, b: Double) -> Double {
    let result = a - b
    return result
}
func mul(_ a: Double, b: Double) -> Double {
    let result = a * b
    return result
}
func div(_ a: Double, b: Double) -> Double {
    let result = a / b
    return result
}

typealias Binop = (Double, Double) -> Double
let ops: [String: Binop] = [ "+" : add, "-" : sub, "*" : mul, "/" : div ]


class ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet var viewb: UIView!
    
    @IBOutlet weak var buttnb: UIView!
    
    
    
//    @IBAction func changeText(_ sender: Any) {
//        
//        checkMaxLength(textField: sender as! UITextField, maxLength: 3)
//        print("testt\(numField.text!.characters.count)")
//        
//        
//    }
   
    
    
    
    
    var accumulator: Double = 0.0 // Store the calculated value here
    var userInput = "" // User-entered digits
    
    var numStack: [Double] = [] // Number stack
    var opStack: [String] = [] // Operator stack
    
    // Looks for a single character in a string.
    func hasIndex(stringToSearch str: String, characterToFind chr: Character) -> Bool {
        for c in str.characters {
            if c == chr {
                return true
            }
        }
        return false
    }
    
    
    
    
    
    
//    func textFieldDidChange(_ textField: UITextField) {
//        
//        checkMaxLength(textField: numField, maxLength: 6)
//        
//    }

    
    
    
    
    
    
    func handleInput(_ str: String) {
        
        
        if str == "-" {
            if userInput.hasPrefix(str) {
                // Strip off the first character (a dash)
                userInput = userInput.substring(from: userInput.characters.index(after: userInput.startIndex))
            } else {
                userInput = str + userInput
            }
        } else {
            userInput += str
        }
        accumulator = Double((userInput as NSString).doubleValue)
        updateDisplay()
    }
    
    func updateDisplay() {
        // If the value is an integer, don't show a decimal point
        
        
        
    //    textField.text = "\(accumulator.cleanValue)"
        
  //      print("acc\(accumulator.cleanValue)")
        var iAcc: Double = 0

        
        if Double(iAcc) < Double.greatestFiniteMagnitude {
            
            iAcc = Double(accumulator)
            
            if accumulator - Double(iAcc) == 0 {
                
                textField.text = "\(iAcc.cleanValue)"
            } else {
                
                
                
                textField.text = "\(accumulator.cleanValue)"
            }
            
        }
        
    }
    
    func doMath(_ newOp: String) {
        if userInput != "" && !numStack.isEmpty {
            print("accu\(accumulator)")
            let stackOp = opStack.last
            if !((stackOp == "+" || stackOp == "-") && (newOp == "*" || newOp == "/")) {
                let oper = ops[opStack.removeLast()]
                accumulator = oper!(numStack.removeLast(), accumulator)
                print("accu\(accumulator)")
                doEquals()
            }
        }
        opStack.append(newOp)
        numStack.append(accumulator)
        userInput = ""
        print("accu\(accumulator)")
        updateDisplay()
    }
    
    func doEquals() {
        if userInput == "" {
            return
        }
        if !numStack.isEmpty {
            let oper = ops[opStack.removeLast()]
            accumulator = oper!(numStack.removeLast(), accumulator)
            if !opStack.isEmpty {
                doEquals()
            }
        }
        
        updateDisplay()
        userInput = ""
    }

    // UI Set-up
    @IBOutlet var textField: UITextField!
    @IBOutlet var btnClear: UIButton!
    @IBOutlet var bntEquals: UIButton!
    @IBOutlet var btnAdd: UIButton!
    @IBOutlet var btnSubtract: UIButton!
    @IBOutlet var btnMultiply: UIButton!
    @IBOutlet var btnDivide: UIButton!
    @IBOutlet var btnDecimal: UIButton!
    
    @IBOutlet var btn0: UIButton!
    @IBOutlet var btn1: UIButton!
    @IBOutlet var btn2: UIButton!
    @IBOutlet var btn3: UIButton!
    @IBOutlet var btn4: UIButton!
    @IBOutlet var btn5: UIButton!
    @IBOutlet var btn6: UIButton!
    @IBOutlet var btn7: UIButton!
    @IBOutlet var btn8: UIButton!
    @IBOutlet var btn9: UIButton!

    @IBAction func btn0Press(_ sender: UIButton) {
        handleInput("0")
    }
    @IBAction func btn1Press(_ sender: UIButton) {
        handleInput("1")
        
       
    }
    @IBAction func btn2Press(_ sender: UIButton) {
        handleInput("2")
    }
    @IBAction func btn3Press(_ sender: UIButton) {
        handleInput("3")
    }
    @IBAction func btn4Press(_ sender: UIButton) {
        handleInput("4")
    }
    @IBAction func btn5Press(_ sender: UIButton) {
        handleInput("5")
    }
    @IBAction func btn6Press(_ sender: UIButton) {
        handleInput("6")
    }
    @IBAction func btn7Press(_ sender: UIButton) {
        handleInput("7")
    }
    @IBAction func btn8Press(_ sender: UIButton) {
        handleInput("8")
    }
    @IBAction func btn9Press(_ sender: UIButton) {
        handleInput("9")
    }
    
    @IBAction func btnDecPress(_ sender: UIButton) {
        if hasIndex(stringToSearch: userInput, characterToFind: ".") == false {
            handleInput(".")
        }
    }
    
    @IBAction func btnCHSPress(_ sender: UIButton) {
        if userInput.isEmpty {
            userInput = textField.text!
        }
        handleInput("-")
    }
    
    @IBAction func btnACPress(_ sender: UIButton) {
        userInput = ""
        accumulator = 0
        updateDisplay()
        numStack.removeAll()
        opStack.removeAll()
    }
    
    @IBAction func btnPlusPress(_ sender: UIButton) {
        doMath("+")
    }
    
    @IBAction func btnMinusPress(_ sender: UIButton) {
        doMath("-")
    }
    
    @IBAction func btnMultiplyPress(_ sender: UIButton) {
        doMath("*")
    }
    
    @IBAction func btnDividePress(_ sender: UIButton) {
        doMath("/")
    }
    
    @IBAction func btnEqualsPress(_ sender: UIButton) {
        doEquals()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        textField.delegate = self
        
      }
    
    
    
    
}

extension Double
{
    var cleanValue: String
    {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

