//import UIKit


class CountAndSay {
    func countAndSay(_ n: Int) -> String {
        if n == 1 {
            return "1"
        }
        
        let prevStr = countAndSay(n - 1)
        var currentChar = prevStr.first!, currentCount = 0, res = ""
        
        for (i, char) in prevStr.enumerated() {
            if char == currentChar {
                currentCount += 1
            } else {
                res += "\(currentCount)\(currentChar)"
                
                currentCount = 1
                currentChar = char
            }
        }
        
        res += "\(currentCount)\(currentChar)"
        
        return res
    }
}
