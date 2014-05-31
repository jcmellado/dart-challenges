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
  Dart solution to the "Dwarfs standing on the shoulders of giants" CodinGame challenge.

  Visit http://www.codingame.com/ for more information.
*/

import "dart:io";
import "dart:math" show max;

void main() {
    var N = readInt();

    var tree = {};
    for (var i = 0; i < N; ++ i) {
        var line = readLine();
        add(tree, line[0], line[1]);
    }

    print(maxDepth(tree));
}

void add(Map root, int a, int b) {
    root.putIfAbsent(a, () => {"children" : {}, "isRoot" : true});
    root.putIfAbsent(b, () => {"children" : {}, "isRoot" : false});

    root[a]["children"][b] = root[b]["children"];
    root[b]["isRoot"] = false;
}

int maxDepth(Map root)
    => root.values
        .where((node) => node["isRoot"])
        .fold(0, (len, node) => max(len, depth(node["children"]) + 1));

int depth(Map root)
    => root.values
        .fold(0, (len, node) => max(len, depth(node) + 1));

String readString() => stdin.readLineSync();

int readInt() => int.parse(readString());

List<int> readLine()
    => readString().split(" ").map(int.parse).toList();
