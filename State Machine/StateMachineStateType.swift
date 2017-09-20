//
//  Copyright © 2017 Fish Hook LLC. All rights reserved.
//

public protocol StateMachineStateType {
    func shouldTransition(to nextState: Self) -> Should<Self>
}

public enum Should<T> {
    case `continue`
    case abort
    case redirect(T)
}
