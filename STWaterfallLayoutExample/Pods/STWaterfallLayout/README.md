# STWaterfallLayout
swift3.0写的一个自定义瀑布流

- An easy way to use FallLayout

### How to use STWaterfallLayout

- Installation with CocoaPods：pod 'STWaterfallLayout'

- Manual import：
  - Drag All files in the STWaterfallLayout folder to project

- About how to FallLayout
  - The following STWaterfallLayoutDataSource are followed and implemented
```@objc
/// 返回多少列
    func numberOfCols(stWaterfallLayout : STWaterfallLayout)->Int
    
    /// 每一个item的高度
    func heightOfItem(stWaterfallLayout : STWaterfallLayout, indexPath : NSIndexPath, itemWidth : CGFloat)->CGFloat

```
![(image)](https://github.com/CoderST/STWaterfallLayout/blob/master/STWaterfallLayoutExample/show.gif)
