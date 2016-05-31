import Foundation

enum CosmeticsState {
    case Sealed
    case Opened
}

class Cosmetics {
    var name: String
    var quantity: NSInteger
    var state: CosmeticsState?
    var dom: NSDate
    var remindBy: NSDate
    var notes: String?
    
    init(name:String, quantity: NSInteger, state:CosmeticsState?, dom:NSDate, remindBy:NSDate, notes:String?) {
        self.name = name
        self.quantity = quantity
        self.state = state
        self.dom = dom
        self.remindBy = remindBy
        self.notes = notes
    }
}

class CosmeticsDataSource {
    var data = [Cosmetics]()
    static var uniqueInstance: CosmeticsDataSource?
    
    static func getUniqueInstance() -> CosmeticsDataSource {
        if uniqueInstance == nil {
            uniqueInstance = CosmeticsDataSource()
        }
        return uniqueInstance!;
    }
    
    private init() {
        let df = NSDateFormatter()
        df.dateFormat = "yyyy-MM-dd"

        data.append(Cosmetics(name: "SK-II Mask", quantity: 6, state: CosmeticsState.Sealed,
                    dom: df.dateFromString("2016-05-01")!, remindBy: df.dateFromString("2019-05-01")!, notes: nil))
        data.append(Cosmetics(name: "Sheseido Lotion", quantity: 1, state: CosmeticsState.Sealed,
            dom: df.dateFromString("2016-05-02")!, remindBy: df.dateFromString("2019-05-02")!, notes: nil))
        data.append(Cosmetics(name: "Clinique Moisturizer", quantity: 2, state: CosmeticsState.Sealed,
            dom: df.dateFromString("2016-05-03")!, remindBy: df.dateFromString("2019-05-03")!, notes: nil))
    }
    
    func getAllData() -> [Cosmetics] {
        return data;
    }
}
