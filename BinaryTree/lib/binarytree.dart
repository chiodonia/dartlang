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

//final height = 160;
//final width = 180;
html.CanvasRenderingContext2D ctx;
html.CanvasElement canvasElement;

/**
 * Draw a tree on a canvas element.
 *
 */
void draw(Node tree, String selector) {
  canvasElement = html.document.query(selector);
  print("${canvasElement.width} ${canvasElement.height}");
  ctx = canvasElement.getContext("2d");
  _drawTree(tree);
//  _addHandlers();
}

void _drawEdge(num x1, num y1, num x2, num y2) {
  ctx.lineWidth = 1;
  ctx.strokeStyle = "black";
  ctx.moveTo(x1, y1);
  ctx.lineTo(x2, y2);
  ctx.stroke();
}

num _drawNode(String text, num x, num y) {
  ctx.lineWidth = 1;
  ctx.fillStyle = "gray";

  var tm = ctx.measureText(text);
  var l = tm.width + (2*_nodePadding);
  
  ctx.fillRect(x, y, l, _nodeHeight);

  ctx.strokeStyle = "black";
  ctx.strokeText(text, x+_nodePadding, y+(_nodeHeight/2));
  return l;
}

void _drawTree(Node tree) {
  var x = canvasElement.width / 2;
  var level = 0;
  var node1l = _drawNode(tree.value.toString(), x, _nodePadding);
  level += 1;
  var node2l = _drawNode("left", (x-node1l-(_nodePadding*(level))), (_nodePadding*2) + (_nodeHeight * (level)));
  var node3l = _drawNode("right", (x+node1l+(_nodePadding*(level))), (_nodePadding*2) + (_nodeHeight * (level)));
  _drawEdge(x+node1l/2, ((_nodeHeight*level)+(_nodePadding*level)), x+node1l/2-(node2l/2)-(_nodePadding*level), ((_nodeHeight*level)+(_nodePadding*level))+_nodePadding);
  _drawEdge(x+node1l/2, ((_nodeHeight*level)+(_nodePadding*level)), x+node1l/2+(node3l/2)+(_nodePadding*level), ((_nodeHeight*level)+(_nodePadding*level))+_nodePadding);
}

//void _addHandlers() {
 // canvasElement..onmousemove = (e) { onMouseMove(e); };
 // canvasElement.onmousedown = (e) { onMouseDown(e); };
// }

void onMouseMove(MouseEvent event) {
}

void onMouseDown(MouseEvent event) {
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
