#import('dart:io');

main() {
  new Timer(5000, (Timer t) => print('timer'));
  print('end of main');
}