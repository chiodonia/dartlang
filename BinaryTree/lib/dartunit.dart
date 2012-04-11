#library("dartunit:assertion");
#import('dart:html');

/** 
 * A library provising some testing stuff. 
 */

/** Version. */
final version = "0.1";

/** Where the result is injected. */
var containerSelector = '#dartunit';

/** **true* for logging on the console. */
var cons = true; 
/** **true* for injecting HTML. */
var html = true; 

var _container;
var _results;

/** 
 * Assert that [expected] and [actual] are equal.
 *
 * [expected] is the expected value.
 * [actual] is the actual value.
 * [message] describes the assertion (documentation).
 */
void assertEquals(expected, actual, [String message]) {
  _init();
  _result(expected, actual, message);
}

/** 
 * Handle [html] and [cons].
 *
 * [expected] is the expected value.
 * [actual] is the actual value.
 * [message] describes the assertion (documentation).
 */
_result(expected, actual, [String message]) {
  if (html) {
    _html(expected, actual, message);
  }
  if (cons) {
    _cons(expected, actual, message);
  }
}

/** 
 * Pring on the console [cons].
 *
 * [expected] is the expected value.
 * [actual] is the actual value.
 * [message] describes the assertion (documentation).
 */
_cons(expected, actual, [String message]) {
  print("${expected==actual?'OK':'NOK'}, ${(message==null) ? '${expected.toString()} == ${actual.toString()}' :message}, ${expected.toString()}, ${actual.toString()}");
}

/** 
 * Inject HTML [html] on [containerSelector].
 *
 * [expected] is the expected value.
 * [actual] is the actual value.
 * [message] describes the assertion (documentation).
 */
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

/** 
 * Initialize the library querying the DOM (selector [containerSelector]) 
 * for the element to inject the test result.
 */
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

