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

}
