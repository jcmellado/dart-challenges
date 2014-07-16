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
  Dart solution to the "Skynet Finale - Level 2" CodinGame challenge.

  Visit http://www.codingame.com/ for more information.
*/

import "dart:io" show stdin;

void main() {
    var init = readLine();
    var n = init[0];
    var l = init[1];
    var e = init[2];
    
    var links = readLinks(l);
    var gateways = readGateways(e);

    var solver = new Solver(links, gateways);
    
    while (true) {
        var si = readInt();
        
        var link = solver.solve(si);
        
        print("${link.a} ${link.b}");
    }
}

class Solver {
    List<Link> links;
    List<int> gateways;
    
    Solver(this.links, this.gateways);
    
    Link solve(int si) {
    
        // Link connecting the agent position directly with a gateway.
        var link = direct(si);
        if (link == null) {
            
            // Link connecting a (critic) node connected to more that one gateway.
            link = critic(si);
            if (link == null) {
                
                // Any severable link.
                link = severable.first;
            }
        }

        links.remove(link);

        return link;
    }

    bool isGateway(int node) => gateways.contains(node);

    Iterable<Link> get severable
        => links.where((link) => isGateway(link.a) || isGateway(link.b));

    Link direct(int node)
        => severable.firstWhere((link) => link.a == node || link.b == node, orElse : () => null);
    
    Link critic(int si) {
        var minCost;
        var minNode;

        // Find nodes connected to more than one gateway.
        var nodes = critics();
    
        // Now calculate the minimum cost from the agent position for all those nodes.
        for (var node in nodes) {
            var cost = visit(si, node);
            
            if (cost != null && (minCost == null || minCost > cost)) {
                minCost = cost;
                minNode = node;
            }
        }
        
        // Return any link connecting the critic node with a gateway.
        return minNode == null ? null : direct(minNode);
    }

    Iterable<int> critics() {
        
        // Map links to nodes.
        var candidates = severable.map((link) => isGateway(link.a) ? link.b : link.a);
        
        // Nodes connected to more that one gateway.
        var nodes = candidates.where((node) => 
            severable.where((link) => link.a == node || link.b == node).length > 1);
        
        // Distinct.
        return nodes.fold(new List<int>(), (prev, node) {
            if (!prev.contains(node)) prev.add(node);
            return prev;
        });
    }
    
    int visit(int src, int dst) {
        var costs = new Map<int, int>();

        // Use a local array for avoiding stackoverflow exception.
        var stack = new List<Visit>()
            ..add(new Visit(src, 0));
        
        while(stack.isNotEmpty) {
            var visit = stack.removeLast();
            
            // Unvisited node or cheaper path?
            var cost = costs[visit.node];
            if (cost == null || cost > visit.cost) {
                
                // Update the cost.
                costs[visit.node] = visit.cost;

                // Still not there?
                if (visit.node != dst) {

                    // Links connected to the visited node.
                    var connections = links.where((link) => link.a == visit.node || link.b == visit.node);

                    // The trick: Substract 1 if the visited node is connected to a gateway.
                    for (var connection in connections) {
                        if (isGateway(connection.a) || isGateway(connection.b)) {
                            visit.cost --;
                            break;
                        }
                    }

                    // Visit the neighbours.
                    for (var connection in connections) {
                        
                        if (connection.a == visit.node) {
                            if (!isGateway(connection.b)) {
                                stack.add(new Visit(connection.b, visit.cost + 1));
                            }
                        }

                        if (connection.b == visit.node) {
                            if (!isGateway(connection.a)) {
                                stack.add(new Visit(connection.a, visit.cost + 1));
                            }
                        }
                    }
                }
            }
        }
        
        return costs[dst];
    }
}

class Link {
    int a;
    int b;

    Link(this.a, this.b);
}

class Visit {
    int node;
    int cost;

    Visit(this.node, this.cost);
}

String readString() => stdin.readLineSync();

int readInt() => int.parse(readString());

List<int> readLine() 
    => readString().split(" ").map(int.parse).toList();
    
List<int> readGateways(int n)
    => new List<int>.generate(n, (_) => readInt());
    
List<Link> readLinks(int n)
    =>  new List<Link>.generate(n, (_) => readLink());
    
Link readLink() {
    var line = readLine();
    return new Link(line[0], line[1]);
}
