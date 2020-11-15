//
//  Copyright © 2017 - 2020 Fish Hook LLC. All rights reserved.
//

public protocol StateMachineDelegate: class {
    
    associatedtype State: StateMachineStateType
    func didTransition(from oldState: State, to newState: State)
}
