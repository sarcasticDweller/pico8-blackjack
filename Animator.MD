# Animation

## `Animation:new()`

Takes a table containing frame data that should follow the following structure:

```lua
{
    {framerate int},
    {x int, y int, w int, h int, x_m int, y_m int},
}
```

The first line must contain a table holding framerate data, the subsequent tables hold definitions for a custom sized frame.