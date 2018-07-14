//
// Created by Jeremy Schwartz on 2018-07-07.
//

import Foundation

class LabelDispatch {

    private static var id = 0

    private static let prefix = "com.trackit-server."

    /// Returns a unique dispatch queue label with a common prefix.
    static func getLabel() -> String {
        id += 1
        return "\(prefix)\(id)"
    }

}
