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

  Visit http://www.codingame.com for more information.
*/

import "dart:io" show stdin;
import "dart:math" show min;

void main() {
  var n = readInt();
  var price = readInt();
  var budgets = readBudgets(n);

  var solution = contributions(budgets, price);

  solution.isEmpty ? print("IMPOSSIBLE") : solution.forEach(print);
}

List<int> contributions(List<int> budgets, int price) {
  var solution = new List<int>.filled(budgets.length, 0);

  // THE TRICK: Sort the list!
  budgets.sort();

  // Oods with some money to waste.
  var richs = budgets.where((budget) => budget > 0).length;

  var remainder = price;
  while (remainder != 0) {

    // Quantity to be paid, at least one coin.
    var part = (remainder / richs).floor();
    if (part == 0) {
      part = 1;
    }

    for (var i = budgets.length - 1; i >= 0; --i) {

      // Contribute with all the money you can.
      var contribution = min(budgets[i], part);

      remainder -= contribution;
      budgets[i] -= contribution;
      solution[i] += contribution;

      // Done?
      if (remainder == 0) return solution;

      // Sorry, you wasted all your money, you aren't rich anymore.
      if (contribution != 0 && budgets[i] == 0) richs--;

      // No more money?
      if (richs == 0) return <int>[];
    }
  }

  return solution;
}

String readString() => stdin.readLineSync();

int readInt() => int.parse(readString());

List<int> readBudgets(int n) => new List<int>.generate(n, (_) => readInt());
