//
// File         : main.swift
// Module       : TrackITServer
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-07-15
//

import Database

class NutrientFile {

    enum Error : Swift.Error {
        case UnableToGetFoodID
        case UnableToGetFoodGroup
    }

    fileprivate let database: Database

    let protein = 203
    let fat = 204
    let carb = 205
    let magnesium = 304
    let vitB9 = 418
    let vitD = 876
    let iron = 303
    let potassium = 306
    let sodium = 307

    init?(path: String) {
        guard let db = Database(path: path) else {
            return nil
        }
        database = db
    }

    /// Returns a table with rows containing the food group id, food description
    /// and food group id for each food item in the nutrient file.
    func getAllFoodNames() throws -> Table {
        let table = try database.query("""
        select FoodID, FoodDescription, FoodGroupID
        from 'FOOD NAME';
        """)
        return table
    }

    /// Gets the nutrient values for a given food id.
    func getNutrientValues(for foodId: Int) throws -> Table {
        let table = try database.query("""
        select NutrientValue
        from 'Nutrient Amount'
        where FoodID = \(foodId) and (
        NutrientID = \(protein) or
        NutrientID = \(fat) or
        NutrientID = \(carb) or
        NutrientID = \(magnesium) or
        NutrientID = \(vitB9) or
        NutrientID = \(vitD) or
        NutrientID = \(iron) or
        NutrientID = \(potassium) or
        NutrientID = \(sodium))
        order by NutrientID
        ;
        """)
        return table
    }

}
