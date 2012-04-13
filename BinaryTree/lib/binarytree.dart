#library("graph:tree:binary");
//NODE: used "html" prefix otherwise complaining that Node already defined (html lib defines an interface called Node!)
#import('dart:html', prefix: 'html');

/** 
 * A library provising a simple binary tree implementation. 
 */

//NOTE: public
#source("node.dart");

//NOTE: public
final version = "0.1";

//NOTE: private!
final _version = "0.2";

final _separatorChar = "-";

final _nodeHeight = 40;
final _nodePadding = 10;

/** 
 * A function that can be passed around while traversing the tree.
 *
 * [node] where the function is applied.
 * NOTE: Function is optional. 
 */
Function loggerFucntion(Node node) {
  //NOTE: multi-line string (''' same as """)
  var indent;
  (node.isLeaf()) ? indent = "   ": indent="";
  var str =
'''${indent}${_separator(node.value.length+1)}
${indent}|${node.value}|
${indent}${_separator(node.value.length+1)}''';
  print(str);
  //NOTE: will return null
}

/** 
 * A closure that can be passed around while traversing the tree.
 *
 * [label] the label pre-fixing the logging text.
 * [node] where the function is applied.
 */
Function loggerClosure([String label = "VALUE"]) {
  return (node) => print("${label}: ${node.value}");
}

/** 
 * A closure that can be passed around while traversing the tree.
 *
 * [n] the value to be added to [: node.value :].
 * [node] where the function is applied.
 */
Function add([num n = 0]) {
  return (Node node) { node.value += n;};
}

/**
 * Draw a tree on a canvas element.
 *
 */
void draw(Node tree, String selector) {
  html.CanvasElement canvasElement = html.document.query(selector);
  html.CanvasRenderingContext2D ctx = canvasElement.getContext("2d");
  _drawTree(ctx, canvasElement, tree);
}

/**
 * Draw an edge.
 */
void _drawEdge(ctx, num x1, num y1, num x2, num y2) {
  ctx.lineWidth = 1;
  ctx.strokeStyle = "black";
  ctx.moveTo(x1, y1);
  ctx.lineTo(x2, y2);
  ctx.stroke();
}

/**
 * Draw a node.
 */
void _drawNode(ctx, String text, num x, num y, num w) {
  ctx.lineWidth = 1;
  ctx.fillStyle = "gray";
  ctx.fillRect(x, y, w, _nodeHeight);
  ctx.strokeStyle = "black";
  ctx.strokeText(text, x+_nodePadding, y+(_nodeHeight/2));
}

/**
 * Recursivelly draw a tree.
 */
void _drawTree(ctx, canvasElement, Node node, [num level = 0, num x = 0, num y = 0]) {
  var nodeWidth = ctx.measureText(node.value.toString()).width + 2*_nodePadding;
  if (x==0 && y==0) {
    x = (canvasElement.width / 2) - (nodeWidth / 2);
    y = _nodePadding;
  }
  _drawNode(ctx, node.value.toString(), x, y, nodeWidth);
  if (!node.isLeaf()) {
    level++;
    var nextY = y + _nodeHeight + _nodePadding;
    var edgeX1 = x + (nodeWidth / 2);
    var edgeY1 = y + _nodeHeight;
    if (node.hasLeft()) {
      var nodeLeftWidth = ctx.measureText(node.left.value.toString()).width + 2*_nodePadding;
      var nextLeftX = x - _nodePadding - nodeLeftWidth;
      _drawEdge(ctx, edgeX1, edgeY1, nextLeftX + (nodeLeftWidth / 2), nextY);
      _drawTree(ctx, canvasElement, node.left, level, nextLeftX , nextY);
    } 
    if (node.hasRight()) {
      var nodeRightWidth = ctx.measureText(node.left.value.toString()).width + 2*_nodePadding;
      var nextRightX = x + nodeWidth + _nodePadding;
      _drawEdge(ctx, edgeX1, edgeY1, nextRightX + (nodeRightWidth / 2), nextY);
      _drawTree(ctx, canvasElement, node.right, level, nextRightX , nextY);
    } 
  }
}

/** 
 * Utility function to generate separators for logging nodes properly.
 * 
 * [len] length of the separator.
 */
_separator(len) {
  var str = _separatorChar;
  for (var x = 0; x < len; x++) {
    str = str.concat(_separatorChar);
  }
  return str;
}
