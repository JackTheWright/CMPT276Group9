#if os(Linux)
    import Glibc
#else
    import Darwin
#endif

/// Object containing static methods which print messages to `stdout` and
/// perform a file flush operation directly after.
public class Console {
    
    /// Prints a message to stdout and calls `fflush` after.
    public static func log(_ msg: Any) {
        print(msg)
        fflush(stdout)
    }
    
    
    /// Prints a message prepending `"Error: "` to stdout calls `fflush` after.
    public static func log(error msg: Any) {
        print("Error: \(msg)")
        fflush(stdout)
    }
    
}
