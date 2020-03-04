//
//  TreePrinterTests.swift
//  TreePrinterTests
//
//  Created by Casey Liss on 3/3/20.
//  Copyright © 2020 Limitliss LLC. All rights reserved.
//

import XCTest
import TreePrinter

class TreePrinterTests: XCTestCase {
    
    func testVanillaSetup() {
        let tree = TreeNode.sampleTree
        let result = TreePrinter.printTree(root: tree)
        print(result)
        let lines = result.split(separator: "\n")
        XCTAssertEqual(lines.count, 7)
        XCTAssertEqual(lines[0], "Root")
        
        XCTAssert(lines[1].starts(with: "├── "))
        XCTAssert(lines[1].contains("Branch Depth One A"))
        
        XCTAssert(lines[2].contains("│"))
        XCTAssert(lines[2].contains("├"))
        XCTAssert(lines[2].contains("Branch Depth Two A"))
        
        XCTAssert(lines[3].contains("│"))
        XCTAssert(lines[3].contains("├"))
        XCTAssert(lines[3].contains("Branch Depth Two B"))
        
        let regex = try! NSRegularExpression(pattern: "│", options: .ignoreMetacharacters)
        
        XCTAssertEqual(2, regex.numberOfMatches(in: String(lines[4]), options: .withTransparentBounds, range: NSRange(lines[4].startIndex..., in: lines[4])))
        XCTAssert(lines[4].contains("└"))
        XCTAssertFalse(lines[4].contains("├"))
        XCTAssert(lines[4].contains("Leaf Depth Three"))
        
        XCTAssert(lines[5].contains("│"))
        XCTAssert(lines[5].contains("└"))
        XCTAssert(lines[5].contains("Branch Depth Two C"))
        
        XCTAssertFalse(lines[6].contains("|"))
        XCTAssert(lines[6].contains("└"))
        XCTAssert(lines[6].contains("Branch Depth One B"))
    }

    func testAlternateSetup() {
        let tree = TreeNode.sampleTree
        let result = TreePrinter.printTree(root: tree, options: TreePrinter.TreePrinterOptions.alternateDefaults)
        print(result)
        let lines = result.split(separator: "\n")
        XCTAssertEqual(lines.count, 7)
        XCTAssertEqual(lines[0], "Root")
        
        XCTAssert(lines[1].starts(with: "+-- "))
        XCTAssert(lines[1].contains("Branch Depth One A"))
        
        XCTAssert(lines[2].contains("|"))
        XCTAssert(lines[2].contains("+"))
        XCTAssert(lines[2].contains("Branch Depth Two A"))
        
        XCTAssert(lines[3].contains("|"))
        XCTAssert(lines[3].contains("+"))
        XCTAssert(lines[3].contains("Branch Depth Two B"))
        
        let regex = try! NSRegularExpression(pattern: "|", options: .ignoreMetacharacters)
        
        XCTAssertEqual(2, regex.numberOfMatches(in: String(lines[4]), options: .withTransparentBounds, range: NSRange(lines[4].startIndex..., in: lines[4])))
        XCTAssert(lines[4].contains("`"))
        XCTAssertFalse(lines[4].contains("+"))
        XCTAssert(lines[4].contains("Leaf Depth Three"))
        
        XCTAssert(lines[5].contains("|"))
        XCTAssert(lines[5].contains("`"))
        XCTAssert(lines[5].contains("Branch Depth Two C"))
        
        XCTAssertFalse(lines[6].contains("|"))
        XCTAssert(lines[6].contains("`"))
        XCTAssert(lines[6].contains("Branch Depth One B"))
    }
    
