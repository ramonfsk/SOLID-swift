import Foundation

enum Color {
    case red
    case green
    case blue
}

enum Size {
    case small
    case medium 
    case large
    case yuge
}

class Product {
    var name: String
    var color: Color
    var size: Size

    init(_ name: String, _ color: Color, _ size: Size) {
        self.name = name
        self.color = color
        self.size = size
    }
}

class ProductFilter {
    func filterByColor(_ products: [Product], _ color: Color) -> [Product] {
        var result = [Product]()
        for product in products {
            if product.color == color {
                result.append(product)
            }
        }

        return result
    }

    func filterBySize(_ products: [Product], _ size: Size) -> [Product] {
        var result = [Product]()
        for product in products {
            if product.size == size {
                result.append(product)
            }
        }

        return result
    }

    func filterBySizeAndColor(_ products: [Product], _ size: Size, _ color: Color) -> [Product] {
    var result = [Product]()
    for product in products {
      if (product.size == size) && (product.color == color) {
        result.append(product)
      }
    }

    return result
  }
}

// Specification
protocol Specification {
    associatedtype T 
    func isSatisfied(_ item: T) -> Bool
}

protocol Filter {
    associatedtype T
    func filter<Spec: Specification>(_ items: [T], _ spec: Spec) -> [T] where Spec.T == T
}

class ColorSpecification: Specification {
    typealias T = Product
    let color: Color

    init(_ color: Color) {
        self.color = color
    }

    func isSatisfied(_ item: Product) -> Bool {
        return item.color == color
    }
}

class SizeSpecification: Specification {
    typealias T = Product
    let size: Size

    init(_ size: Size) {
        self.size = size
    }

    func isSatisfied(_ item: Product) -> Bool {
        return item.size == size
    }
}

class AndSpecification<T, 
    SpecA: Specification, 
    SpecB: Specification>: Specification 
    where SpecA.T == SpecB.T, T == SpecA.T, T == SpecB.T {
    
    let first: SpecA
    let second: SpecB

    init(_ first: SpecA, _ second: SpecB) {
        self.first = first
        self.second = second
    }

    func isSatisfied(_ item: T) -> Bool {
        return first.isSatisfied(item) && second.isSatisfied(item)
    }
}

class BetterFilter: Filter {
    typealias T = Product

    func filter<Spec: Specification>(_ items: [Product], _ spec: Spec) -> [T] where Spec.T == T {
        var result = [Product]()

        for item in items {
            if spec.isSatisfied(item) {
                result.append(item)
            }
        }

        return result
    }
}

func main() {
    let apple = Product("Apple", .green, .small)
    let tree = Product("Tree", .green, .large)
    let house = Product("House", .blue, .large)

    let products = [apple, tree, house]

    let productFilter = ProductFilter()
    print("Green products (old):")
    for product in productFilter.filterByColor(products, .green) {
        print(" - \(product.name) is green")
    }

    let betterFilter = BetterFilter()
    print("Green products (new):")
    for product in betterFilter.filter(products, ColorSpecification(.green)) {
        print(" - \(product.name) is green")
    }

    print("Large blue items")
    for product in betterFilter.filter(products, 
        AndSpecification(
            ColorSpecification(.blue),
            SizeSpecification(.large)
        )
    ) {
        print(" - \(product.name) is large and blue")
    }
}

main()