# chef-mapr

The goal of this recipe is to provide simple classes of nodes for
building a MapR cluster.

## Classes

### mapr:Node

This is the base class for all mapr nodes. All mapr nodes must include
this recipe in their run list.

### mapr::EdgeNode

This node is the edge node for clients to connect to

### mapr::ZookeeperNode

This is a ZookeeperNode

### mapr::JobCoordinationNode

This is a YARN coordination node.

### mapr::DataCoordinationNode

This is a Data Coordination Node

### mapr::WorkerNode

This is a Data/YARN worker node.

## Building a Cluster

You can use these nodes in any combination you see fit.

For instance the [small community edition cluster](http://doc.mapr.com/display/MapR/Planning+the+Cluster#PlanningtheCluster-SmallCommunityEditionCluster) in the MapR docs would look like this:


|         Class        | node001 | node002 | node003 | node004 | node005 |
|:--------------------:|---------|---------|---------|---------|---------|
| Node                 |    X    |    X    |    X    |    X    |    X    |
| EdgeNode             |         |    X    |         |         |         |
| ZookeeperNode        |    X    |    X    |    X    |         |         |
| DataCoordinationNode |    X    |    X    |    X    |    X    |    X    |
| JobCoordinationNode  |         |    X    |         |         |         |
| WorkerNode           |    X    |    X    |    X    |    X    |    X    |


A MapR cluster **MUST** have nodes that contain all classes in some
configuration.

