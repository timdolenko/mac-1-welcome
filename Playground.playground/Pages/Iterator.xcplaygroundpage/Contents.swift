

struct Countdown: Sequence, IteratorProtocol {
    var count: Int

    mutating func next() -> Int? {
        if count == 0 {
            return nil
        } else {
            defer { count -= 1 }
            return count
        }
    }
}

let threeToGo = Countdown(count: 3)
for i in [threeToGo] {
    print(i)
}

class StringSequence {
    class Iterator: IteratorProtocol {
        private let collection: StringSequence
        private var index = 0

        init(_ collection: StringSequence) {
            self.collection = collection
        }

        func next() -> String? {
            defer { index += 1 }
            return index < collection.items.count
                ? collection.items[index]
                : nil
        }
    }

    private var items = [String]()

    func append(_ item: String) {
        self.items.append(item)
    }
}

extension StringSequence: Sequence {
    func makeIterator() -> Iterator {
        Iterator(self)
    }
}

let sequence = StringSequence()
sequence.append("apple")
sequence.append("banana")
sequence.append("lemon")

for str in sequence {
    print(str)
}
