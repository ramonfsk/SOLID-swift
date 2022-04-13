import Foundation

class Journal: CustomStringConvertible {
    var entries = [String]()
    var count = 0

    var description: String {
        return entries.joined(separator: "\n")
    }

    func addEntry(_ text: String) -> Int {
        count += 1
        entries.append("\(count): \(text)")
        return count - 1
    }

    func removeEntry(_ index: Int) {
        entries.remove(at: index)
    }

    func save(_ filename: String, _ overwrite: Bool = false) {
        // save to file
    }

    func load(_ filename: String) {}

    func load(_ uri: URL) {}
}

class Persistence {
    func saveToFile(_ journal: Journal, _ filename: String, _ overwrite: Bool = false) {}
}

func main() {
    let journal = Journal()
    let _ = journal.addEntry("I cried today")
    let bug = journal.addEntry("I ate a bug")
    print(journal)

    journal.removeEntry(bug)
    print("===")
    print(journal)

    let p = Persistence()
    let filename = "/mnt/c/sdjfhskdjhfg"
    p.saveToFile(journal, filename, false)
}

main()