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
  Dart solution to the "Skynet Finale - Level 1" CodinGame challenge.

  Visit http://www.codingame.com for more information.
*/

import "dart:io" show stdin;

void main() {
  var line = readLine();
  var n = line[0];
  var l = line[1];
  var e = line[2];

  var links = readLinks(l);
  var gateways = readGateways(e);

  var solver = new Solver(links, gateways);

  while (true) {
    var si = readInt();

    var link = solver.solve(si);

    print("${link.n1} ${link.n2}");
  }
}

class Solver {
  final List<Link> links;
  final List<int> gateways;

  Solver(this.links, this.gateways);

  Link solve(int si) {
    var sever = links

      // Link connecting the Skynet agent with a gateway ...
      .firstWhere((link) => gateways.any((gateway) => link.connect(si, gateway)),

      // ... or just any link.
      orElse: () => links.last);

    links.remove(sever);

    return sever;
  }
}

class Link {
  final int n1;
  final int n2;

  const Link(this.n1, this.n2);

  bool connect(int a, int b) => (n1 == a && n2 == b) || (n1 == b && n2 == a);
}

String readString() => stdin.readLineSync();

int readInt() => int.parse(readString());

List<int> readLine() => readString().split(" ").map(int.parse).toList();

List<Link> readLinks(int n) => new List<Link>.generate(n, (_) => readLink());

Link readLink() {
  var line = readLine();
  return new Link(line[0], line[1]);
}

List<int> readGateways(int n) => new List<int>.generate(n, (_) => readInt());
