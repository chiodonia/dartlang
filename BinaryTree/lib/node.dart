/**
 * A simple [Node]
 */
interface Node<V> default NodeFactory<V> {
  bool isLeaf();
  void traverse(f);  

  //Constructors
  Node(V value, [Node left, Node right]);
  //Constructors
  //Named Constructor
  Node.leaf(V value);

  // Private field, optional type, force implementation to define this field
  // Identify a [Node]
  
  //NOTE: optional types
  var value;
}

/**
 * Node's default class.
 */
class NodeFactory<V>  {
  /** 
   * Node's default implementations.
   * A [Node] may have [left] and [right] children, on this case is a [SimpleNode].
   * A [Node] without [left] and [right] children is a [LeafNode]
   * Throws an [IllegalArgumentException] if [id] is null.
   */
  //NOTE: constructor name and optional params with default value
  factory Node(V value, [Node left = null, Node right = null]) {
    if (left == null && right == null) {
     return new LeafNode(value);
    } else {
      return new BinaryNode(value, left, right);
    }
  }
  //NOTE: constructor name
  factory Node.leaf(V value) => new LeafNode(value);
}

//NOTE: abstract class
class AbstractNode<V> implements Node {
  //NOTE: operator overloading. Works only in objects since binaryOperators take only one parameter (the second is this)
  operator +(V other) {
    this.value += other;
  }
}

class BinaryNode<V> extends AbstractNode {
  //NOTE: default is public
  var value;
  //NOTE: _ stand for private.
  final _left;
  //_right is not final for demostrating setters.
  var _right;
  
  bool isLeaf() => false;

  traverse(f) {
    f(this);
    if (this._left != null) {
      this._left.traverse(f);
    }
    if (this._right != null) {
      this._right.traverse(f);
    }
  }
  
  //NOTE: Compact constructor syntax. Node this._left stand for parameter and this._left = param (only in constructor!)
  BinaryNode(V this.value, Node this._left, Node this._right);
  
  //NOTE: Short function syntax: => stand for evaluate and return
  //NOTE: Getters
  Node get left() => _left;
  Node get right() => _right;

  //NOTE: Setters
  set right(Node rightNode) => this._right = rightNode;

  // Does not work in NodeFactory!
  noSuchMethod(String functionName, List args) {
    //NOTE: String interpolation!
    print("Not implemented fuction: $functionName with args: $args");
  }

  String toString() => "${value.toString()}, left: ${_left!=null?"yes":"no"}, right: ${_right!=null?"yes":"no"}";

}

/**
 *
 */
class LeafNode<V> extends AbstractNode {
  var value;
  LeafNode(V this.value);
  bool isLeaf() => true;

  traverse(f) {
    f(this);
  }
  
  String toString() => value.toString();
}
