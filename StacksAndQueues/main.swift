//
//  main.swift
//  StacksAndQueues
//
//  Created by Ben Garrison on 1/3/22.
//

import Foundation

//MARK: Favor building old-school arrays in interviews, but understand principles behind making stack/queues

/*
 Stacks are literally "stacked."
 
 Follow principle of "last in, first out (LIFO)." Just like a stack of books: the tope book is the last book stacked, but the first removed. You "push" items onto a stack, and "pop" them off of it. Appending to an array or removing the last element would be push/pop operations (O(1)), as would adding to/removing from the head of a linked list.
 ex: forward/back in browser, undo/redo in word processing software
 */

//MARK: Create as a class (allows you to pass by reference):
class Stack<T> {
    private var array: [T] = []
    
    func push(_ item: T) {
        array.append(item)
    }
    
    func pop() -> T? {
        array.popLast()
    }
    
    func peek() -> T? {
        array.last
    }
    
    var isEmpty: Bool {
        array.isEmpty
    }
    
    var count: Int {
        array.count
    }
}

//MARK: Create as a struct (internal structure is mutated):
struct StackStruct<T> {
    fileprivate var array = [T]()
    
    mutating func push(_ item: T) {
        array.append(item)
    }
    
    mutating func pop() -> T? {
        array.popLast()
    }
    
    var peek: T? {
        array.last
    }
    
    var isEmpty: Bool {
        array.isEmpty
    }
    
    var count: Int {
        array.count
    }
}

//MARK: ----------------------------------------------------------

/*
 Queues line up just like real-world queues, and are "first in, first out (FIFO)." Whatever enters the queue first gets out first. You "enqueue" and "dequeue" items in a queue. An array can be enqueued by adding to the end (O(1)) and dequeuing from the front (O(n)), moving everything one space forward. The opposite applies to linked lists (add front, remove back).
 ex: printer queues, input processing
 */

class Queue<T> {
    private var array: [T] = []
    
    func enqueue(_ item: T) {
        array.append(item)
    }
    
    func dequeue() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
    
    func peek() -> T? {
        return array.first
    }
    
    var isEmpty: Bool {
        array.isEmpty
    }
    
    var count: Int {
        array.count
    }
}



//MARK: Questions:

/*
 Question 1: Cyclic Rotation
 
 Same as first array question:  rotate the array K times, but using a queue to do so.
 
 */

func solutionQueueRight(A: [Int], K: Int) -> [Int] {
    guard !A.isEmpty else {
        return []
    }
    guard K > 0 else {
        return A
    }
    
    var result = A
    
    //treat like a queue that is enqueuing and dequeuing off the end
    for _ in 1...K {
        let last = result.last!
        result.insert(last, at: 0)
        result.remove(at: A.count)
    }
    
    return result
}

//Answers for first question
print("Question 1 solutions:")
print("Rotating to the right K times [1, 2, 3, 4, 5]:")
print(solutionQueueRight(A: [1, 2, 3, 4, 5], K: 1))
print(solutionQueueRight(A: [1, 2, 3, 4, 5], K: 2))
print(solutionQueueRight(A: [1, 2, 3, 4, 5], K: 3))

//Question 2: Rotate left:

func solutionQueueLeft(A: [Int], K: Int) -> [Int] {
    guard !A.isEmpty else {
        return []
    }
    guard K > 0 else {
        return A
    }
    
    var result = A
    //treat like queuing and dequeuing off the end
    for _ in 1...K {
        let first = result.first!
        result.append(first)
        result.remove(at: 0)
        // or: result.removeFirst()
    }
    
    return result
}

//Question 2 answers:
print("")
print("Question 2 solutions:")
print("Rotating to the left K times [1, 2, 3, 4, 5]:")
print(solutionQueueLeft(A: [1, 2, 3, 4, 5], K: 1))
print(solutionQueueLeft(A: [1, 2, 3, 4, 5], K: 2))
print(solutionQueueLeft(A: [1, 2, 3, 4, 5], K: 3))


//Question 3:
/*
 Use a stack to reverse a string:
 */

func solutionReverseString(_ text: String) -> String {
    var textArray = Array(text)
    
    guard !textArray.isEmpty else {
        return "No string found"
    }
    
    var result = [String]()
    
    for char in textArray { // "pushing" onto result array
        result.append(String(char))
    }
    
    for i in 0..<result.count { // "popping" off the last char in result, and appending it to textArray
        textArray[i] = Character(result.popLast()!)
    }
    
    return String(textArray)
}

//Answers for question 3:
print("")
print("Question 3 solutions:")
print("NIL reversed equals: \(solutionReverseString(""))")
print("abc reversed equals: \(solutionReverseString("abc"))")
print("!ega dab a setoned enot esab a dagE reversed equals: \(solutionReverseString("!ega dab a setoned enot esab a dagE"))")


/* Question 4 --> balanced brackets:
 https://www.hackerrank.com/challenges/balanced-brackets/problem
 
 Brackets =  {, [, (. If one enclosure is missing, the bracket are not "balanced."
 Given strings of brackets, determine whether each sequence of brackets is balanced. if balabced, return YES. If unbalanced, return NO.
*/

func isBalanced(s: String) -> String {
    var bracketArray = [Character]()
    
    for char in s {
        switch char {
            
            //Push on all opening brackets from string
        case"[", "{", "(":
            bracketArray.append(char)
            
            //Pop off all closing brackets in cases below this point
        case "}":
            if (bracketArray.isEmpty || (bracketArray.last != "{")) {
                return "NO"
            }
            bracketArray.popLast()
        case ")":
            if (bracketArray.isEmpty || (bracketArray.last != "(")) {
                return "NO"
            }
            bracketArray.popLast()
        case "]":
            if (bracketArray.isEmpty || (bracketArray.last != "[")) {
                return "NO"
            }
            bracketArray.popLast()
        default:
            print("breaking \(char)")
        }
    }
         
        return bracketArray.isEmpty ? "YES" : "NO" //ternary operator
}

print("")
print("Question 4 solutions:")
print("Is {([])} a balanced string of brackets? \(isBalanced(s: "{([])}"))")
print("Is {([)} a balanced string of brackets? \(isBalanced(s: "{([)}"))")


print("")


