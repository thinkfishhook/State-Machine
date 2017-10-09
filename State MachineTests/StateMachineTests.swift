//
//  Copyright © 2017 Fish Hook LLC. All rights reserved.
//

import XCTest
@testable import StateMachine

class StateMachineTests: XCTestCase {
    
    enum State: StateMachineStateType {
        case begin
        case middle
        case end
        
        func shouldTransition(to nextState: StateMachineTests.State) -> Should<StateMachineTests.State>
        {
            switch (self, nextState) {
                
            case (.begin, .middle), (.middle, .end):
                return .continue
                
            case (.begin, .end):
                return .redirect(.middle)
                
            default:
                return .abort
            }
        }
    }

    class TestStateMachineDelegate: StateMachineDelegate {
        
        var transitions: [ (from: StateMachineTests.State, to: StateMachineTests.State) ] = []
        
        func didTransition(from oldState: StateMachineTests.State, to newState: StateMachineTests.State)
        {
            transitions.append((from: oldState, to: newState))
        }
    }
    
    let delegate = TestStateMachineDelegate()
    lazy var machine: StateMachine = { return StateMachine(initialState: .begin, delegate: self.delegate) }()
    
    func testAllowedTransitionHappens()
    {
        let transitioned = machine.transition(to: .middle)
        
        XCTAssertTrue(transitioned)
        XCTAssertEqual(machine.state, .middle)
        XCTAssertEqual(delegate.transitions[0].from, .begin)
        XCTAssertEqual(delegate.transitions[0].to, .middle)
    }
    
    func testDisallowedTransitionDenied()
    {
        let transitioned = machine.transition(to: .begin)
        
        XCTAssertFalse(transitioned)
        XCTAssertEqual(machine.state, .begin)
        XCTAssertEqual(delegate.transitions.count, 0)
    }
}
