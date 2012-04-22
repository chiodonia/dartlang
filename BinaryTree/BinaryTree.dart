#import('dart:html');
#import('lib/binarytree.dart', prefix: 'tree');
#import('lib/dartunit.dart');

/** Entry method. */
void main() {
  //NOTE: Use of factory class
  tree.Node leaf1 = new tree.Node<String>("my first leaf");
  //NOTE: Use of named constructor
  tree.Node leaf2 = new tree.Node<String>.leaf("my second leaf");
  //NOTE: dart is able to infer the Parameterized types (aka generics) 
  tree.Node nodeA = new tree.Node("my node", leaf1, leaf2);

  //NOTE: dart is able to infer the Parameterized types (aka generics) 
  tree.Node leaf4 = new tree.Node(3);
  tree.Node leaf3 = new tree.Node.leaf(2);
  tree.Node nodeB = new tree.Node(10, leaf3, leaf4);
  tree.Node nodeC = new tree.Node(20, nodeB);

  assertTrue(leaf1 is tree.LeafNode, "leaf1 is of type LeafNode");
  assertTrue(nodeA is tree.BinaryNode, "leaf1 is of type BinaryNode");

  assertEquals("my node", nodeA.value, "Value is set as expected");
  assertEquals(3, leaf4.value, "Value is set as expected");
  assertSameInstance(leaf4, nodeB.right, "Node is set as expected");

  //NOTE: Not implemented: http://dartwatch.com/index.php/tag/nosuchmethod/
//  print(nodeB["thisDoesNotExists"]);
//  print(nodeB.thisDoesNotExists);
  
  //NOTE: passing a function as parameter
  nodeC.traverse(tree.loggerFucntion);

  //NOTE: using a closure
  var logger = tree.loggerClosure();
  nodeA.traverse(logger);
  
  assertEquals(10, nodeB.value, "Value is set as expected");
  assertEquals(2, nodeB.left.value, "Value is set as expected");
  assertEquals(3, nodeB.right.value, "Value is set as expected");
  var add3 = tree.add(3);
  nodeB.traverse(add3);
  assertEquals(13, nodeB.value, "Value is set as expected by add3");
  assertEquals(5, nodeB.left.value, "Value is set as expected by add3");
  assertEquals(6, nodeB.right.value, "Value is set as expected by add3");
  
  //NOTE:toString
  print(leaf1);
  print(nodeB);
  
  //NOTE: use of operator overloading
  assertEquals(5, leaf3.value, "Value is set as expected");
  leaf3+50;
  assertEquals(55, leaf3.value, "Value is set as expected by operator +");

  assertEquals("my first leaf", leaf1.value, "Value is set as expected");
  leaf1+"!";
  assertEquals("my first leaf!", leaf1.value, "Value is set as expected by operator +");

  //NOTE: getter and setter
  nodeB.id = "test";
  assertEquals("test", nodeB.id, "Setters and getters");
  assertEquals("0.1", tree.version, "Version is correct");

  //Draw the tries
  //tree.draw(nodeA, "#treeA");
  tree.draw(nodeC, "#treeC");
}

