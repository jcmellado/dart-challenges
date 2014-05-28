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
  Dart solution to the "Scrabble" CodinGame challenge.

  Visit http://www.codingame.com/ for more information.
*/

import "dart:io";

void main() {
    var n = readInt();
    var dict = readListString(n);
    var letters = readString();
    
    var solution;
    var max = 0;
    
    for (var word in dict) {
        
        var copy = new List<int>.from(letters.codeUnits);
        var points = 0;
        
        for (var letter in word.codeUnits) {
            
            var pos = copy.indexOf(letter);
            if (pos == -1) {
                points = 0;
                break;
            }
            
            copy.removeAt(pos);
            points += POINTS[letter - A];
        }
        
        if (points > max) {
            max = points;
            solution = word;
        }
    }
    
    print(solution);
}

const int A = 97;

const List<int> POINTS = const 
    [1, 3, 3, 2, 1,
     4, 2, 4, 1, 8,
     5, 1, 3, 1, 1, 
     3, 10, 1, 1, 1,
     1, 4, 4, 8, 4,
     10];

String readString() => stdin.readLineSync();

int readInt() => int.parse(readString());

List<String> readListString(int n)
    => new List<String>.generate(n, (_) => readString());
