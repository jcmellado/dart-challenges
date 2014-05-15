/*
  Copyright (c) 2014 Juan Mellado

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
*/

/*
  Dart solution to the "Defibrillators" CodinGame challenge.

  Visit http://www.codingame.com/ for more information.
*/

import "dart:io";
import "dart:math";

void main() {
    var longitude = readDouble();
    var latitude = readDouble();
    var N = readInt();
    var defibrillators = new List<Defibrillator>.generate(N,
        (_) => new Defibrillator(readString()));
    
    var name;
    var min;

    for (var defibrillator in defibrillators) {
        var x = (longitude - defibrillator.longitude)
            * cos((defibrillator.latitude + latitude) / 2);
        var y = latitude - defibrillator.latitude;
        var d = sqrt(x * x + y * y) * 6371;
        
        if (min == null || d < min) {
            min = d;
            name = defibrillator.name;
        }
    }

    print(name);
}

class Defibrillator {
    String name;
    double longitude;
    double latitude;
    
    Defibrillator(String line) {
        var fields = line.split(";");
        name = fields[1];
        longitude = toDouble(fields[4]);
        latitude = toDouble(fields[5]);
    }
}

String readString() => stdin.readLineSync();

int readInt() => int.parse(readString());

double readDouble() => toDouble(readString());

double toDouble(String value) => double.parse(value.replaceFirst(",", "."));
