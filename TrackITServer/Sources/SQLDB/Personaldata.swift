import Foundation

class Personaldata {
    let id: Int64?
    var name: String
    var sex: String
    var dietary: String

    init(id: Int64) {
        self.id = id
        name = ""
        sex = ""
        dietary = ""
    }

    init(id: Int64, name: String, sex: String, dietary: String) {
        self.id = id
        self.name = name
        self.sex = sex
        self.dietary = diatary
    }
}