    func testHugeDepth() {
        let tree = TreeNode.sampleTree
        let options = TreePrinter.TreePrinterOptions(spacesPerDepth: 10)
        let result = TreePrinter.printTree(root: tree, options: options)
        print(result)
        let lines = result.split(separator: "\n")
        XCTAssertEqual(lines.count, 7)
        XCTAssertEqual(lines[0], "Root")
        
        XCTAssert(lines[1].starts(with: "├── "))
        XCTAssert(lines[1].contains("Branch Depth One A"))
        
        XCTAssert(lines[2].contains(options.verticalLine))
        XCTAssert(lines[2].contains(options.intermediateConnector))
        XCTAssert(lines[2].contains("Branch Depth Two A"))
        
        XCTAssert(lines[3].contains(options.verticalLine))
        XCTAssert(lines[3].contains(options.intermediateConnector))
        XCTAssert(lines[3].contains("Branch Depth Two B"))
        
        let regex = try! NSRegularExpression(pattern: options.verticalLine, options: .ignoreMetacharacters)
        
        XCTAssertEqual(2, regex.numberOfMatches(in: String(lines[4]), options: .withTransparentBounds, range: NSRange(lines[4].startIndex..., in: lines[4])))
        XCTAssert(lines[4].contains(options.finalConnector))
        XCTAssertFalse(lines[4].contains(options.intermediateConnector))
        XCTAssert(lines[4].contains("Leaf Depth Three"))
        
        XCTAssert(lines[5].contains(options.verticalLine))
        XCTAssert(lines[5].contains(options.finalConnector))
        XCTAssert(lines[5].contains("Branch Depth Two C"))
        
        XCTAssertFalse(lines[6].contains(options.verticalLine))
        XCTAssert(lines[6].contains(options.finalConnector))
        XCTAssert(lines[6].contains("Branch Depth One B"))
    }
    
    func testAlternateSpacer() {
        let tree = TreeNode.sampleTree
        let options = TreePrinter.TreePrinterOptions(spacer: "@")
        let result = TreePrinter.printTree(root: tree, options: options)
        print(result)
        let lines = result.split(separator: "\n")
        XCTAssertEqual(lines.count, 7)
        XCTAssertEqual(lines[0], "Root")
        
        XCTAssert(lines[1].starts(with: "├── "))
        XCTAssert(lines[1].contains("Branch Depth One A"))
        
        XCTAssert(lines[2].contains(options.verticalLine))
        XCTAssert(lines[2].contains(options.intermediateConnector))
        XCTAssert(lines[2].contains("Branch Depth Two A"))
        
        XCTAssert(lines[3].contains(options.verticalLine))
        XCTAssert(lines[3].contains(options.intermediateConnector))
        XCTAssert(lines[3].contains("Branch Depth Two B"))
        
        let regex = try! NSRegularExpression(pattern: options.verticalLine, options: .ignoreMetacharacters)
        
        XCTAssertEqual(2, regex.numberOfMatches(in: String(lines[4]), options: .withTransparentBounds, range: NSRange(lines[4].startIndex..., in: lines[4])))
        XCTAssert(lines[4].contains(options.finalConnector))
        XCTAssertFalse(lines[4].contains(options.intermediateConnector))
        XCTAssert(lines[4].contains("Leaf Depth Three"))
        
        XCTAssert(lines[5].contains(options.verticalLine))
        XCTAssert(lines[5].contains(options.finalConnector))
        XCTAssert(lines[5].contains("Branch Depth Two C"))
        
        XCTAssertFalse(lines[6].contains(options.verticalLine))
        XCTAssert(lines[6].contains(options.finalConnector))
        XCTAssert(lines[6].contains("Branch Depth One B"))
    }
    
    func testAlternateVerticalLine() {
        let tree = TreeNode.sampleTree
        let options = TreePrinter.TreePrinterOptions(verticalLine: "$")
        let result = TreePrinter.printTree(root: tree, options: options)
        print(result)
        let lines = result.split(separator: "\n")
        XCTAssertEqual(lines.count, 7)
        XCTAssertEqual(lines[0], "Root")
        
        XCTAssert(lines[1].starts(with: "├── "))
        XCTAssert(lines[1].contains("Branch Depth One A"))
        
        XCTAssert(lines[2].contains(options.verticalLine))
        XCTAssert(lines[2].contains(options.intermediateConnector))
        XCTAssert(lines[2].contains("Branch Depth Two A"))
        
        XCTAssert(lines[3].contains(options.verticalLine))
        XCTAssert(lines[3].contains(options.intermediateConnector))
        XCTAssert(lines[3].contains("Branch Depth Two B"))
        
        let regex = try! NSRegularExpression(pattern: options.verticalLine, options: .ignoreMetacharacters)
        
        XCTAssertEqual(2, regex.numberOfMatches(in: String(lines[4]), options: .withTransparentBounds, range: NSRange(lines[4].startIndex..., in: lines[4])))
        XCTAssert(lines[4].contains(options.finalConnector))
        XCTAssertFalse(lines[4].contains(options.intermediateConnector))
        XCTAssert(lines[4].contains("Leaf Depth Three"))
        
        XCTAssert(lines[5].contains(options.verticalLine))
        XCTAssert(lines[5].contains(options.finalConnector))
        XCTAssert(lines[5].contains("Branch Depth Two C"))
        
        XCTAssertFalse(lines[6].contains(options.verticalLine))
        XCTAssert(lines[6].contains(options.finalConnector))
        XCTAssert(lines[6].contains("Branch Depth One B"))
    }
    
