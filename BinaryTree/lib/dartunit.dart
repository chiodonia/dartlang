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
 * Assert that [actual] is **false*.
 *
 * [actual] is the actual value.
 * [message] describes the assertion (documentation).
 */
void assertFalse(actual, [String message]) {
  _init();
  //NOTE: First class functions
  var equals = (expectedValue, actualValue) => expectedValue == actualValue;
  _result(false, actual, equals, message);
}

/** 
 * Assert that [actual] is **true*.
 *
 * [actual] is the actual value.
 * [message] describes the assertion (documentation).
 */
void assertTrue(actual, [String message]) {
  _init();
  //NOTE: First class functions
  var equals = (expectedValue, actualValue) => expectedValue == actualValue;
  _result(true, actual, equals, message);
}

/** 
 * Assert that [expected] and [actual] are equal.
 *
 * [expected] is the expected value.
 * [actual] is the actual value.
 * [message] describes the assertion (documentation).
 */
void assertEquals(expected, actual, [String message]) {
  _init();
  //NOTE: First class functions
  var equals = (expectedValue, actualValue) => expectedValue == actualValue;
  _result(expected, actual, equals, message);
}

/** 
 * Assert that [expected] and [actual] are not equal.
 *
 * [expected] is the expected value.
 * [actual] is the actual value.
 * [message] describes the assertion (documentation).
 */
void assertNotEquals(expected, actual, [String message]) {
  _init();
  //NOTE: First class functions
  var notEquals = (expectedValue, actualValue) => expectedValue != actualValue;
  _result(expected, actual, notEquals, message);
}

/** 
 * Assert that [expected] and [actual] are the same object.
 *
 * [expected] is the expected value.
 * [actual] is the actual value.
 * [message] describes the assertion (documentation).
 */
void assertSameInstance(expected, actual, [String message]) {
  _init();
  //NOTE: First class functions
  var sameInstance = (expectedValue, actualValue) => expectedValue === actualValue;
  _result(expected, actual, sameInstance, message);
}

/** 
 * Assert that [expected] and [actual] are not the same object.
 *
 * [expected] is the expected value.
 * [actual] is the actual value.
 * [message] describes the assertion (documentation).
 */
void assertNotSameInstance(expected, actual, [String message]) {
  _init();
  //NOTE: First class functions
  var notSameInstance = (expectedValue, actualValue) => expectedValue !== actualValue;
  _result(expected, actual, notSameInstance, message);
}

/** 
 * Handle [html] and [cons].
 *
 * [expected] is the expected value.
 * [actual] is the actual value.
 * [fun] is the function to be evaluated value.
 * [message] describes the assertion (documentation).
 */
_result(expected, actual, fun, [String message]) {
  if (html) {
    _html(expected, actual, fun, message);
  }
  if (cons) {
    _cons(expected, actual, fun, message);
  }
}

/** 
 * Pring on the console [cons].
 *
 * [expected] is the expected value.
 * [actual] is the actual value.
 * [fun] is the function to be evaluated value.
 * [message] describes the assertion (documentation).
 */
_cons(expected, actual, fun, [String message]) {
  print("${fun(expected, actual)?'OK':'NOK'}, ${(message==null) ? '' :message}, ${expected.toString()}, ${actual.toString()}");
}

/** 
 * Inject HTML [html] on [containerSelector].
 *
 * [expected] is the expected value.
 * [actual] is the actual value.
 * [fun] is the function to be evaluated value.
 * [message] describes the assertion (documentation).
 */
_html(expected, actual, fun, [String message]) {
  TableRowElement row = new Element.tag("tr");
  TableCellElement messageCell = new Element.tag("td");
  messageCell.text = (message==null)? '' :message;
  TableCellElement expectedCell = new Element.tag("td");
  expectedCell.text = expected.toString();
  TableCellElement actualCell = new Element.tag("td");
  actualCell.text = actual.toString();
  row.nodes.add(messageCell);
  row.nodes.add(expectedCell);
  row.nodes.add(actualCell);
  row.bgColor = fun(expected, actual)?'green':'red';
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

