//
//  Copyright © 2017 Fish Hook LLC. All rights reserved.
//

public protocol StateMachineDelegate: class {
    
    associatedtype State: StateMachineStateType
    func didTransition(from: State, to: State)
}
