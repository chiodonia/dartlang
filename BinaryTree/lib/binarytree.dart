#library("graph:tree:binary");

#source("node.dart");

//NOTE: public
final version = "0.1";

//NOTE: private!
final _version = "0.2";

final _separatorChar = "-";

//NOTE: a function, Function is optional
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

//NOTE: a closure, Function is optional
Function loggerClosure([String label = "VALUE"]) {
  return (node) => print("${label}: ${node.value}");
}

//NOTE: a closure, Function is optional
Function add([num n = 0]) {
  return (Node node) { node.value += n;};
}

//NOTE: private
_separator(len) {
  var str = _separatorChar;
  for (var x = 0; x < len; x++) {
    str = str.concat(_separatorChar);
  }
  return str;
}
