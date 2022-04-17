import Foundation

// hl modules should not depend on low-level; both should depend on abstractions
// abstractions should not depend on details; details should depend on abstractions

enum Relationship {
  case parent
  case child
  case sibling
}

class Person {
  var name = ""
  // dob, etc
  init(_ name: String) {
    self.name = name
  }
}

protocol RelationshipBrowser {
  func findAllChildrenOf(_ name: String) -> [Person]
}

class Relationships: RelationshipBrowser { // low-level
  private var relations = [(Person, Relationship, Person)]()

  func addParentAndChild(_ parent: Person, _ children: Person) {
    relations.append((parent, .parent, children))
    relations.append((children, .child, parent))
  }

  func findAllChildrenOf(_ name: String) -> [Person] {
    return relations.filter({ $0.name == name && $1 == Relationship.parent && $2 != nil })
                    .map({ $2 })
  }
}

class Research { // high-level
  init(_ relationships: Relationships) {
    // high-level: find all of job's children
    let relations = relationships.relations
    for relation in relations where relation.0.name == "John" && relation.1 == Relationship.parent {
      print("John has a child called \(relation.2.name)")
    }
  }

  init(_ browser: RelationshipBrowser) {
    for person in browser.findAllChildrenOf("John") {
      print("Jonh has a child called \(person.name)")
    }
  }
}

func main() {
  let parent = Person("John")
  let child1 = Person("Chris")
  let child2 = Person("Matt")

  let relationships = Relationships()
  relationships.addParentAndChild(parent, child1)
  relationships.addParentAndChild(parent, child2)

  let _ = Research(relationships)
}

main()