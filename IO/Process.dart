#import('dart:io');

main() {
  //See http://api.dartlang.org/io/Process.html
  var p = new Process.start('ls', ['-l']);
  var stdoutStream = new StringInputStream(p.stdout);
  stdoutStream.onLine = () => print(stdoutStream.readLine());
  p.onExit = (exitCode) {
    print('exit code: $exitCode');
    p.close();
  };
}