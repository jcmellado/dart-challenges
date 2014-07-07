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
  Dart solution to the "Super Computer" CodinGame challenge.

  Visit http://www.codingame.com/ for more information.
*/

import "dart:io" show stdin;

void main() {
    var n = readInt();
    var calcs = readCalculations(n);
    
    var solution = solve(calcs);
    
    print(solution);
}
 
int solve(List<Calc> calcs) {

    // Best scenario: All calculations could be performed.
    var tasks = calcs.length;

    // Hack: Order calculations by start day.
    calcs.sort((a, b) => a.start.compareTo(b.start));

    // Beyond this endpoint there aren't any planned calculations.
    var end = 0;

    for (var calc in calcs) {
    
        // Overlap?
        // ---------] <= end
        //   [---]             yes!
        //     [-------]       yes!
        //               [---] no!
        if (calc.start > end) {
            
            // ---------]
            //              [---] <= new endpoint
            end = calc.end;

        } else {

            // Sorry, only one of the two calculations will can be performed.
            tasks --;
            
            // ---------]
            //   [---] <= new endpoint
            // or
            // ---------]  <= keep the previous endpoint
            //     [-------]
            if (calc.end < end) end = calc.end;
        }
    }

    return tasks;
}

class Calc {
    int start;
    int end;
    
    Calc(this.start, int duration) {
        end = start + duration - 1;
    }
}

String readString() => stdin.readLineSync();

int readInt() => int.parse(readString());

List<Calc> readCalculations(int n)
    => new List<Calc>.generate(n, (_) => readCalculation());

Calc readCalculation() {
   var line = readString().split(" ").map(int.parse).toList();
   
   return new Calc(line[0], line[1]);
}
