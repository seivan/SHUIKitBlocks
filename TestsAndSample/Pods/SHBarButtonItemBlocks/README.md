SHBarButtonItemBlocks
==========
[![Build Status](https://travis-ci.org/seivan/SHBarButtonItemBlocks.png?branch=master)](https://travis-ci.org/seivan/SHBarButtonItemBlocks)
[![Version](https://cocoapod-badges.herokuapp.com/v/SHBarButtonItemBlocks/badge.png)](http://cocoadocs.org/docsets/SHBarButtonItemBlocks)
[![Platform](https://cocoapod-badges.herokuapp.com/p/SHBarButtonItemBlocks/badge.png)](http://cocoadocs.org/docsets/SHBarButtonItemBlocks)

> This pod is used by [`SHUIKitBlocks`](https://github.com/seivan/SHUIKitBlocks) as part of many components covering to plug the holes missing from Foundation, UIKit, CoreLocation, GameKit, MapKit and other aspects of an iOS application's architecture.

Overview
--------
Category on top of UIBarButtonItem.

The blocks are automatically removed once the item is gone, so it isn't necessary to clean up - Swizzle Free(™)

### API

#### [Init](https://github.com/seivan/SHBarButtonItemBlocks#init-2)

#### [Creating](https://github.com/seivan/SHBarButtonItemBlocks#creating-2)

#### [Removing](https://github.com/seivan/SHBarButtonItemBlocks#removing-2)

#### [Helpers and Properties](https://github.com/seivan/SHBarButtonItemBlocks#helpers-and-properties-2)

### USAGE

#### [Init](https://github.com/seivan/SHBarButtonItemBlocks#init-3)

#### [Creating](https://github.com/seivan/SHBarButtonItemBlocks#creating-3)

#### [Removing](https://github.com/seivan/SHBarButtonItemBlocks#removing-3)

#### [Helpers and Properties](https://github.com/seivan/SHBarButtonItemBlocks#helpers-and-properties-3)

Installation
------------

```ruby
pod 'SHBarButtonItemBlocks'
```

***

Setup
-----

Put this either in specific files or your project prefix file

```objective-c
#import "UIBarButtonItem+SHBarButtonItemBlocks.h"
```
or
```objective-c
#import "SHBarButtonItemBlocks.h"
```

API
-----

### Init

```objective-c
#pragma mark -
#pragma mark Init
+(instancetype)SH_barButtonItemWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem
                                 withBlock:(SHBarButtonItemBlock)theBlock;

+(instancetype)SH_barButtonItemWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style
                   withBlock:(SHBarButtonItemBlock)theBlock;

+(instancetype)SH_barButtonItemWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style
                   withBlock:(SHBarButtonItemBlock)theBlock;

```

### Creating

```objective-c
#pragma mark -
#pragma mark Add
-(void)SH_addBlock:(SHBarButtonItemBlock)theBlock;

```

### Removing

```objective-c
#pragma mark -
#pragma mark Remove
-(void)SH_removeBlock:(SHBarButtonItemBlock)theBlock;
-(void)SH_removeAllBlocks;


```

### Helpers and Properties

```objective-c
#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Getters
@property(nonatomic,readonly) NSSet * SH_blocks;


```

Usage
-----

### Init

### Class convenience selectors for creating directly. 

```objective-c
  UIBarButtonItem * button = [UIBarButtonItem SH_barButtonItemWithTitle:@"Clear blocks" style:UIBarButtonItemStyleBordered withBlock:^(UIBarButtonItem *sender) {
    [sender SH_removeAllBlocks];
    [sender SH_addBlock:^(UIBarButtonItem *sender) {
      SHBlockAssert(sender.SH_blocks.count == 1, @"Should have one block");
    }];
  }];
```

### Creating

#### With SHBarButtonItemBlocks you can set auto-removed blocks instead of using selectors

```objective-c

  [button SH_addBlock:^(UIBarButtonItem *sender) {
    
  }]


``` 

#### or if you want add additional blocks

```objective-c
  [button SH_addBlock:counterBlock];
```

### Removing


#### Remove specific blocks - will also remove the Event from the target if it was the last block

```objective-c
  [btnSecond SH_removeControlEventsForBlock:counterBlock];
```

#### Remove specific blockss

```objective-c
      [button SH_removeBlock:counterBlock];
```

#### Remove all blocks

```objective-c
    [sender SH_removeAllBlocks];
```


### Helpers and Properties
------ 

```objective-c
    // Unique blocks
  [button SH_addBlock:blockOne];
  [button SH_addBlock:blockTwo];
  [button SH_addBlock:blockThree];
  [button SH_addBlock:blockThree];
  SHBlockAssert(button.SH_blocks.count == 3, @"Should have three blocks");

```



Contact
-------

If you end up using SHBarButtonItemBlocks in a project, I'd love to hear about it.

email: [seivan.heidari@icloud.com](mailto:seivan.heidari@icloud.com)  
twitter: [@seivanheidari](https://twitter.com/seivanheidari)

## License

SHBarButtonItemBlocks is © 2013 [Seivan](http://www.github.com/seivan) and may be freely
distributed under the [MIT license](http://opensource.org/licenses/MIT).
See the [`LICENSE.md`](https://github.com/seivan/SHBarButtonItemBlocks/blob/master/LICENSE.md) file.