    func testAlternateIntermediate() {
        let tree = TreeNode.sampleTree
        let options = TreePrinter.TreePrinterOptions(intermediateConnector: "*")
        let result = TreePrinter.printTree(root: tree, options: options)
        print(result)
        let lines = result.split(separator: "\n")
        XCTAssertEqual(lines.count, 7)
        XCTAssertEqual(lines[0], "Root")
        
        XCTAssert(lines[1].starts(with: "*── "))
        XCTAssert(lines[1].contains("Branch Depth One A"))
        
        XCTAssert(lines[2].contains(options.verticalLine))
        XCTAssert(lines[2].contains(options.intermediateConnector))
        XCTAssert(lines[2].contains("Branch Depth Two A"))
        
        XCTAssert(lines[3].contains(options.verticalLine))
        XCTAssert(lines[3].contains(options.intermediateConnector))
        XCTAssert(lines[3].contains("Branch Depth Two B"))
        
        let regex = try! NSRegularExpression(pattern: options.verticalLine, options: .ignoreMetacharacters)
        
        XCTAssertEqual(2, regex.numberOfMatches(in: String(lines[4]), options: .withTransparentBounds, range: NSRange(lines[4].startIndex..., in: lines[4])))
        XCTAssert(lines[4].contains(options.finalConnector))
        XCTAssertFalse(lines[4].contains(options.intermediateConnector))
        XCTAssert(lines[4].contains("Leaf Depth Three"))
        
        XCTAssert(lines[5].contains(options.verticalLine))
        XCTAssert(lines[5].contains(options.finalConnector))
        XCTAssert(lines[5].contains("Branch Depth Two C"))
        
        XCTAssertFalse(lines[6].contains(options.verticalLine))
        XCTAssert(lines[6].contains(options.finalConnector))
        XCTAssert(lines[6].contains("Branch Depth One B"))
    }
    
    func testAlternateFinal() {
        let tree = TreeNode.sampleTree
        let options = TreePrinter.TreePrinterOptions(finalConnector: "\\")
        let result = TreePrinter.printTree(root: tree, options: options)
        print(result)
        let lines = result.split(separator: "\n")
        XCTAssertEqual(lines.count, 7)
        XCTAssertEqual(lines[0], "Root")
        
        XCTAssert(lines[1].starts(with: "├── "))
        XCTAssert(lines[1].contains("Branch Depth One A"))
        
        XCTAssert(lines[2].contains(options.verticalLine))
        XCTAssert(lines[2].contains(options.intermediateConnector))
        XCTAssert(lines[2].contains("Branch Depth Two A"))
        
        XCTAssert(lines[3].contains(options.verticalLine))
        XCTAssert(lines[3].contains(options.intermediateConnector))
        XCTAssert(lines[3].contains("Branch Depth Two B"))
        
        let regex = try! NSRegularExpression(pattern: options.verticalLine, options: .ignoreMetacharacters)
        
        XCTAssertEqual(2, regex.numberOfMatches(in: String(lines[4]), options: .withTransparentBounds, range: NSRange(lines[4].startIndex..., in: lines[4])))
        XCTAssert(lines[4].contains(options.finalConnector))
        XCTAssertFalse(lines[4].contains(options.intermediateConnector))
        XCTAssert(lines[4].contains("Leaf Depth Three"))
        
        XCTAssert(lines[5].contains(options.verticalLine))
        XCTAssert(lines[5].contains(options.finalConnector))
        XCTAssert(lines[5].contains("Branch Depth Two C"))
        
        XCTAssertFalse(lines[6].contains(options.verticalLine))
        XCTAssert(lines[6].contains(options.finalConnector))
        XCTAssert(lines[6].contains("Branch Depth One B"))
    }
    
