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
  Dart solution to the "Docteur Who - The Gift" CodinGame challenge.

  Visit http://www.codingame.com/ for more information.
*/

import "dart:io";
import "dart:math" show min;

void main() {
    var N = readInt();
    var C = readInt();
    var B = readListInt(N);

    var solution = contributions(B, C);
    
    solution.isEmpty ? print("IMPOSSIBLE") : solution.forEach(print);
}

List<int> contributions(List<int> budgets, int price) {
    var result = new List<int>.filled(budgets.length, 0);

    budgets.sort();

    var richs = count(budgets);

    while(price != 0) {

        var part = (price / richs).floor();
        if (part == 0) {
            part = 1;
        }

        for (var i = budgets.length - 1; i >= 0; -- i) {
            
            if (budgets[i] != 0 && budgets[i] <= part) richs --;

            var contribution = min(budgets[i], part);
            budgets[i] -= contribution;
            result[i] += contribution;
            price -= contribution;
            
            if (price == 0) break;
            
            if (richs == 0) return [];
        }
    }

    return result;
}

int count(List<int> budgets)
    => budgets.where((budget) => budget > 0).length;

int readInt() => int.parse(stdin.readLineSync());

List<int> readListInt(int n)
    => new List<int>.generate(n, (_) => readInt());
