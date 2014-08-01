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
  Dart solution to the "Genome Sequencing" CodinGame challenge.

  Visit http://www.codingame.com for more information.
*/

import "dart:io" show stdin;

void main() {
  var n = readInt();
  var subsequences = readListString(n);

  var solver = new Solver();
  var solution = solver.solve(subsequences);

  print(solution);
}

class Solver {

  int solve(List<String> subsequences) => permute("", subsequences);

  // Returns the minimum permutation length.
  int permute(String sequence, Iterable<String> subsequences) {
    var len;

    // Done? Return the current sequence length.
    if (subsequences.isEmpty) return sequence.length;

    for (var subsequence in subsequences) {

      // New sequence prefix (e.g. AAC + CCTT = AACCTT)
      var prefix = concat(sequence, subsequence);

      // Rest of subsequences, just skip the current one.
      var rest = subsequences.where((e) => e != subsequence);

      // Minimum permutation length.
      len = min(len, permute(prefix, rest));
    }

    return len;
  }

  String concat(String a, String b) {

    // Full matching (e.g. AGATTA + GAT = AGATTA)
    if (a.contains(b)) return a;

    // Partial matching (e.g. AGATTA + TAGA = AGATTAGA)
    var pos = 0;
    for ( ; pos < a.length; ++pos) {
      if (b.startsWith(a.substring(pos))) break;
    }
    return a.substring(0, pos) + b;
  }

  int min(int a, int b) => a == null ? b : (b == null ? a : (a < b ? a : b));
}

String readString() => stdin.readLineSync();

int readInt() => int.parse(readString());

List<String> readListString(int n) =>
    new List<String>.generate(n, (_) => readString());
