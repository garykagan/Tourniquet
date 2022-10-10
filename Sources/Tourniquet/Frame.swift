import Foundation

/// A struct representing a frame from backtrace_symbols
/// Example input data looks like the following
/// "2   TourniquetTests                     0x0000000100d02498 $s15TourniquetTestsAAC11testExampleyyKFTo + 48"

public struct Frame: Codable {
    public let processName: String
    public let location: String
    public let symbol: String
    public let offset: Int
    
    init(processName: String, location: String, symbol: String, offset: Int) {
        self.processName = processName
        self.location = location
        self.symbol = symbol
        self.offset = offset
    }
    
    init?(_ frame: String) {
        let components = frame.split(separator: " ")
        guard components.count >= 6,
              let offset = Int(String(components[5])) else {
            return nil
        }
        let processName = components[1]
        let location = components[2]
        let symbol = components[3]
        
        self.init(processName: String(processName),
                  location: String(location),
                  symbol: String(symbol),
                  offset: offset)
    }
}
