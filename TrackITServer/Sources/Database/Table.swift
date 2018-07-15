//
// File         : Table.swift
// Module       : TrackITServer
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-07-14
//

import Foundation
import SwiftyJSON

public struct Table {

    public typealias Row = [String : SQLiteElement]
    public typealias Column = [SQLiteElement]
    public typealias TableType = [Row]

    fileprivate var internals = TableType()

    public init(_ literal: TableType) {
        internals = literal
    }

    public init?(jsonRows: JSON) {
        guard let rows = jsonRows.array else {
            return nil
        }
        for row in rows {
            guard let dic = row.dictionary else {
                return nil
            }
            internals.append(dic.mapValues { SQLiteElement($0.rawValue) })
        }
    }

    public init?(jsonColumns: JSON) {
        guard let columns = jsonColumns.dictionary else {
            return nil
        }
        guard let rowCount = columns.first?.value.array?.count else {
            return nil
        }
        var rows = [Row](repeating: Row(), count: rowCount)
        for kv in columns {
            guard let column = kv.value.array else {
                return nil
            }
            guard column.count == rowCount else {
                return nil
            }
            for i in 0..<rowCount {
                rows[i][kv.key] = SQLiteElement(column[i].rawValue)
            }
        }
        internals = rows
    }

}

// MARK: Computed Properties

public extension Table {

    /// Returns an array of rows.
    ///
    /// This is the underlying layout of the table and, as such, is the most
    /// efficient way of interacting with it.
    var rows: [Row] {
        return internals
    }

    /// Returns the column headers,
    ///
    /// `rowCount` must be > 0.
    var columnHeaders: [String] {
        return [String](rows[0].keys)
    }

    /// Returns a mapping of column headers to arrays of elements.
    var columns: [String : Column] {
        var result = [String : Column]()
        for header in columnHeaders {
            result[header] = column(header)
        }
        return result
    }

    /// The number of rows in the table.
    var rowCount: Int {
        return internals.count
    }

    /// The number of columns.
    ///
    /// `rowCount` must be > 0 before calling this function, otherwise the
    /// program will crash.
    var columnCount: Int {
        return columnHeaders.count
    }

}

// MARK: Single Row/Column Getters

public extension Table {

    /// Returns the contents of a column with a given header name.
    ///
    /// - parameters:
    ///     - name: The name of the column header.
    ///
    /// - returns: An array of elements that make up a given column. If the
    ///     column name is invalid (i.e. it doesn't exist in the table) then
    ///     an empty array is returned.
    func column(_ name: String) -> Column {
        return internals.compactMap { $0[name] }
    }

    /// Returns the row at a given index.
    ///
    /// - parameters:
    ///     - i: The index of the row. Must be >= 0 and < `rowCount`.
    ///
    /// - returns: A dictionary mapping column headers to their respective
    ///     values in the given row.
    func row(_ i: Int) -> Row {
        return internals[i]
    }

}

// MARK: Subscripts

public extension Table {

    subscript(column: String, row: Int) -> SQLiteElement? {
        return internals[row][column.uppercased()]
    }

    subscript(row: Int, column: String) -> SQLiteElement? {
        return self[column, row]
    }

}

// MARK: JSON Conversions

public extension Table {

    /// Converts the entire table into JSON formatted as an array of rows.
    ///
    /// - returns: A JSON array containing the table data.
    ///
    /// Example:
    ///
    /// ```
    ///     A | B | C
    ///    -----------
    ///     1 | 2 | 3
    ///     4 | 5 | 6
    ///
    /// ```
    ///
    /// Will be converted to:
    ///
    /// ```
    /// [
    ///     { "A":1, "B":2, "C",3 },
    ///     { "A":4, "B":5, "C",6 }
    /// }
    /// ```
    func rowsAsJSON() -> JSON {
        var jsonRows = [JSON]()
        for row in rows {
            var jsonRow = JSON()
            for kv in row {
                try? jsonRow.mergeAsDictionary(
                        JSON(dictionaryLiteral: (kv.key, kv.value.any))
                )
            }
            jsonRows.append(jsonRow)
        }
        return JSON(jsonRows)
    }

    /// Converts the entire table into JSON formatted as a map of column headers
    /// to array of elements for each column.
    ///
    /// - returns: A JSON dictionary containing the table data.
    ///
    /// Example:
    ///
    /// ```
    ///     A | B | C
    ///    -----------
    ///     1 | 2 | 3
    ///     4 | 5 | 6
    ///
    /// ```
    ///
    /// Will be converted to:
    ///
    /// ```
    /// {
    ///     "A": [1, 4],
    ///     "B": [2, 5],
    ///     "C": [3, 6]
    /// }
    /// ```
    func columnsAsJSON() -> JSON {
        var json = JSON()
        for header in columnHeaders {
            try? json.mergeAsDictionary(
                    JSON(dictionaryLiteral: (
                            header,
                            column(header).map {$0.any }
                    )))
        }
        return json
    }

}

// MARK: Mutating Methods

public extension Table {

    /// Adds a new row to the bottom of the table.
    ///
    /// - parameters:
    ///     - row: The row to add.
    ///
    /// The keys in the row dictionary correspond to the column headers in the
    /// table. For consistency, the same column headers (keys) should be used
    /// for every row in the table.
    ///
    /// The values in the row dictionary should be either Int, String, Double or
    /// Bool. Any other values may cause problems when trying to create JSON.
    mutating func addRow(_ row: [String : Any]) {
        var correctedRow = [String : Any]() // correct for case insensitivity
        for kv in row {
            correctedRow[kv.key.uppercased()] = kv.value
        }
        internals.append(correctedRow.mapValues { SQLiteElement($0) })
    }

    /// Adds another column to the table.
    ///
    /// - parameters:
    ///     - name: The column header for the new column.
    ///
    ///     - data: An array to defined the data that will be in the column. The
    ///         length of this array must be the same as the number of rows
    ///         currently in the table. If not, then this method does nothing.
    ///
    /// The values in the `data` array should be either Int, String, Double, or
    /// Bool. Any other values may cause problems when trying to create JSON.
    mutating func addColumn(name: String, data: [Any]) {
        if rowCount != data.count {
            return
        }
        for i in 0..<rowCount {
            internals[i][name.uppercased()] = SQLiteElement([i])
        }
    }

}

public extension JSON {

    mutating func mergeAsDictionary(_ other: JSON) {
        for (key, json) in other {
            if let i = json.int {
                self.rawDictionary[key] = JSON(integerLiteral: i)
            } else {
                self.rawDictionary[key] = json
            }
        }
    }

}
