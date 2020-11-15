//
//  Copyright © 2017 - 2020 Fish Hook LLC. All rights reserved.
//

public protocol StateMachineStateType: Equatable {
    func shouldTransition(to nextState: Self) -> Should<Self>
}

public enum Should<T: Equatable> {
    case `continue`
    case abort
    case redirect(T)
}

extension Should: Equatable {
    
    public static func ==(lhs: Should, rhs: Should) -> Bool
    {
        switch (lhs, rhs) {
        case (.continue, .continue), (.abort, .abort):
            return true
            
        case (.redirect(let leftValue), .redirect(let rightValue)):
            return leftValue == rightValue
            
        default:
            return false
        }
    }
}
