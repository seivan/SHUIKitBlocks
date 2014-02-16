#SHTabBarControllerBlocks

[![Build Status](https://travis-ci.org/seivan/SHTabBarControllerBlocks.png?branch=master)](https://travis-ci.org/seivan/SHTabBarControllerBlocks)
[![Version](https://cocoapod-badges.herokuapp.com/v/SHTabBarControllerBlocks/badge.png)](http://cocoadocs.org/docsets/SHTabBarControllerBlocks)
[![Platform](https://cocoapod-badges.herokuapp.com/p/SHTabBarControllerBlocks/badge.png)](http://cocoadocs.org/docsets/SHTabBarControllerBlocks)

> This pod is used by [`SHUIKitBlocks`](https://github.com/seivan/SHUIKitBlocks) as part of many components covering to plug the holes missing from Foundation, UIKit, CoreLocation, GameKit, MapKit and other aspects of an iOS application's architecture.

##Overview

Life cycle blocks for UITabBarController.
The blocks are automatically removed once they UITabBarController is gone, so it isn't necessary to clean up - Swizzle Free(™)

### API

#### [Properties](https://github.com/seivan/SHTabBarControllerBlocks#properties-1)


##Installation

Installation
------------

```ruby
pod 'SHTabBarControllerBlocks' 
pod 'SHTabBarControllerBlocks', '~> 1.1.0' # for iOS 6
```

##Setup


Put this either in specific files or your project prefix file

```objective-c
#import "UITabBarController+SHTabBarControllerBlocks.h"
```
or
```objective-c
#import "SHTabBarControllerBlocks.h"
```

##API


#### Properties

```objective-c

#pragma mark - Block Defintions
typedef BOOL (^SHTabBarControllerPredicateBlock)(UITabBarController  * theTabBarController,
UIViewController * theViewController);

typedef void (^SHTabBarControllerBlock)(UITabBarController  * theTabBarController,
UIViewController * theViewController);

typedef void (^SHTabBarControllerCustomizingBlock)(UITabBarController  * theTabBarController,
NSArray  * theViewControllers);

typedef void (^SHTabBarControllerCustomizingWithChangeBlock)(UITabBarController  * theTabBarController,
NSArray * theViewControllers,
BOOL      isChanged);

typedef id<UIViewControllerInteractiveTransitioning>
(^SHTabBarControllerInteractiveControllerBlock)(UITabBarController * tabBarController,
                                                id<UIViewControllerAnimatedTransitioning> animationController
                                                );

typedef id<UIViewControllerAnimatedTransitioning>
(^SHTabBarControllerAnimatedControllerBlock) (UITabBarController * tabBarController,
                                              UIViewController * fromVC,
                                              UIViewController * toVC
                                              );



@interface UITabBarController (SHTabBarControllerBlocks)



#pragma mark - Properties

#pragma mark - Setters
-(void)SH_setShouldSelectViewControllerBlock:(SHTabBarControllerPredicateBlock)theBlock;
-(void)SH_setDidSelectViewControllerBlock:(SHTabBarControllerBlock)theBlock;
-(void)SH_setWillBeginCustomizingViewControllersBlock:(SHTabBarControllerCustomizingBlock)theBlock;
-(void)SH_setWillEndCustomizingViewControllersBlock:(SHTabBarControllerCustomizingWithChangeBlock)theBlock;
-(void)SH_setDidEndCustomizingViewControllersBlock:(SHTabBarControllerCustomizingWithChangeBlock)theBlock;
-(void)SH_setInteractiveControllerBlock:(SHTabBarControllerInteractiveControllerBlock)theBlock;
-(void)SH_setAnimatedControllerBlock:(SHTabBarControllerAnimatedControllerBlock)theBlock;



#pragma mark - Getters
@property(nonatomic,readonly) SHTabBarControllerPredicateBlock SH_blockShouldSelectViewController;
@property(nonatomic,readonly) SHTabBarControllerBlock SH_blockDidSelectViewController;
@property(nonatomic,readonly) SHTabBarControllerCustomizingBlock SH_blockWillBeginCustomizingViewControllers;
@property(nonatomic,readonly) SHTabBarControllerCustomizingWithChangeBlock SH_blockWillEndCustomizingViewControllers;
@property(nonatomic,readonly) SHTabBarControllerCustomizingWithChangeBlock SH_blockDidEndCustomizingViewControllers;
@property(nonatomic,readonly) SHTabBarControllerInteractiveControllerBlock SH_blockInteractiveController;
@property(nonatomic,readonly) SHTabBarControllerAnimatedControllerBlock SH_blockAnimatedController;

@end

```


Contact
-------

If you end up using SHTabBarControllerBlocks in a project, I'd love to hear about it.

email: [seivan.heidari@icloud.com](mailto:seivan.heidari@icloud.com)  
twitter: [@seivanheidari](https://twitter.com/seivanheidari)

## License

SHTabBarControllerBlocks is © 2013 [Seivan](http://www.github.com/seivan) and may be freely
distributed under the [MIT license](http://opensource.org/licenses/MIT).
See the [`LICENSE.md`](https://github.com/seivan/SHTabBarControllerBlocks/blob/master/LICENSE.md) file.

