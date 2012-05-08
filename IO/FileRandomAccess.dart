#import('dart:io');

main() {
  var options = new Options();
  var result = [];

  new File(options.script).open(FileMode.READ, (RandomAccessFile file) {
    var semicolon = ';'.charCodeAt(0);
    // Callback to deal with each byte.
    void onByte(byte) {
      result.add(byte);
      if (byte == semicolon) {
        print(new String.fromCharCodes(result));
        file.close(() => null);
      } else {
        file.readByte(onByte);
      }
    }

    // Read the first byte to get started.
    file.readByte(onByte);
  });
}