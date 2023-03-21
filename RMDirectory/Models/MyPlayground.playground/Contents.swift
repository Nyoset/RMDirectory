protocol Foo {
    var moo: String { get }
}

extension Foo {
    var moo: String { return "Moo" }
    func test() {
        print("Foo \(moo)")
    }
}

class Bar: Foo {
    var moo: String { return "Mooo" }
    func test() {
        print("Bar \(moo)")
    }
}

let b: Foo = Bar()
(b as? Bar)?.test()