    func testAlternateSuffix() {
        let tree = TreeNode.sampleTree
        let options = TreePrinter.TreePrinterOptions(connectorSuffix: "~~")
        let result = TreePrinter.printTree(root: tree, options: options)
        print(result)
        let lines = result.split(separator: "\n")
        XCTAssertEqual(lines.count, 7)
        XCTAssertEqual(lines[0], "Root")
        
        XCTAssert(lines[1].starts(with: "├~~"))
        XCTAssert(lines[1].contains("Branch Depth One A"))
        
        XCTAssert(lines[2].contains(options.verticalLine))
        XCTAssert(lines[2].contains(options.intermediateConnector))
        XCTAssert(lines[2].contains("Branch Depth Two A"))
        
        XCTAssert(lines[3].contains(options.verticalLine))
        XCTAssert(lines[3].contains(options.intermediateConnector))
        XCTAssert(lines[3].contains("Branch Depth Two B"))
        
        let regex = try! NSRegularExpression(pattern: options.verticalLine, options: .ignoreMetacharacters)
        
        XCTAssertEqual(2, regex.numberOfMatches(in: String(lines[4]), options: .withTransparentBounds, range: NSRange(lines[4].startIndex..., in: lines[4])))
        XCTAssert(lines[4].contains(options.finalConnector))
        XCTAssertFalse(lines[4].contains(options.intermediateConnector))
        XCTAssert(lines[4].contains("Leaf Depth Three"))
        
        XCTAssert(lines[5].contains(options.verticalLine))
        XCTAssert(lines[5].contains(options.finalConnector))
        XCTAssert(lines[5].contains("Branch Depth Two C"))
        
        XCTAssertFalse(lines[6].contains(options.verticalLine))
        XCTAssert(lines[6].contains(options.finalConnector))
        XCTAssert(lines[6].contains("Branch Depth One B"))
    }
    
    func testAlternateToTheMax() {
        let tree = TreeNode.sampleTree
        let options = TreePrinter.TreePrinterOptions(spacesPerDepth: 2,
                                                     spacer: "SPC",
                                                     verticalLine: "$",
                                                     intermediateConnector: "*",
                                                     finalConnector: "\\",
                                                     connectorSuffix: "~~")
        let result = TreePrinter.printTree(root: tree, options: options)
        print(result)
        let lines = result.split(separator: "\n")
        XCTAssertEqual(lines.count, 7)
        XCTAssertEqual(lines[0], "Root")
        
        XCTAssert(lines[1].starts(with: "*~~"))
        XCTAssert(lines[1].contains("Branch Depth One A"))
        
        XCTAssert(lines[2].contains(options.verticalLine))
        XCTAssert(lines[2].contains(options.intermediateConnector))
        XCTAssert(lines[2].contains("Branch Depth Two A"))
        
        XCTAssert(lines[3].contains(options.verticalLine))
        XCTAssert(lines[3].contains(options.intermediateConnector))
        XCTAssert(lines[3].contains("Branch Depth Two B"))
        
        let regex = try! NSRegularExpression(pattern: options.verticalLine,
                                             options: .ignoreMetacharacters)
        
        XCTAssertEqual(2, regex.numberOfMatches(in: String(lines[4]), options: .withTransparentBounds, range: NSRange(lines[4].startIndex..., in: lines[4])))
        XCTAssert(lines[4].contains(options.finalConnector))
        XCTAssertFalse(lines[4].contains(options.intermediateConnector))
        XCTAssert(lines[4].contains("Leaf Depth Three"))
        
        XCTAssert(lines[5].contains(options.verticalLine))
        XCTAssert(lines[5].contains(options.finalConnector))
        XCTAssert(lines[5].contains("Branch Depth Two C"))
        
        XCTAssertFalse(lines[6].contains(options.verticalLine))
        XCTAssert(lines[6].contains(options.finalConnector))
        XCTAssert(lines[6].contains("Branch Depth One B"))
    }
    
    func testOneItemAtDepthOne() {
        let options = TreePrinter.TreePrinterOptions()
        let result = TreePrinter.printTree(root: TreeNode.sampleOneItemAtDepthZeroTree)
        print(result)
        let lines = result.split(separator: "\n")
        let line = lines[4]
        
        XCTAssertTrue(line.contains(options.verticalLine))
    }
    
    func testAlwaysPassingBootstrapper() {
        let options = TreePrinter.TreePrinterOptions(
            spacesPerDepth: 4,
            spacer: " ",
            verticalLine: "│",
            intermediateConnector: "├",
            finalConnector: "└",
            connectorSuffix: "── ")
        print(TreePrinter.printTree(root: TreeNode.sampleTree, options: options))
    }
    
    func testOnlyOneFirstLevelNode() {
        let tree = TreeNode(title: "Root",
                            subNodes: [
                                TreeNode(title: "Level One", subNodes: [
                                    TreeNode(title: "Level Two A", subNodes: []),
                                    TreeNode(title: "Level Two B", subNodes: [])
                                ])
                            ])
        let result = TreePrinter.printTree(root: tree)
        print(result)
        let lines = result.split(separator: "\n")
        
        XCTAssertFalse(lines[2].first == "│")
    }
    
