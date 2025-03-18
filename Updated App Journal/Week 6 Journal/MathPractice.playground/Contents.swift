import UIKit

//var greeting = "Hello, playground"

// A class called AddDigits
class AddDigits {
    
    // A function that takes an integer as input and returns an integer
    func add(num: Int) -> Int {
        
        // Converting the integer input 'num' into a string
        let numString = String(num)
        
        // guard is used to check if the number has more than one digit
        // If numString has only one character, returning num directly
        guard numString.count > 1 else {
            return num
        }
        
        //Converting the string into an array of characters then mapping each character to a string. Mapping isn't the most effiencent way tho.
        let array = Array(numString).map { String($0) }
        
        // Use reduce to calculate the sum of the digits
        // '$0' represents the accumulated sum, and '$1' is the current digit converted into an integer
        let sum = array.reduce(0) { $0 + Int($1)! }
        
        // Recursively calling the add function with the new sum
        return add(num: sum)
    }
}



//2nd

/*
class AddDigits {
    func add(num: Int) -> Int {
        guard num > 9 else { return num } // Base case: return if num is already a single digit
        
        let sum = String(num).reduce(0) { $0 + Int(String($1))! } // Sum digits directly
        
        return add(num: sum) // Recursive call
    }
}
*/
