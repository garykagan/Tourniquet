//
//  File.swift
//  
//
//  Created by Gary Kagan on 10/10/22.
//

import Foundation

public struct FeaturePoint: Codable {
    public let identifier: String
    public let frame: Frame
    
    init(identifier: String, frame: Frame) {
        self.identifier = identifier
        self.frame = frame
    }
    
    init?(identifier: String, frameString: String) {
        guard let frame = Frame(frameString) else {
            return nil
        }
        
        self.init(identifier: identifier,
                  frame: frame)
    }
}
