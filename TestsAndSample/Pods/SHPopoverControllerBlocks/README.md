SHPopoverControllerBlocks
==========
[![Build Status](https://travis-ci.org/seivan/SHPopoverControllerBlocks.png?branch=master)](https://travis-ci.org/seivan/SHPopoverControllerBlocks)
[![Version](https://cocoapod-badges.herokuapp.com/v/SHPopoverControllerBlocks/badge.png)](http://cocoadocs.org/docsets/SHPopoverControllerBlocks)
[![Platform](https://cocoapod-badges.herokuapp.com/p/SHPopoverControllerBlocks/badge.png)](http://cocoadocs.org/docsets/SHPopoverControllerBlocks)

> This pod is used by [`SHUIKitBlocks`](https://github.com/seivan/SHUIKitBlocks) as part of many components covering to plug the holes missing from Foundation, UIKit, CoreLocation, GameKit, MapKit and other aspects of an iOS application's architecture.

Overview
--------
Life cycle blocks for SHPopoverControllerBlocks - shouldDismiss and didDismiss. 
The blocks are automatically removed once they SHPopoverControllerBlocks is gone, so it isn't necessary to clean up - Swizzle Free(™)

### API

#### [Properties](https://github.com/seivan/SHPopoverControllerBlocks#properties-1)

#### [Usage](https://github.com/seivan/SHPopoverControllerBlocks#usage-1)

Installation
------------

```ruby
pod 'SHPopoverControllerBlocks'
```

***

Setup
-----

Put this either in specific files or your project prefix file

```objective-c
#import "UIPopoverController+SHPopoverControllerBlocks.h"
```
or
```objective-c
#import "SHPopoverControllerBlocks.h"
```

API
-----

### Properties

```objective-c
#pragma mark -
#pragma mark Block Def
typedef BOOL (^SHPopverControllerShouldDismissBlock)(UIPopoverController * thePopoverController);
typedef void (^SHPopverControllerDidDismissBlock)(UIPopoverController * thePopoverController);

@interface UIPopoverController (SHPopoverControllerBlocks)


#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Setters

-(void)SH_setShouldDismissPopoverBlock:(SHPopverControllerShouldDismissBlock)theBlock;

-(void)SH_setDidDismissPopoverBlock:(SHPopverControllerDidDismissBlock)theBlock;

#pragma mark -
#pragma mark Getters

@property(nonatomic,readonly) SHPopverControllerShouldDismissBlock SH_blockShouldDismissPopoverBlock;
@property(nonatomic,readonly) SHPopverControllerDidDismissBlock    SH_blockDidDismissPopoverBlock;
@end
```

### Usage

```objective-c
  [self.popController SH_setShouldDismissPopoverBlock:^BOOL(UIPopoverController *thePopoverController) {
    testShouldDismiss = YES;
    dispatch_semaphore_signal(semaphoreShouldDismiss);
    return YES;
  }];
  
  [self.popController SH_setDidDismissPopoverBlock:^(UIPopoverController *thePopoverController) {
    testDidDismiss = YES;
    dispatch_semaphore_signal(semaphoreDidDismiss);
  }];

```


Contact
-------

If you end up using SHPopoverControllerBlocks in a project, I'd love to hear about it.

email: [seivan.heidari@icloud.com](mailto:seivan.heidari@icloud.com)  
twitter: [@seivanheidari](https://twitter.com/seivanheidari)

## License

SHPopoverControllerBlocks is © 2013 [Seivan](http://www.github.com/seivan) and may be freely
distributed under the [MIT license](http://opensource.org/licenses/MIT).
See the [`LICENSE.md`](https://github.com/seivan/SHPopoverControllerBlocks/blob/master/LICENSE.md) file.

