#  TreePrinter

A small library to convert a tree structure into a `String`, designed to be used for debugging purposes.

# Quick Start

1. Include the framework in your project
2. Conform your type to be `TreeRepresentable`
3. `let treeString = TreePrinter.printTree(root: rootNodeOfYourTree)`

# Example

Say you already have some structure that represents a tree:

```swift
struct SomeTreeStructure {
    let title: String
    let childNodes: [SomeTreeStructure]
}
```

You start by confirming your type to `TreeRepresentable`:

```swift
extension SomeTreeStructure: TreeRepresentable {
    var name: String { return self.title }
    var subnodes: [SomeTreeStructure] { return self.childNodes }
}
```

Then, you can easily debug a tree as such:

```swift
func someFunctionYoureTesting() {
    var treeRoot: SomeTreeStructure = /* Your tree */
    print(TreePrinter.printTree(root: treeRoot))
}
```

By default, for [the tree that is used for the purposes of unit testing][ut], the result will be:

[ut]: https://github.com/cliss/TreePrinter/blob/3b2468eb8988fb41c73b46b2352df106b0428294/Tests/TreePrinterTests/TreeNode.swift#L18-L31

```
Root
├── Branch Depth One A
│   ├── Branch Depth Two A
│   ├── Branch Depth Two B
│   │   └── Leaf Depth Three
│   └── Branch Depth Two C
└── Branch Depth One B
```

# Options

`TreePrinter` will use a sensible set of default options, however, many things are customizable:

* `spacesPerDepth` — Amount of indentation; defaults to `5`.
* `spacer` — Actual spacer; defaults to ` `
* `verticalLine` — Vertical line; defaults to `|`
* `intermediateConnector` — Connects a node that is not the leaf to the node above it; defaults to `+`
* `finalConnector` — Connects a leaf node to the node above it; defaults to `` ` ``
* `connectorSuffix` — Suffix after the connector; defaults to `-- `

To customize any part of the tree print, create an instance of `TreePrinter.TreePrinterOptions` and
pass alternates for any of the above. The rest, if not provided, will use the default values. Then print the tree
as such:

```swift
TreePrinter.printTree(root: treeRoot, options: treePrinterOptions)
```

# Installation

## Use SPM

1. In Xcode 11+, `File` → `Swift Packages` → `Add Package Dependency`
2. Add the URL for this repository: `https://github.com/cliss/TreePrinter.git`

## Add files

1. Make copies of [`Sources/TreePrinter/TreeRepresentable.swift`](https://github.com/cliss/TreePrinter/blob/master/Sources/TreePrinter/TreeRepresentable.swift) and [`Sources/TreePrinter/TreePrinter.swift`](https://github.com/cliss/TreePrinter/blob/master/Sources/TreePrinter/TreePrinter.swift)
2. Add them to your project
