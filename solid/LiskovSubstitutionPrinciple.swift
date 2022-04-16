import Foundation

class Rectangle: CustomStringConvertible {
  internal var _width: Int = 0
  internal var _height: Int = 0

  var width: Int {
    get { return _width }
    set(value) { _width = value }
  }
  var height: Int {
    get { return _height }
    set(value) { _height = value }
  }

  var area: Int { 
    return  width * height
  }

  public var description: String {
    return "Width: \(width), height: \(height)"
  }

  init() {}
  init(_ width: Int, _ height: Int) {
    self.width = width
    self.height = height
  }
}

class Square: Rectangle {
  override var height: Int {
    get { return _height }
    set(value) { 
      _width = value 
      _height = value
    }
  }

  override var width: Int {
    get { return _width }
    set(value) { 
      _width = value
      _height = value
    }
  }
}

func setAndMeasure(_ rectangle: Rectangle) {
  rectangle.width = 3
  rectangle.height = 4
  print("Expected area to be 12 but got \(rectangle.area)")
}

func main() {
  let rectangle = Rectangle()
  setAndMeasure(rectangle)

  let square = Square()
  setAndMeasure(square)
}

main()