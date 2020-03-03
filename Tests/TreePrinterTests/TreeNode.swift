//
//  TreeNode.swift
//  TreePrinterTests
//
//  Created by Casey Liss on 3/3/20.
//  Copyright © 2020 Limitliss LLC. All rights reserved.
//

import Foundation
import TreePrinter

struct TreeNode {
    let title: String
    let subNodes: [TreeNode]
}

extension TreeNode {
    static var sampleTree: TreeNode {
        let depthThree = TreeNode(title: "Leaf Depth Three", subNodes: [])
        
        let depthTwoA = TreeNode(title: "Branch Depth Two A", subNodes: [])
        let depthTwoB = TreeNode(title: "Branch Depth Two B", subNodes: [depthThree])
        let depthTwoC = TreeNode(title: "Branch Depth Two C", subNodes: [])
        
        let depthOneA = TreeNode(title: "Branch Depth One A", subNodes: [depthTwoA, depthTwoB, depthTwoC])
        let depthOneB = TreeNode(title: "Branch Depth One B", subNodes: [])
        
        let root = TreeNode(title: "Root", subNodes: [depthOneA, depthOneB])
        
        return root
    }
}

extension TreeNode: TreeRepresentable {
    var name: String { self.title }
    var subnodes: [TreeNode] { self.subNodes}
}
