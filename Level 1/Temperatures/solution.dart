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
  Dart solution to the "Temperatures" CodinGame challenge.

  Visit http://www.codingame.com/ for more information.
*/

import "dart:io";

void main() {
    var N = readInt();
    
    print(N == 0 ? 0 : closest());
}

int closest() {
    var min = 5526 + 1;
    
    var T = readListInt();
    for (var t in T) {
        var dif = t.abs() - min.abs();
        if ((dif < 0) || ((dif == 0) && (t > 0))) {
            min = t;
        }
    }
    
    return min;
}

String readString() => stdin.readLineSync();

int readInt() => int.parse(readString());

List<int> readListInt()
    => readString().split(' ').map((e) => int.parse(e)).toList();
