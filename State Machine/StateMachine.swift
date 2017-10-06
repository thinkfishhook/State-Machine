//
//  Copyright © 2017 Fish Hook LLC. All rights reserved.
//

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
}

