-module (tree).
-export ([init/0]).

-record (root_node, {root = nil, size = 0}).
-record (node, {item, child = nil, sibling = nil, dist = 0}).

init() ->
  #root_node{}.
