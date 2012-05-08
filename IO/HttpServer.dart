#import('dart:io');

main() {
  //See http://api.dartlang.org/io/HttpServer.html
  var server = new HttpServer();
  
  server.addRequestHandler((HttpRequest request) => true, (req, res) {
    print("Now serving: ${req.uri}");
    res.headers.set("Content-Type", "text/plain");
    res.outputStream.writeString("Hello World, ${req.queryParameters['text']}\n");
    res.outputStream.close();
  });

  server.listen("127.0.0.1", 8080);
  print("Server running at http://127.0.0.1:8080/");
}  
  