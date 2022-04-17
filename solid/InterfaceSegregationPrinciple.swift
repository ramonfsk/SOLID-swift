import Foundation

class Document {}

protocol Machine {
  func print(document: Document)
  func scan(document: Document)
  func fax(document: Document)
}

class MFP: Machine {
  func print(document: Document)
  //
}

enum NoRequiedFuncionality: Error {
  case doesNotFax
}

class OldFashionedPrinter: Machine {
  func print(document: Document) {
    // ok
  }

  func fax(document: Document) {
    throw NoRequiedFuncionality.doesNotFax
  }
}

protocol Printer {
  func print(document: Document)
}

protocol Scanner {
  func scan(document: Document)
}

protocol Fax {
  func fax(document: Document)
}

class OrdinaryPrinter: Printer {
  func print(document: Document) {
    // ok
  }
}

class Photocopier: Printer, Scanner {
  func print(document: Document) {
    // ok
  }

  func scan(document: Document) {
    // ok
  }
}

protocol MultiFunctionDevice: Printer, Scanner, Fax {}

class MultiFunctionMachine: MultiFunctionDevice {
  let printer: Printer
  let scanner: Scanner

  init(printer: Printer, scanner: Scanner) {
    self.printer = printer
    self.scanner = scanner
  }

  func print(document: Document) {
    printer.print(document: document) // Decorartor
  }
}