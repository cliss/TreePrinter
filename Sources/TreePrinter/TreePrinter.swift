//
//  TreePrinter.swift
//  TreePrinter
//
//  Created by Casey Liss on 3/3/20.
//  Copyright © 2020 Limitliss LLC. All rights reserved.
//

/// Allows for pretty-printing of a structure that is `TreeRepresentable`
public class TreePrinter {
    
    /// A set of options to configure how a tree is printed
    public struct TreePrinterOptions {
        public let spacesPerDepth: Int
        public let spacer: String
        public let verticalLine: String
        public let intermediateConnector: String
        public let finalConnector: String
        public let connectorSuffix: String
        
        /// Creates a set of `TreePrinter` options.
        ///
        /// - Note: Every parameter has a sensible default.
        ///
        /// - Parameters:
        ///   - spacesPerDepth: Indentation per depth level; defaults to `4`
        ///   - spacer: The spacer to use for indentation; defaults to a single space
        ///   - verticalLine: The `String` to use for a vertical line; defaults to `│`
        ///   - intermediateConnector: The `String` to use to connect a non-terminal
        ///                            node to its parent; defualts to `├`
        ///   - finalConnector: The `String` to use to connect a terminal node to its parent;
        ///                     defaults to `` ` ``
        ///   - connectorSuffix: The `String` suffix after one of the connectors;
        ///                      defaults to `── `
        public init(spacesPerDepth: Int = 4,
                    spacer: String = " ",
                    verticalLine: String = "│",
                    intermediateConnector: String = "├",
                    finalConnector: String = "└",
                    connectorSuffix: String = "── ")
        {
            self.spacesPerDepth = spacesPerDepth
            self.spacer = spacer
            self.verticalLine = verticalLine
            self.intermediateConnector = intermediateConnector
            self.finalConnector = finalConnector
            self.connectorSuffix = connectorSuffix
        }
        
        /// Alternative defaults that uses characters that are easily
        /// typed on a standard US keyboard.
        public static var alternateDefaults: TreePrinterOptions {
            TreePrinterOptions(spacesPerDepth: 5,
                               spacer: " ",
                               verticalLine: "|",
                               intermediateConnector: "+",
                               finalConnector: "`",
                               connectorSuffix: "-- ")
        }
    }
    
    /// Creates a `String` representation of a tree structure.
    /// - Parameters:
    ///   - root: Root of the tree; must conform to `TreeReprsentable`
    ///   - options: Optional set of options to configure how the output looks
    public static func printTree<Node>(root: Node,
                                       options: TreePrinterOptions = TreePrinterOptions()) -> String where Node: TreeRepresentable
    {
        return printNode(node: root,
                         depth: 0,
                         depthsFinished: Set(),
                         options: options)
    }
    
    /// Recursive function to print a node and all subnodes.
    /// - Parameters:
    ///   - node: Node to print
    ///   - depth: Current depth of the tree
    ///   - depthsFinished: `Set` of depths that are complete
    ///   - options: Options to use to configure output
    private static func printNode<Node>(node: Node,
                                        depth: Int,
                                        depthsFinished: Set<Int>,
                                        options: TreePrinterOptions) -> String where Node: TreeRepresentable
    {
        var retVal = ""
        // Prefix the appropriate spaces/pipes.
        for i in 0..<max(depth - 1, 0) * options.spacesPerDepth {
            if i % options.spacesPerDepth == 0 && !depthsFinished.contains(i / options.spacesPerDepth + 1)
            {
                retVal += options.verticalLine
            } else {
                retVal += options.spacer
            }
        }
        
        // Now the correct connector: either an intermediate or a final
        if depth > 0 {
            if depthsFinished.contains(depth) {
                retVal += options.finalConnector
            } else {
                retVal += options.intermediateConnector
            }
            
            // Connector suffix
            retVal += options.connectorSuffix
        }
        // Name
        retVal += node.name
        // Newline to prepare for either sub-tree or next peer
        retVal += "\n"
        
        // Sub-tree
        for (index, subnode) in node.subnodes.enumerated() {
            var newDepthsFinished = depthsFinished
            // There can only be one root node, so if it isn't marked, mark it.
            if depth == 0 {
                newDepthsFinished.insert(depth)
            }
            // If we're the last subnode, mark that depth as finished.
            if index == node.subnodes.count - 1 {
                newDepthsFinished.insert(depth + 1)
            }
            retVal += printNode(node: subnode,
                                depth: depth + 1,
                                depthsFinished: newDepthsFinished,
                                options: options)
        }
        
        return retVal
    }
}

