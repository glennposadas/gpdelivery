//
//  Delivery.swift
//
//  Created by Glenn Von C. Posadas on 19/07/2018
//  Copyright (c) GAM Studio. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Delivery: NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let descriptionValue = "description"
        static let location = "location"
        static let imageUrl = "imageUrl"
    }
    
    // MARK: Properties
    public var descriptionValue: String?
    public var location: Location?
    public var imageUrl: String?
    
    // MARK: SwiftyJSON Initializers
    /// Initiates the instance based on the object.
    ///
    /// - parameter object: The object of either Dictionary or Array kind that was passed.
    /// - returns: An initialized instance of the class.
    public convenience init(object: Any) {
        self.init(json: JSON(object))
    }
    
    /// Initiates the instance based on the JSON that was passed.
    ///
    /// - parameter json: JSON object from SwiftyJSON.
    public required init(json: JSON) {
        descriptionValue = json[SerializationKeys.descriptionValue].string
        location = Location(json: json[SerializationKeys.location])
        imageUrl = json[SerializationKeys.imageUrl].string
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = descriptionValue { dictionary[SerializationKeys.descriptionValue] = value }
        if let value = location { dictionary[SerializationKeys.location] = value.dictionaryRepresentation() }
        if let value = imageUrl { dictionary[SerializationKeys.imageUrl] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.descriptionValue = aDecoder.decodeObject(forKey: SerializationKeys.descriptionValue) as? String
        self.location = aDecoder.decodeObject(forKey: SerializationKeys.location) as? Location
        self.imageUrl = aDecoder.decodeObject(forKey: SerializationKeys.imageUrl) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(descriptionValue, forKey: SerializationKeys.descriptionValue)
        aCoder.encode(location, forKey: SerializationKeys.location)
        aCoder.encode(imageUrl, forKey: SerializationKeys.imageUrl)
    }
    
}
