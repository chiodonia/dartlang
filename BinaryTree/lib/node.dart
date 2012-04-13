/**
 * A generic [Node] interface for a simple binary tree.
 * 
 * NOTE: use of generics. 
 */
interface Node<V> default NodeFactory<V> {
  
  /** **true* if the node is a leaf. */
  bool isLeaf();

  /** Traverse the tree and apply the function [f] to each [Node] */
  void traverse(f);  

  /**
   * Constructor for a [Node] with a [value] and two optional [Node], [left] and right.
   * 
   * NOTE: use of generics. 
   */
  Node(V value, [Node left, Node right]);

  /**
   * Constructor for a [Node] leaf with a [value].
   * 
   * NOTE: Named Constructor. 
   */
  Node.leaf(V value);

  //NOTE: optional types, force implementation to define this field
  var value;

}

/**
 * [Node]'s default class.
 */
class NodeFactory<V>  {
  
  /** 
   * [Node]'s factory.
   *
   * A [Node] may have [left] and [right] children, on this case is a [BinaryNode].
   * A [Node] without [left] and [right] children is a [LeafNode].
   * Throws an [IllegalArgumentException] if [value] is null.
   *
   * NOTE: constructor name and optional params with default value
   */
  factory Node(V value, [Node left = null, Node right = null]) {
    if (value == null) {
      throw new IllegalArgumentException("Value can't be null.");
    }
    if (left == null && right == null) {
      return new LeafNode(value);
    } else {
      return new BinaryNode(value, left, right);
    }
  }
  
  /** 
   * Leaf's factory.
   *
   * A [Node] without [left] and [right] children is a [LeafNode].
   *
   * NOTE: constructor name
   */
  factory Node.leaf(V value) => new Node(value, null, null);
}

/**
 * Abstract [Node].
 */
class AbstractNode<V> implements Node {

  /**
   * Overloading the + oprator for a [Node].
   * 
   * NOTE: Works only in objects since binaryOperators take only one parameter (the second is this).
   */
  operator +(V other) {
    this.value += other;
  }
}

/**
 * Binary [Node].
 */
class BinaryNode<V> extends AbstractNode {
  
  //NOTE: default is public
  var value;
  var _id;

  //NOTE: _ stand for private.
  final _left;
  final _right;
  
  bool isLeaf() => (!this.hasLeft() && !this.hasRight());

  traverse(f) {
    f(this);
    if (hasLeft()) {
      this._left.traverse(f);
    }
    if (hasRight()) {
      this._right.traverse(f);
    }
  }
  
  //NOTE: Compact constructor syntax. Node this._left stand for parameter and this._left = param (only in constructor!)
  BinaryNode(V this.value, Node this._left, Node this._right);
  
  //NOTE: Short function syntax: => stand for evaluate and return
  Node get left() => _left;
  Node get right() => _right;

  //NOTE: Getter and setter.
  V get id() => _id;
  set id(V id) => this._id = id;
  
  /** **true* if there is a left [Node] */
  bool hasLeft() => this._left != null;

  /** **true* if there is a right [Node] */
  bool hasRight() => this._right != null;
  
  /** Called when infoking a method not implemented. */
  // NOTE: Does not work if in NodeFactory!
  noSuchMethod(String functionName, List args) {
    //NOTE: String interpolation!
    print("Not implemented fuction: $functionName with args: $args");
  }

  // NOTE: toString
  String toString() => "${value.toString()}, left: ${_left!=null?"yes":"no"}, right: ${_right!=null?"yes":"no"}";

}

/**
 * Leaf [Node].
 */
class LeafNode<V> extends AbstractNode {
  
  //NOTE: default is public
  var value;

  /** Constructor */
  LeafNode(V this.value);
  
  /** Aways **true* */
  bool isLeaf() => true;

  traverse(f) {
    f(this);
  }
  
  // NOTE: toString
  String toString() => value.toString();
}
