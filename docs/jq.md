# README

Examples of `jq`.

Example 1: retrieve multiple fields for each entry:
```
cat $DOTFILES/docs/jq.example.1.json | jq -r '.[]|.device.actors.botino.".status",.dbId."creation"'
```
