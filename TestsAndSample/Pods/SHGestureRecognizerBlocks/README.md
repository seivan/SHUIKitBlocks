SHGestureRecognizerBlocks
==========
[![Build Status](https://travis-ci.org/seivan/SHGestureRecognizerBlocks.png?branch=master)](https://travis-ci.org/seivan/SHGestureRecognizerBlocks)
[![Version](https://cocoapod-badges.herokuapp.com/v/SHGestureRecognizerBlocks/badge.png)](http://cocoadocs.org/docsets/SHGestureRecognizerBlocks)
[![Platform](https://cocoapod-badges.herokuapp.com/p/SHGestureRecognizerBlocks/badge.png)](http://cocoadocs.org/docsets/SHGestureRecognizerBlocks)

> This pod is used by [`SHUIKitBlocks`](https://github.com/seivan/SHUIKitBlocks) as part of many components covering to plug the holes missing from Foundation, UIKit, CoreLocation, GameKit, MapKit and other aspects of an iOS application's architecture.

Overview
--------
The gestures are automatically removed once their target is gone, so it isn't necessary to clean up - Swizzle Free(™)

#### [Check the creating section](https://github.com/seivan/SHGestureRecognizerBlocks#creating)

Create blocks directly from convenience class selectors

Add additional blocks on the gesture recognizer

#### [Check the removing section](https://github.com/seivan/SHGestureRecognizerBlocks#removing)

Remove specific blocks - will also remove the gesture recognizer from the target if it was the last block
Remove all blocks - will also remove the gesture recognizer from the target

#### [Check the properties section](https://github.com/seivan/SHGestureRecognizerBlocks#properties)

NSSet with all active blocks on the gesture



Installation
------------

```ruby
pod 'SHGestureRecognizerBlocks'
```

***

Setup
-----

Put this either in specific files or your project prefix file

```objective-c
#import "UIGestureRecognizer+SHGestureRecognizerBlocks.h"
```
or
```objective-c
#import "SHGestureRecognizerBlocks.h"
```

Usage
-----

### Creating

With SHGestureRecognizerBlocks you can set auto-removed blocks instead of using selectors

```objective-c
  UITapGestureRecognizer * tapRecognizer = [UITapGestureRecognizer SH_gestureRecognizerWithBlock:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
    NSLog(@"callback");
  }];

  [self.view addGestureRecognizer:tapRecognizer];

``` 

or if you want add additional blocks

```objective-c

  UITapGestureRecognizer * tapRecognizer = [UITapGestureRecognizer alloc] init];

  SHGestureRecognizerBlock block = ^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
    NSLog(@"CALLBACK block1");
  };


  SHGestureRecognizerBlock block2 = ^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
    NSLog(@"CALLBACK block2");
  };

  [tapRecognizer SH_addBlock:block];
  [tapRecognizer SH_addBlock:block2];

  [self.view addGestureRecognizer:tapRecognizer];

```

### Removing


#### Remove specific blocks - will also remove the gesture recognizer from the target if it was the last block

```objective-c
-(void)SH_removeBlock:(SHGestureRecognizerBlock)theBlock;

[tapGesture SH_removeBlock:block];
```

#### Remove all blocks - will also remove the gesture recognizer from the target

```objective-c
-(void)SH_removeAllBlocks;

[tapGesture SH_removeAllBlocks];
```


Properties
------ 

#### NSSet with all active blocks on the gesture

```objective-c
@property(nonatomic,readonly) NSSet * SH_blocks;

for(SHGestureRecognizerBlock block in tapGesture.SH_blocks) {
  
}

```

Existing Codebase 
-----------------
Works fine with other gestures, such as swipe, pan and longpresses. 

Replacing
---------

```objective-c
[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(performBlockAction:)];
```


Contact
-------

If you end up using SHGestureRecognizerBlocks in a project, I'd love to hear about it.

email: [seivan.heidari@icloud.com](mailto:seivan.heidari@icloud.com)  
twitter: [@seivanheidari](https://twitter.com/seivanheidari)

## License

SHGestureRecognizerBlocks is © 2013 [Seivan](http://www.github.com/seivan) and may be freely
distributed under the [MIT license](http://opensource.org/licenses/MIT).
See the [`LICENSE.md`](https://github.com/seivan/SHGestureRecognizerBlocks/blob/master/LICENSE.md) file.
