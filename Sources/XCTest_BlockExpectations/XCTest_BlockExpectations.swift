// The Swift Programming Language
// https://docs.swift.org/swift-book
import XCTest


/*!
 * @method -wait(timeout: TimeInterval = 10, for block: @escaping () -> Bool)
 *
 * Executes block until it returns true, or timeout is reached
 *
 * @param timeout
 * The timeout desired
 *
 * @param block
 * A code block in the form () -> Bool that should return true to fulfill the expecation
 */
public extension XCTestCase {
    func wait(timeout: TimeInterval = 10, for block: @escaping () -> Bool) {
        let blockExpectation = expectation(description: "Block-based expectation")
        let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            DispatchQueue.main.async {
                if block() {
                    blockExpectation.fulfill()
                }
            }
            
        }
        wait(for: [blockExpectation], timeout: timeout)
        timer.invalidate()
    }
}
