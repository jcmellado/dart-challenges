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
  Dart solution to the "MIME Type" CodinGame challenge.

  Visit http://www.codingame.com/ for more information.
*/

import "dart:io";

void main() {
    var N = readInt();
    var Q = readInt();
    
    var types = new Map<String, String>();
    for (var i = 0; i < N; ++ i) {
        var line = readString().split(" ");
        
        types[line[0].toLowerCase()] = line[1];
    }
    
    var files = new List<String>.generate(Q, (_) => readString().toLowerCase());
    
    for (var file in files) {
        var mime;
    
        var dot = file.lastIndexOf(".");
        if (dot != -1) {
            mime = types[file.substring(dot + 1)];
        }
        
        print(mime == null ? "UNKNOWN" : mime);
    }
}

int readInt() => int.parse(readString());

String readString() => stdin.readLineSync();
