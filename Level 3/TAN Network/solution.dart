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
  Dart solution to the "TAN Network" CodinGame challenge.

  Visit http://www.codingame.com/ for more information.
*/

import "dart:io" show stdin;
import "dart:math" show PI, cos, sqrt;

void main() {
    var start = readString();
    var end = readString();
    
    var n = readInt();
    var stops = readStops(n);
    
    var m = readInt();
    var lines = readLines(stops, m);

    var solver = new Solver(stops);
    var route = solver.solve(start, end);
    
    if (route.isEmpty) {
        print("IMPOSSIBLE");
    } else {
        route.map(removeQuotes).forEach(print);
    }
}

String removeQuotes(String name) => name.substring(1, name.length - 1);

class Solver {
    final Map<String, Stop> stops;

    Map<String, Link> visited;
    
    Solver(this.stops);

    Iterable<String> solve(String start, String end) {
        var route = new List<String>();

        visited = new Map<String, Link>();

        explore(start, end);
    
        // Only if the end stop was reached.
        if (visited[end] != null) {
            var stop = end;
            do {
                route.add(stops[stop].name);
                stop = visited[stop].from;
            } while(stop != null);
        }
        
        return route.reversed;
    }

    void explore(String start, String end) {

        // Use a local array to avoid stackoverflow exception.
        var stack = new List<Link>()
            ..add(new Link(null, start, 0.0));

        while(stack.isNotEmpty) {
            var link = stack.removeAt(0);
            
            var visit = visited[link.to];
            
            // Unvisited stop or cheaper path found?
            if (visit == null || visit.cost > link.cost) {
            
                // Register as first visit or replace the previous one with the new one.
                visited[link.to] = link;
                
                // Still not there?
                if (link.to != end) {
                    var stop = stops[link.to];

                    // Visit the stops connected to the current one.
                    for (var connection in stop.connections) {
                        var dist = distance(stop, stops[connection]);
                        
                        stack.add(new Link(link.to, connection, link.cost + dist));
                    }
                }
            }
        }
    }

    double distance(Stop a, Stop b) {
        var x = (b.longitude - a.longitude) * cos((a.latitude + b.latitude) / 2);
        var y = (b.latitude - a.latitude);
        return sqrt(x * x + y * y) * 6371;
    }
}

// Train stop.
class Stop {
    String name;
    double latitude;
    double longitude;
    
    List<String> connections = new List<String>();
    
    Stop(this.name, this.latitude, this.longitude);
}

// Weighted link.
class Link {
    String from;
    String to;
    double cost;
    
    Link(this.from, this.to, this.cost);
}

String readString() => stdin.readLineSync();

int readInt() => int.parse(readString());

Map<String, Stop> readStops(int n) {
    var stops = new Map<String, Stop>();

    for (var i = 0; i < n; ++ i) {
        var line = readString().split(",");
        var latitude = double.parse(line[3]) * PI / 180.0;
        var longitude = double.parse(line[4]) * PI / 180.0;
        var stop = new Stop(line[1], latitude, longitude);
        stops[line[0]] = stop;
    }
    
    return stops;
}

void readLines(Map<String, Stop> stops, int m) {
    for (var i = 0; i < m; ++ i) {
        var line = readString().split(" ");
        stops[line[0]].connections.add(line[1]);
    }
}
