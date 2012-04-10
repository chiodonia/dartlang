#import('dart:html');
#import('lib/binarytree.dart', prefix: 'tree');
#import('lib/dartunit.dart');

class BinaryTree {

  BinaryTree() {
  }

  void run() {
    write("Hello World!");
  }

  void write(String message) {
    // the HTML library defines a global "document" variable
    document.query('#status').innerHTML = message;
  }
}

void main() {
  // Use of factory class
  tree.Node leaf1 = new tree.Node<String>("my first leaf");
  // Use of named constructor
  tree.Node leaf2 = new tree.Node<String>.leaf("my second leaf");
  //NOTE: dart is able to infer the Parameterized types (aka generics) 
  tree.Node node = new tree.Node("my node", leaf1, leaf2);
  print(leaf1 is tree.LeafNode);
  print(leaf1 is tree.BinaryNode);
  print(leaf2 is tree.LeafNode);
  print(node is tree.BinaryNode);
  print(tree.version);

  print(node.value);
  print(node.left);
  print(node.right);
  print(node.left.value);
  // Not implemented: http://dartwatch.com/index.php/tag/nosuchmethod/
  print(node["thisDoesNotExists"]);
  print(node.thisDoesNotExists);
  
  //NOTE: passing a function as parameter
  node.traverse(tree.loggerFucntion);

  //NOTE: using a closure
  var logger = tree.loggerClosure();
  node.traverse(logger);
//  node.children.forEach((c) => print(c.id));
//  node.id = "test";
 // node.children.add(leaf2);
 // node.children.forEach((c) => print(c.id));
  
  
  //NOTE: dart is able to infer the Parameterized types (aka generics) 
  tree.Node leafB1 = new tree.Node(3);
  tree.Node leafB2 = new tree.Node.leaf(2);
  tree.Node nodeB = new tree.Node(10, leafB1, leafB2);
  print(nodeB.value);
  print(leafB1.value);
  print(leafB2.value);
  var add3 = tree.add(3);
  nodeB.traverse(add3);
  print(nodeB.value);
  print(leafB1.value);
  print(leafB2.value);
  
  //toString
  print(leafB2);
  print(nodeB);
  
  //NOTE: use of operator overloading
  leafB2+50;
  print(leafB2);
  leaf2+" ciao";
  print(leaf2);

  assertEquals(1,2,"1 == 2?");
  assertEquals(1,2);
  assertEquals("3","3", "3 == 3?");
  assertEquals("3","3");
}