    func testSeveralDepthsWithLeaves() {
        let options = TreePrinter.TreePrinterOptions()
        let tree = TreeNode(title: "Root", subNodes: [
            TreeNode(title: "Depth One A", subNodes: []),
            TreeNode(title: "Depth One B", subNodes: [
                TreeNode(title: "Depth Two A", subNodes: []),
                TreeNode(title: "Depth Two B", subNodes: []),
                TreeNode(title: "Depth Two C", subNodes: [
                    TreeNode(title: "Depth Three A", subNodes: [
                        TreeNode(title: "Depth Four A", subNodes: [])
                    ])
                ])
            ]),
            TreeNode(title: "Depth One C", subNodes: [
                TreeNode(title: "Depth Two D", subNodes: [
                    TreeNode(title: "Depth Three B", subNodes: [
                        TreeNode(title: "Depth Four B", subNodes: [
                            TreeNode(title: "Depth Five", subNodes: [])
                        ])
                    ]),
                    TreeNode(title: "Depth Three C", subNodes: [])
                ]),
                TreeNode(title: "Depth Two E", subNodes: [])
            ]),
            TreeNode(title: "Depth One D", subNodes: [])
        ])
        let result = TreePrinter.printTree(root: tree, options: options)
        print(result)
        
        let lines = result.split(separator: "\n").map { String($0) }
        
        XCTAssertEqual(16, lines.count)
        // Root
        XCTAssertEqual(lines[0], tree.name)
        // Depth One A, Depth One B
        XCTAssertTrue(lines[1].starts(with: options.intermediateConnector))
        XCTAssertTrue(lines[2].starts(with: options.intermediateConnector))
        // Depth Two A
        XCTAssertTrue(lines[3].starts(with: options.verticalLine))
        XCTAssertTrue(lines[3].contains(options.intermediateConnector))
        // Depth Two B
        XCTAssertTrue(lines[4].starts(with: options.verticalLine))
        XCTAssertTrue(lines[4].contains(options.intermediateConnector))
        // Depth Two C
        XCTAssertTrue(lines[5].starts(with: options.verticalLine))
        XCTAssertTrue(lines[5].contains(options.finalConnector))
        // Depth Three A
        XCTAssertEqual(1, getMatchCount(options.verticalLine, in: lines[6]))
        XCTAssertTrue(lines[6].contains(options.finalConnector))
        // Depth Four A
        XCTAssertEqual(1, getMatchCount(options.verticalLine, in: lines[7]))
        XCTAssertTrue(lines[7].contains(options.finalConnector))
        // Depth One C
        XCTAssertTrue(lines[8].starts(with: options.intermediateConnector))
        // Depth Two D
        XCTAssertEqual(1, getMatchCount(options.verticalLine, in: lines[9]))
        XCTAssertTrue(lines[9].contains(options.intermediateConnector))
        // Depth Three B
        XCTAssertEqual(2, getMatchCount(options.verticalLine, in: lines[10]))
        XCTAssertTrue(lines[10].contains(options.intermediateConnector))
        // Depth Four B
        XCTAssertEqual(3, getMatchCount(options.verticalLine, in: lines[11]))
        XCTAssertTrue(lines[11].contains(options.finalConnector))
        // Depth Five
        XCTAssertEqual(3, getMatchCount(options.verticalLine, in: lines[12]))
        XCTAssertTrue(lines[12].contains(options.finalConnector))
        // Depth Three C
        XCTAssertEqual(2, getMatchCount(options.verticalLine, in: lines[13]))
        XCTAssertTrue(lines[13].contains(options.finalConnector))
        // Depth Two E
        XCTAssertEqual(1, getMatchCount(options.verticalLine, in: lines[14]))
        XCTAssertTrue(lines[14].contains(options.finalConnector))
        // Depth One D
        XCTAssertTrue(lines[15].starts(with: options.finalConnector))
    }
    
    private func getMatchCount(_ pattern: String, in haystack: String) -> Int {
        let regex = try! NSRegularExpression(pattern: pattern,
                                             options: .ignoreMetacharacters)
        
        return regex.numberOfMatches(in: haystack,
                                     options: .withTransparentBounds,
                                     range: NSRange(haystack.startIndex..., in: haystack))
    }

}
