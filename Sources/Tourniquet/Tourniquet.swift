import Foundation

public class Tourniquet {
    private let storage = CodableStorage()
    private static let storageKey = "tourniquet_feature_points"
    
    private let previousFeatures: [FeaturePoint]
    private var features: [FeaturePoint] = [] {
        didSet {
            storage.set(value: features, for: Tourniquet.storageKey)
        }
    }

    public init() {
        // Read previous features out of storage
        self.previousFeatures = storage.get(for: Tourniquet.storageKey) ?? []
        // Clear previous feature from storage
        storage.set(value: nil, for: Tourniquet.storageKey)
    }
    
    public func register(_ identifier: String) {
        let callstack = Thread.callStackSymbols
        guard callstack.count >= 3 else { return }
        /// index 2 is the call site of the function in question
        let frameString = callstack[2]
        guard let featurePoint = FeaturePoint(identifier: identifier,
                                              frameString: frameString) else { return }

        // Store it for use on the next app launch
        features.append(featurePoint)
    }
    
    public func handlePendingCrash(_ stack: [Frame]) -> FeaturePoint? {
        for stackFrame in stack {
            for featurePoint in previousFeatures {
                if featurePoint.frame.location
                    .contains(stackFrame.location) {
                    // We have our crashing feature point :)
                    return featurePoint
                }
            }
        }
        
        return nil
    }
}
