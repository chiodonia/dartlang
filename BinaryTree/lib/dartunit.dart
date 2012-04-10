#library("dartunit:assertion");
#import('dart:html');

final version = "0.1";

var containerSelector = '#dartunit';

var _container;

var _results;

var cons = true; 
var html = true; 

void assertEquals(expected, actual, [String message]) {
  _init();
  _result(expected, actual, message);
}

_result(expected, actual, [String message]) {
  if (html) {
    _html(expected, actual, message);
  }
  if (cons) {
    _cons(expected, actual, message);
  }
}

_cons(expected, actual, [String message]) {
  print("${expected==actual?'OK':'NOK'}, ${(message==null)? '${expected.toString()} == ${actual.toString()}' :message}, ${expected.toString()}, ${actual.toString()}");
}

_html(expected, actual, [String message]) {
  TableRowElement row = new Element.tag("tr");
  TableCellElement messageCell = new Element.tag("td");
  messageCell.text = (message==null)? '${expected.toString()} == ${actual.toString()}' :message;
  TableCellElement expectedCell = new Element.tag("td");
  expectedCell.text = expected.toString();
  TableCellElement actualCell = new Element.tag("td");
  actualCell.text = actual.toString();
  row.nodes.add(messageCell);
  row.nodes.add(expectedCell);
  row.nodes.add(actualCell);
  row.bgColor = expected==actual?'green':'red';
  _results.nodes.add(row);
}

_init() {
  if (_container==null) {
    _container = document.query(containerSelector);
    _results = new Element.html(''''
<table>
  <tr style="background-color:gray;">
    <th>Message</th>
    <th>Expected</th>
    <th>Actual</th>
  </tr>
</table>
''');
    _container.elements.add(_results);
  }
}

