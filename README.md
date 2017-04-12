# Erlang BK-Tree

[![Build Status](https://travis-ci.org/mtchavez/bk-tree-erl.png?branch=master)](https://travis-ci.org/mtchavez/bk-tree-erl)

## Filling tree

In the Erlang console initialize a tree with a root node

```erlang
cd("./src").
c("bk_trees").
T = bk_trees:init("brewery").
```

Then add some more terms to the tree

```erlang
T2 = bk_trees:insert("stone", T).
T3 = bk_trees:insert("anchorsteam", T2).
T4 = bk_trees:insert("delirium", T3).
```

## Searching

Once you have populated the tree you can do a search.

Default depth is ```1``` when doing a search.

```erlang
bk_trees:search("budweiser", T4).
% returns []
```

Increasing the depth will give you more terms that are close to your search term.

```erlang
bk_trees:search("deli", T4, 4).
% returns [{4,"delirium"}]

bk_trees:search("deli", T4, 5).
% returns [{5,"stone"},{4,"delirium"}]
```

## Tests

Run using ```make test```
