//
// File         : Database.swift
// Module       : TrackITServer
//
// Team Name    : Group 9
// Created By   : Jeremy Schwartz
// Created On   : 2018-07-14
//

import Foundation
import PerfectSQLite
import SQLite3

public class Database {

    public enum Error : Swift.Error {

        case InvalidColumnType

    }

    fileprivate let sqlite: SQLite

    public init?(path: String) {
        do {
            self.sqlite = try SQLite(path)
        } catch {
            return nil
        }
    }

    deinit {
        sqlite.close()
    }

    public func query(_ statement: String) throws -> Table {
        var table = Table.TableType()
        try sqlite.forEachRow(statement: statement) { stmt, i in
            var row = [String : SQLiteElement]()
            for j in 0..<stmt.columnCount() {
                let colName = stmt.columnName(position: j).uppercased()
                switch (stmt.columnType(position: j)) {

                case SQLITE_INTEGER:
                    row[colName] = SQLiteElement(stmt.columnInt(position: j))

                case SQLITE_FLOAT:
                    row[colName] = SQLiteElement(stmt.columnDouble(position: j))

                case SQLITE3_TEXT:
                    row[colName] = SQLiteElement(stmt.columnText(position: j))

                case SQLITE_BLOB:
                    row[colName] = SQLiteElement(
                            Data(bytes: stmt.columnIntBlob(position: j))
                    )

                default:
                    throw Error.InvalidColumnType

                }
            }
            table.append(row)
        }
        return Table(table)
    }

}
