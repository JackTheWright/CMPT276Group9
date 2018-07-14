import UIKit

class SQLiteCOnnect: NSOBject {
    var db: OpaquePointer? = nil
    let sqlitePath: String

    init?(path: String) {
        sqlitePath = path;
        db = self.openDatabase(sqlitePath)

        if db == nil {
            return nil
        }
    }

    func openDatabase(_ path: String) -> OpaquePointer? {
        var connectDB: OpaquePOinter? = nil
        if sqlite3_open(path, &connectdb) == SQLITE_OK {
            print("Successfully opened database \(path)")
            return connectdb!
        } else {
            print("Unable to open database.")
            return nil
        }
    }

    struct Food_Name{
        let FoodID: Int
        let FoodGroupID: Int
        let FoodDescription: String
    }

    func allFoodName() -> [Food_Name]? {
        guard let results = try? DB.prepare("SELECT FoodGroupID, FoodDescription from Food_Name") else {
            debugPrint(error)
            return nil
        }
        let foodNames = results.map{ row in
            guard let FoodID = row[0] as? Int,
                  let FoodGroupID = row[1] as? Int,
                  let FoodDescription = row[2] as? String else {
                fatalError("There was a type error in the received result set: /(row)")
            }
            return Food_Name(FoodID: FoodID, FoodGroupID: FoodGroupID, FoodDrescription: FoodDrescription)
        }
        return foodNames
    }
    
    func allDescription() -> [String]? {
        return allFoodName()?.map { $0.FoodDescription }
    }

    struct Food_Group{
        let FoodGroupID: Int
        let FoodGroupName: String
        let DASHgroupName: String
    }

    func allFoodGroup() -> [Food_Group]? {
        guard let groups = try? DB.prepare("SELECT FoodGroupID, FoodGroupName, DASHDASHgroup from Food_Group") else {
            debugPrint(error)
            return nil
        }
        let groupNames = groups.map{ row in
            guard let FoodGroupID = row[0] as? Int,
                  let FoodGroupName = row[1] as? String,
                  let DASHgroupName = row[2] as? String else {
                    fatalError("There was a type error in the received result set: /(row)")
            }
            return Food_Group(FoodGroupID: FoodGroupID, FoodGroupName: FoodGroupName, DASHgroupName: DASHgroupName)
        }
        return groupNames
    }

    struct Nutrient_Amount{
        let FoodID: Int
        let NutrientID: Int
        let NutrientValue: Double
    }

    func allNutrientAmount() -> [Nutrient_Amount]? {
        guard let amounts = try? DB.prepare("SELECT FoodID, NutrientID, NutrientValue from Nutrient_Amount") else {
            debugPrint(error)
            return nil
        }
        let nutrientAmount = amounts.map{ row in
            guard let FoodID = row[0] as? Int,
                  let NutrientID = row[1] as? Int,
                  let NutrientValue = row[2] as? Double else {
                    fatalError("There was a type error in the received result set: /(row)")
            }
            return Nutrient_Amount(FoodID: FoodID, NutrientID: NutrientID, NutrientValue: NutrientValue)
        }
        return nutrientAmount
    }
    
    struct Nutrient_Name{
        let NutrientID: Int
        let NutientName: String
    }
    
    func allNutrientName() -> [Nutrient_Name]? {
        guard let names = try? DB.prepare("SELECT NutrientID, NutrientName from Nutrient_Name") else {
            debugPrint(error)
            return nil
        }
        let nutrientName = names.map{ row in
            guard let NutrientID = row[0] as? Int,
                let NutrientName = row[1] as? String else{
                    fatalError("There was a type error in the received result set: /(row)")
            }
            return Nutrient_Name(NutrientID: NutrientID, NutrientName: NutrientName)
        }
        return nutrientName
    }
    
    func getNIDfromFID(foodID: Int) -> [Int]? {
        
    }

    func getNutrientValue(nutrientID: Int) -> [Double]? {
        
    }
    
    func getDASHgroup(foodID: Int) -> [String]? {
        
    }












}
