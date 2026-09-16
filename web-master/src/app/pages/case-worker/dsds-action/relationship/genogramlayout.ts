

import * as go from 'gojs';

// A custom layout that shows the two families related to a person's parents
export class GenogramLayout extends go.LayeredDigraphLayout {
  public spouseSpacing: number;

  public constructor() {
    super();
    this.initializeOption = go.LayeredDigraphLayout.InitDepthFirstIn;
    this.spouseSpacing = 30;  // minimum space between spouses
  }

  public makeNetwork(coll: go.Diagram | go.Group | go.Iterable<go.Part>) {
    // generate LayoutEdges for each parent-child Link
    const net = this.createNetwork();
    if (coll instanceof go.Diagram) {
      this.add(net, coll.nodes, true);
      this.add(net, coll.links, true);
    } else if (coll instanceof go.Group) {
      this.add(net, coll.memberParts, false);
    } else if (coll.iterator) {
      this.add(net, coll.iterator, false);
    }
    return net;
  }

  // internal method for creating LayeredDigraphNetwork where husband/wife pairs are represented
  // by a single LayeredDigraphVertex corresponding to the label Node on the marriage Link
  protected add(net: go.LayeredDigraphNetwork, coll: go.Iterable<go.Part>, nonmemberonly: boolean) {
    const multiSpousePeople = new go.Set<go.Node>();

    // now do all Nodes
    coll.iterator.each(node => {
        if (!(node instanceof go.Node)) {return}
        if (!node.isLayoutPositioned || !node.isVisible()) {return}
        if (nonmemberonly && node.containingGroup !== null) {return}

        this.handleIsLinkLabelFn(node, net, multiSpousePeople);
    });

    // now do all Links
    coll.iterator.each(part => {
        if (!(part instanceof go.Link)) {return}
        const link = part as go.Link;   // NOSONAR  // defining link variable with reference.

        if (!link.isLayoutPositioned || !link.isVisible()) {return}
        if (nonmemberonly && link.containingGroup !== null) {return}

        this.handleIfNotIsLabeledLinkFn(link, net);
    });

    // Handle multi-spouse people
    this.handleMultiSpousePeopleFn(multiSpousePeople, net);
}
// Assosiated with go function
  private handleMultiSpousePeopleFn(multiSpousePeople: go.Set<go.Node>, net: go.LayeredDigraphNetwork) {
    while (multiSpousePeople.count > 0) {
      // find all collections of people that are indirectly married to each other
      this.handleMultiSpousePeopleMoreThan1Fn(net, multiSpousePeople);
    }
  }
// Assosiated with go function
  private handleMultiSpousePeopleMoreThan1Fn(net: go.LayeredDigraphNetwork, multiSpousePeople: go.Set<go.Node>) {
    const node = multiSpousePeople.first() as go.Node;  // NOSONAR  // defining node variable with reference.
    const cohort = new go.Set() as go.Set<go.Node>; // NOSONAR  // defining cohort variable with reference.
    this.extendCohort(cohort, node);
    // then encourage them all to be the same generation by connecting them all with a common vertex
    const dummyvert = net.createVertex();
    net.addVertex(dummyvert);
    const marriages = new go.Set() as go.Set<go.Link>;  // NOSONAR  // defining marriages variable with reference.
    cohort.each(function (n) {
      n.linksConnected.each(function (l) {
        marriages.add(l);
      });
    });
    marriages.each(function (link) {
      // find the vertex for the marriage link (i.e. for the label node)
      const mlab = link.labelNodes.first();
      if (mlab !== null) {
        const v = net.findVertex(mlab);
        if (v !== null) {
          net.linkVertexes(dummyvert, v, link || null);
        }
      }
    });
    // done with these people, now see if there are any other multiple-married people
    multiSpousePeople.removeAll(cohort);
  }
// Assosiated with go function
  private handleIfNotIsLabeledLinkFn(link: go.Link, net: go.LayeredDigraphNetwork) {
    if (!link.isLabeledLink) {
      const fromNode = link.fromNode;
      const toNode = link.toNode;
      if (fromNode !== null && toNode !== null) {
        const parent = net.findVertex(fromNode); // should be a label node
        const child = net.findVertex(toNode);
        if (parent !== null && child !== null) { // an unmarried child
          net.linkVertexes(parent, child, link);
        } else if (parent !== null) { // a married child
          this.handleIfParentNotNullFn(toNode, net, parent, link);
        }
      }
    }
  }
// Assosiated with go function
  private handleIfParentNotNullFn(toNode: go.Node, net: go.LayeredDigraphNetwork, parent: go.LayoutVertex, link: go.Link) {
    toNode.linksConnected.each(function (l) {
      if (!l.isLabeledLink) { return; } // if it has no label node, it's a parent-child link


      // found the Marriage Link, now get its label Node
      const mlab = l.labelNodes.first();
      // parent-child link should connect with the label node,
      // so the LayoutEdge should connect with the LayoutVertex representing the label node
      if (mlab !== null) {
        const mlabvert = net.findVertex(mlab);
        if (mlabvert !== null) {
          net.linkVertexes(parent, mlabvert, link);
        }
      }
    });
  }
// Assosiated with go function
  private handleIsLinkLabelFn(node: go.Node, net: go.LayeredDigraphNetwork, multiSpousePeople: go.Set<go.Node>) {
    if (node.isLinkLabel) {
      // get marriage Link
      const link = node.labeledLink;
      if (link) {
        const spouseA = link.fromNode;
        const spouseB = link.toNode;
        // create vertex representing both husband and wife
        const vertex = net.addNode(node);
        // now define the vertex size to be big enough to hold both spouses
        if (spouseA && spouseB) {
          vertex.width = spouseA.actualBounds.width + this.spouseSpacing + spouseB.actualBounds.width;
          vertex.height = Math.max(spouseA.actualBounds.height, spouseB.actualBounds.height);
          vertex.focus = new go.Point(spouseA.actualBounds.width + this.spouseSpacing / 2, vertex.height / 2);
        }
      }
    } else {
      // don't add a vertex for any married person!
      // instead, code above adds label node for marriage link
      // assume a marriage Link has a label Node
      let marriages = 0;
      node.linksConnected.each(function (l) { if (l.isLabeledLink) { marriages++; } });
      if (marriages > 1) {
        multiSpousePeople.add(node);
      }
    }
  }

