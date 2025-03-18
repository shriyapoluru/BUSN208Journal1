import UIKit

//var greeting = "Hello, playground"

import Foundation

// This is a struct that will represent one expense
struct Expense { //constants:
    let payer: String // Name of the person who paid
    let amount: Double // Total amount paid
    let participants: [String] // List of people sharing the expense
}

// This is a class that will manage different expenses. It will also be able to calculate balances
class BillSplitter {
    private var expenses: [Expense] = [] // Array to store all expenses
    
    // This is a function that will add a new expense.
    func addExpense(payer: String, amount: Double, participants: [String]) {
        let expense = Expense(payer: payer, amount: amount, participants: participants)
        expenses.append(expense)
    }
    
    // This is a function that will be used to calculate current balances (how much each person will //own)
    func calculateBalances() -> [String: [String: Double]] {
        var balances: [String: Double] = [:] // Tracking each person's net balance
        
        // Iterating through every expense
        for expense in expenses {
            let splitAmount = expense.amount / Double(expense.participants.count) // Evenly split amount
            
            for person in expense.participants {
                if person != expense.payer {
                    balances[person, default: 0] -= splitAmount // Subtracts from participant
                    balances[expense.payer, default: 0] += splitAmount // Add to payer
                }
            }
        }
        
        return simplifyDebts(balances)
    }
    
    // The function will decide who owes how much to who
    private func simplifyDebts(_ balances: [String: Double]) -> [String: [String: Double]] {
        var positiveBalances: [(String, Double)] = [] // People who’ll receive money
        var negativeBalances: [(String, Double)] = [] // People who owe money
        
        for (person, balance) in balances {
            if balance > 0 {
                positiveBalances.append((person, balance))
            } else if balance < 0 {
                negativeBalances.append((person, -balance)) // Here I am storing it as a positive to use for calculations.
            }
        }
        
        var result: [String: [String: Double]] = [:]
        
        while !positiveBalances.isEmpty && !negativeBalances.isEmpty {
            let (creditor, credit) = positiveBalances.removeFirst()
            var (debtor, debt) = negativeBalances.removeFirst()
            
            let amount = min(credit, debt) //tthe transaction amount
            result[debtor, default: [:]][creditor] = amount // store transaction amount
            
            if credit > debt {
                positiveBalances.insert((creditor, credit - debt), at: 0)
            } else if debt > credit {
                negativeBalances.insert((debtor, debt - credit), at: 0)
            }
        }
        
        return result
    }
    
    //testing
    
}

