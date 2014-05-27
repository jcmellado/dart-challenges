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

  Visit http://www.codingame.com/ for more information.
*/

import "dart:io";

void main() {
    var init = readLineInt();
    var N = init[0];
    var L = init[1];
    var E = init[2];
    var links = readListLink(L);
    var gateways = readListInt(E);

    var solver = new Solver(links, gateways);

    while (true) {
        var SI = readInt();

        var link = solver.solve(SI);
        
        link.severed = true;
        
        print("${link.n1} ${link.n2}");
    }
}

class Solver {
    final List<Link> links;
    final List<int> gateways;
    
    Solver(this.links, this.gateways);
    
    Link solve(int SI) {
        var sever;
        
        for (var link in links) {
            if (!link.severed) {
                for (var gateway in gateways) {
                    if (link.n1 == gateway || link.n2 == gateway) {
                        if (link.n1 == SI || link.n2 == SI) {
                            return link;
                        }
                        sever = link;
                    }
                }
            }
        }
        
        return sever;
    }
}

class Link {
    int n1;
    int n2;
    bool severed = false;
    
    Link(this.n1, this.n2);
}

Link readLink() {
    var line = readLineInt();
    return new Link(line[0], line[1]);
}

List<Link> readListLink(int n)
    => new List<Link>.generate(n, (_) => readLink());

List<int> readLineInt()
    => readString().split(" ").map(int.parse).toList();

List<int> readListInt(int n)
    => new List<int>.generate(n, (_) => readInt());

int readInt() => int.parse(readString());

String readString() => stdin.readLineSync();
