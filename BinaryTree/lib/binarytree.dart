#library("graph:tree:binary");

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
