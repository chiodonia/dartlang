#import('dart:io');

main() {
  Options options = new Options();
  List result = [];

  //See http://api.dartlang.org/io/InputStream.html, http://api.dartlang.org/io/OutputStream.html
  InputStream stream = new File(options.script).openInputStream();
  int semicolon = ';'.charCodeAt(0);
  //Called when data are available!
  stream.onData = () {
    result.addAll(stream.read(1));
    if (result.last() == semicolon) {
      print(new String.fromCharCodes(result));
      stream.close();
    }
  };
}