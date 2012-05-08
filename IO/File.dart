#import('dart:io');

main() {
  //See: http://api.dartlang.org/dart_core/Options.html
  var options = new Options();
  var file = new File(options.script);
  //readAsText is asynchronous, see callback!
  file.readAsText(Encoding.ASCII, (text) => print(text));
}