  // collect all of the people indirectly married with a person
  protected extendCohort(coll: go.Set<go.Node>, node: go.Node) {
    if (coll.contains(node)) {return;}
    coll.add(node);
    const lay = this;
    node.linksConnected.each(function(l) {
      if (l.isLabeledLink) {  // if it's a marriage link, continue with both spouses
        if (l.fromNode !== null) {lay.extendCohort(coll, l.fromNode);}
        if (l.toNode !== null) {lay.extendCohort(coll, l.toNode);}
      }
    });
  }

  public assignLayers() {
    super.assignLayers();
    const horiz = this.direction === 0.0 || this.direction === 180.0;
    // for every vertex, record the maximum vertex width or height for the vertex's layer
    const maxsizes = [] as Array<number>;
    const net = this.network;
    if (net !== null) {
      const vit = net.vertexes.iterator;
    
      while (vit.next()) {
        const v = vit.value as go.LayeredDigraphVertex;
        const lay = v.layer;
        const sz = this.returnSzDataFn(horiz, v);
        
        if (this.returnMaxsizesFn(maxsizes, lay, sz)) {
          maxsizes[lay] = sz;
        }
      }
      
      vit.reset();
  
      while (vit.next()) {
        const v = vit.value as go.LayeredDigraphVertex;
        const lay = v.layer;
        const max = maxsizes[lay];
  
        if (horiz) {
          v.focus = new go.Point(0, v.height / 2);
          v.width = max;
        } else {
          v.focus = new go.Point(v.width / 2, 0);
          v.height = max;
        }
      }
    }
  }
  // Assosiated with assignLayers function
  private returnSzDataFn(horiz: boolean, v: go.LayeredDigraphVertex) {
    return horiz ? v.width : v.height;
  }
  // Assosiated with assignLayers function
  private returnMaxsizesFn(maxsizes: number[], lay: number, sz: number) {
    return maxsizes[lay] === undefined || sz > maxsizes[lay];
  }

