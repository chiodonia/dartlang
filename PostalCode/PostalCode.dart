#import('dart:html');
#import('dart:json');

class PostalCode {

  var _place;
  
  PostalCode(Map<String, Object> this._place);
  
  String get countryCode() => _place["countryCode"];
  String get placeName() => _place["placeName"];
  String get postalCode() => _place["postalcode"];
  String get lng() => _place["lng"];
  String get lat() => _place["lat"];
  String get adminCode1() => _place["adminCode1"];
  String get adminName1() => _place["adminName1"];
  String get adminCode2() => _place["adminCode2"];
  String get adminName2() => _place["adminName2"];
  String get adminCode3() => _place["adminCode3"];
  String get adminName3() => _place["adminName3"];
  
  String toString() => "${postalCode}, ${placeName}, [${lng}, ${lat}]";
}

class GeonameClient {

  InputElement _nap = null;
  Element _data = null;
  
  GeonameClient(napSelector, dataSelector) {
    _nap = document.query(napSelector);
    _data = document.query(dataSelector);
  }

  void run() {
    _nap.on.keyUp.add(_(Event event) {
      print("DEBUG: keyUp event");
      if (_nap.value.length > 3) {
        XMLHttpRequest request = new XMLHttpRequest();
        print("DEBUG: Searching for ${_nap.value}");
        String url = "http://api.geonames.org/postalCodeLookupJSON?postalcode=${_nap.value}&country=CH&username=chiodonia";
        print("DEBUG: API call ${url}");

        request.open("GET", url);
      
        request.on.load.add((event) {
          resetData();
          print("DEBUG: ${request.responseText}");
          var result = JSON.parse(request.responseText);
          print("DEBUG: ${result["postalcodes"].length}");
          print("DEBUG: ${result["postalcodes"]}");

          result["postalcodes"].forEach((postalCode) {
            print("DEBUG: ${postalCode}");
            displayPlace(new PostalCode(postalCode));
          });
        });
        
        request.send();
      }
    });
  }
  
  displayPlace(place) {
    Element inner = new Element.tag('li');
    inner.innerHTML = place.toString();
    _data.elements.add(inner);
  }
  
  resetData() {
    _data.nodes.clear();
  }


}

void main() {
  new GeonameClient('#nap', '#data').run();
}
