Erlang BK-Tree
===========

[![Build Status](https://travis-ci.org/mtchavez/bk-tree-erl.png?branch=master)](https://travis-ci.org/mtchavez/bk-tree-erl)

## Filling tree

In the Erlang console initialize a tree with a root node

```erlang
c(tree).
T = tree:init("brewery").
```

Then add some more terms to the tree

```erlang
T2 = tree:insert("stone", T).
T3 = tree:insert("anchorsteam", T2).
T4 = tree:insert("delirium", T3).
```

## Searching

Once you have populated the tree you can do a search.

Default depth is ```1``` when doing a search.

```erlang
tree:search("budweiser", T4).
% returns []
```

Increasing the depth will give you more terms that are close to your root node.

```erlang
tree:search("deli", T4, 4).
% returns [{4,"delirium"}]

tree:search("deli", T4, 5).
% returns [{5,"stone"},{4,"delirium"}]
```

## Tests

Run using ```make test```

## License

Written by Chavez

Released under the MIT License: http://www.opensource.org/licenses/mit-license.php

