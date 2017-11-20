//
//  Copyright © 2017 Fish Hook LLC. All rights reserved.
//

import os

public class StateMachine<T: StateMachineDelegate> {
    
    public weak var delegate: T?
    
    public private(set) var state: T.State {
        didSet {
            delegate?.didTransition(from: oldValue, to: state)
        }
    }
    
    public init(initialState: T.State, delegate: T? = nil)
    {
        state = initialState
        self.delegate = delegate
    }
    
    public func transition(to newState: T.State) -> Bool
    {
        switch state.shouldTransition(to: newState) {
        case .continue:
            state = newState
            return true
            
        case .redirect(let redirectState):
            return transition(to: redirectState)
            
        case .abort:
            return false
        }
    }

    enum StateMachineError: Error {
        case invalidTransition
    }
    
    public func transitionWithError(to newState: T.State) throws
    {
        if transition(to: newState) {
            return
        }
        
        throw StateMachineError.invalidTransition
    }
    
    public func transitionIfPossible(to newState: T.State)
    {
        let didTransition: Bool = transition(to: newState)
        
        guard let newState = newState as? CustomStringConvertible else { return }
        
        if !didTransition, let stateDescription = newState.description as? CVarArg {
            os_log("[STATE MACHINE] Did not transition to state %{public}@", type: .info, stateDescription)
        }
    }
}

