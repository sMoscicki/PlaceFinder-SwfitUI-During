import Foundation


class Business: Decodable, Identifiable{
    
        var id: String?
        var alias: String?
        var name: String?
        var imageUrl: String?
        var isClosed: Bool?
        var url: String?
        var reviewCount: Int?
        var categories: [Category]?
        var rating: Double?
        var coordinates: Coordinate?
        var transactions: [String]?
        var price: String?
        var location: Location?
        var phone: String?
        var displayPhone: String?
        var distance: Double?
    
    
}

struct Location: Decodable{
    
    var address1: String?
        var address2: String?
        var address3: String?
        var city: String?
        var zipCode: String?
        var country: String?
        var state: String?
        var displayAddress: [String]?
    
}

struct Category: Decodable {
    
    var alias: String?
    var title: String?

}

struct Coordinate: Decodable {
    
    var latitude: Double?
    var longitude: Double?
    
}
