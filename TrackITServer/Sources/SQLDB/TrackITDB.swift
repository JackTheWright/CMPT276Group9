import SQLite

class TrackITDB {

    static let instance = TrackITDB()
    private let db: Connection?

    private let personalDatas = Table("personalDatas")
    private let id = Expression<Int64>("id")
    private let name = Expression<String?>("name")
    private let sex = Expression<String>("sex")
    private let dietary = Expression<String>("dietary")

    private init() {
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        do {
            db = try Connection("\(path)/TrackIT.sqlite3")
        } catch {
            db = nil
            print ("Unable to open database")
        }

        createTable()
    }

    func createTable() {
        do {
            try db!.run(personalDatas.create(ifNotExists: true) { table in
            table.column(id, primaryKey: true)
            table.column(name)
            table.column(sex, unique: true)
            table.column(dietary)
            })
        } catch {
            print("Unable to create table")
        }
    }

    func addUser(cname: String, csex: String, cdietary: String) -> Int64? {
        do {
            let insert = personalDatas.insert(name <- cname, sex <- csex, dietary <- cdietary)
            let id = try db!.run(insert)

            return id
        } catch {
            print("Insert failed")
            return -1
        }
    }

    func getUser() -> [PersonalData] {
        var personalDatas = [PersonalData]()

        do {
            for personalData in try db!.prepare(self.personalDatas) {
                personalDatas.append(Personaldata(
                id: personalData[id],
                name: personalData[name]!,
                sex: personalData[sex],
                dietary: personalData[dietary]))
            }
        } catch {
            print("Select failed")
        }

        return personalDatas
    }

    func deleteUser(cid: Int64) -> Bool {
        do {
            let personalData = personalDatas.filter(id == cid)
            try db!.run(personalData.delete())
            return true
        } catch {
            print("Delete failed")
        }
        return false
    }


}
