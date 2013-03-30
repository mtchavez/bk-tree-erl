-module (tree).
-export ([init/1]).
-include("include/tree.hrl").

init(Word) ->
    Node = #node{ item=Word },
    #root_node{ root=Node }.
