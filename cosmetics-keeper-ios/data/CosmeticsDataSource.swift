import Foundation

enum CosmeticsState: Int, CustomStringConvertible {
    case Sealed = 0
    case Opened = 1
    
    var description: String {
        switch (self) {
        case Sealed:
            return "Sealed"
        case Opened:
            return "Opened"
        }
    }
    
    static var count: Int {
        return CosmeticsState.Opened.rawValue + 1
    }
}

class Item {
    var name: String
    var quantity: NSInteger
    var state: CosmeticsState
    var dom: NSDate?
    var remindBy: NSDate?
    var notes: String?
    
    init(name: String) {
        self.name = name
        self.quantity = 1
        self.state = CosmeticsState.Sealed
    }
    
    init(name: String, quantity: NSInteger, state:CosmeticsState, dom:NSDate?, remindBy:NSDate?, notes:String?) {
        self.name = name
        self.quantity = quantity
        self.state = state
        self.dom = dom
        self.remindBy = remindBy
        self.notes = notes
    }
}

class CosmeticsDataSource {
    var data = [Item]()
    static var uniqueInstance: CosmeticsDataSource?
    
    var count: Int {
        return data.count;
    }
    
    static func getUniqueInstance() -> CosmeticsDataSource {
        if uniqueInstance == nil {
            uniqueInstance = CosmeticsDataSource()
        }
        return uniqueInstance!;
    }
    
    private init() {
        let df = NSDateFormatter()
        df.dateFormat = "yyyy-MM-dd"

        data.append(Item(name: "SK-II Mask", quantity: 6, state: CosmeticsState.Sealed,
                    dom: df.dateFromString("2016-05-01")!, remindBy: df.dateFromString("2019-05-01")!, notes: nil))
        data.append(Item(name: "Sheseido Lotion", quantity: 1, state: CosmeticsState.Sealed,
            dom: df.dateFromString("2016-05-02")!, remindBy: df.dateFromString("2019-05-02")!, notes: nil))
        data.append(Item(name: "Clinique Moisturizer", quantity: 2, state: CosmeticsState.Sealed,
            dom: df.dateFromString("2016-05-03")!, remindBy: df.dateFromString("2019-05-03")!, notes: nil))
    }
    
    func getItem(index: Int) -> Item {
        return data[index];
    }
    
    func deleteItem(index: Int) {
        data.removeAtIndex(index)
    }
    
    func addItem(item: Item) {
        data.append(item)
    }
}
