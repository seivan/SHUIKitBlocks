SHNavigationControllerBlocks
==========
[![Build Status](https://travis-ci.org/seivan/SHNavigationControllerBlocks.png?branch=master)](https://travis-ci.org/seivan/SHNavigationControllerBlocks)
[![Version](https://cocoapod-badges.herokuapp.com/v/SHNavigationControllerBlocks/badge.png)](http://cocoadocs.org/docsets/SHNavigationControllerBlocks)
[![Platform](https://cocoapod-badges.herokuapp.com/p/SHNavigationControllerBlocks/badge.png)](http://cocoadocs.org/docsets/SHNavigationControllerBlocks)

> This pod is used by [`SHUIKitBlocks`](https://github.com/seivan/SHUIKitBlocks) as part of many components covering to plug the holes missing from Foundation, UIKit, CoreLocation, GameKit, MapKit and other aspects of an iOS application's architecture.

Overview
--------
Life cycle blocks for UINavigationController - willShow and didShow. 
The blocks are automatically removed once they UINavigationController is gone, so it isn't necessary to clean up - Swizzle Free(™)

### API

#### [Properties](https://github.com/seivan/SHNavigationControllerBlocks#properties-1)


Installation
------------

```ruby
pod 'SHNavigationControllerBlocks' 
pod 'SHNavigationControllerBlocks', '~> 1.0.0' # for iOS 6
```

***

Setup
-----

Put this either in specific files or your project prefix file

```objective-c
#import "UINavigationController+SHNavigationControllerBlocks.h"
```
or
```objective-c
#import "SHNavigationControllerBlocks.h"
```

API
-----

### Properties

```objective-c


#pragma mark - Block Definitions
typedef void (^SHNavigationControllerBlock)(UINavigationController * navigationController,
                                            UIViewController       * viewController,
                                            BOOL                      isAnimated);

typedef UIInterfaceOrientation(^SHNavigationControllerOrientationBlock)(UINavigationController * navigationController);

typedef id<UIViewControllerInteractiveTransitioning>
(^SHNavigationControllerInteractiveControllerBlock)(UINavigationController * navigationController,
                                                    id<UIViewControllerAnimatedTransitioning> animationController);

typedef id<UIViewControllerAnimatedTransitioning>
(^SHNavigationControllerAnimatedControllerBlock) (UINavigationController * navigationController,
                                                  UINavigationControllerOperation operation,
                                                  UIViewController * fromVC,
                                                  UIViewController * toVC
                                                  );


@interface UINavigationController (SHNavigationControllerBlocks)



#pragma mark - Properties

#pragma mark - Setters

-(void)SH_setWillShowViewControllerBlock:(SHNavigationControllerBlock)theBlock;

-(void)SH_setDidShowViewControllerBlock:(SHNavigationControllerBlock)theBlock;

-(void)SH_setPreferredInterfaceOrientationForPresentatationBlock:(SHNavigationControllerOrientationBlock)theBlock;

-(void)SH_setInteractiveControllerBlock:(SHNavigationControllerInteractiveControllerBlock)theBlock;

-(void)SH_setAnimatedControllerBlock:(SHNavigationControllerAnimatedControllerBlock)theBlock;

#pragma mark - Getters

@property(nonatomic,readonly) SHNavigationControllerBlock SH_blockWillShowViewController;
@property(nonatomic,readonly) SHNavigationControllerBlock SH_blockDidShowViewController;
@property(nonatomic,readonly) SHNavigationControllerOrientationBlock SH_blockInterfaceOrientationForPresentation;
@property(nonatomic,readonly) SHNavigationControllerInteractiveControllerBlock SH_blockInteractiveController;
@property(nonatomic,readonly) SHNavigationControllerAnimatedControllerBlock SH_blockAnimatedController;


@end

```


Contact
-------

If you end up using SHNavigationControllerBlocks in a project, I'd love to hear about it.

email: [seivan.heidari@icloud.com](mailto:seivan.heidari@icloud.com)  
twitter: [@seivanheidari](https://twitter.com/seivanheidari)

## License

SHNavigationControllerBlocks is © 2013 [Seivan](http://www.github.com/seivan) and may be freely
distributed under the [MIT license](http://opensource.org/licenses/MIT).
See the [`LICENSE.md`](https://github.com/seivan/SHNavigationControllerBlocks/blob/master/LICENSE.md) file.