  public commitNodes() {
    super.commitNodes();
  
    const net: any = this.network;
  
    if (this.returnCommitNodeCon1Fn(net)) {
      return;
    }
  
    const vit = net.vertexes.iterator;
  
    // Position regular nodes
    this.handleVitFn(vit);
  
    vit.reset();
  
    while (vit.next()) {
      const v = vit.value as go.LayeredDigraphVertex;
      if (v.node === null || !v.node.isLinkLabel) {
        continue;
      }
      this.handleIfNotLablinkFn(v, this);
    }
  
    vit.reset();
  
    while (vit.next()) {
      const v = vit.value as go.LayeredDigraphVertex;
      if (v.node === null || v.node.linksConnected.count > 1) {
        continue;
      }
      const mnode = this.findParentsMarriageLabelNode(v.node);
      if (mnode !== null && mnode.linksConnected.count === 1) {
      if (this.network === null) {continue;}
        this.handleMvertFn(mnode, v);
      }
    }
  }
  // Assosiated with commitNodes function
  private returnCommitNodeCon1Fn(net: any) {
    return net === null || this.diagram === null;
  }
// Assosiated with commitNodes function
  private handleVitFn(vit: go.Iterator<go.LayoutVertex>) {
    while (vit.next()) {
      const v = vit.value as go.LayeredDigraphVertex;
      if (v.node !== null && !v.node.isLinkLabel) {
        v.node.position = new go.Point(v.x, v.y);
      }
    }
  }
// Assosiated with commitNodes function
  private handleMvertFn(mnode: go.Node, v: any) {
    const mvert = this.network ? this.network.findVertex(mnode) : null;
    if (mvert !== null) {
      const newBounds: any = v.node.actualBounds.copy();
      newBounds.x = mvert.centerX - v.node.actualBounds.width / 2;

      // Check for empty space at horizontal mid-point in that layer
      const overlaps: any = this.diagram?.findObjectsIn(newBounds,(x: any) => {
          return (x.part instanceof go.Part) ? x.part : undefined
        },
        (p) => p !== v.node,
        true
      );

      if (overlaps.count === 0) {
        v.node.move(newBounds.position);
      }
    }
  }
// Assosiated with commitNodes function
  private handleIfNotLablinkFn(v: go.LayeredDigraphVertex, layout: this) {
    const labnode: any = v.node;
    const lablink = labnode.labeledLink;
    if (lablink !== null) {
      // In case the spouses are not actually moved, we need to have the marriage link
      // position the label node, because LayoutVertex.commit() was called above on these vertexes.
      // Alternatively we could override LayoutVetex.commit to be a no-op for label node vertexes.
      lablink.invalidateRoute();
      let spouseA = lablink.fromNode;
      let spouseB = lablink.toNode;
      if (spouseA !== null && spouseB != null) {
        // prefer fathers on the left, mothers on the right
        if (spouseA.data.s === 'F') { // sex is female
          const temp = spouseA;
          spouseA = spouseB;
          spouseB = temp;
        }
        // see if the parents are on the desired sides, to avoid a link crossing
        const aParentsNode = layout.findParentsMarriageLabelNode(spouseA);
        const bParentsNode = layout.findParentsMarriageLabelNode(spouseB);
        if (aParentsNode !== null && bParentsNode !== null && aParentsNode.position.x > bParentsNode.position.x) {
          // swap the spouses
          const temp = spouseA;
          spouseA = spouseB;
          spouseB = temp;
        }
        spouseA.position = new go.Point(v.x, v.y);
        spouseB.position = new go.Point(v.x + spouseA.actualBounds.width + layout.spouseSpacing, v.y);
        if (spouseA.opacity === 0) {
          const pos = new go.Point(v.centerX - spouseA.actualBounds.width / 2, v.y);
          spouseA.position = pos;
          spouseB.position = pos;
        } else if (spouseB.opacity === 0) {
          const pos = new go.Point(v.centerX - spouseB.actualBounds.width / 2, v.y);
          spouseA.position = pos;
          spouseB.position = pos;
        }
      }
    }
  }

  public findParentsMarriageLabelNode(node: go.Node) {
    const it = node.findNodesInto();
    while (it.next()) {
      const n = it.value;
      if (n.isLinkLabel) {return n;}
    }
    return null;
  }
}
// end GenogramLayout class
