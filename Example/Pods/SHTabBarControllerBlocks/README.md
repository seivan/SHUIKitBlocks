#SHTabBarControllerBlocks

[![Build Status](https://travis-ci.org/seivan/SHTabBarControllerBlocks.png?branch=master)](https://travis-ci.org/seivan/SHTabBarControllerBlocks)
[![Version](http://cocoapod-badges.herokuapp.com/v/SHTabBarControllerBlocks/badge.png)](http://cocoadocs.org/docsets/SHTabBarControllerBlocks)
[![Platform](http://cocoapod-badges.herokuapp.com/p/SHTabBarControllerBlocks/badge.png)](http://cocoadocs.org/docsets/SHTabBarControllerBlocks)

> This pod is used by [`SHUIKitBlocks`](https://github.com/seivan/SHUIKitBlocks) as part of many components covering to plug the holes missing from Foundation, UIKit, CoreLocation, GameKit, MapKit and other aspects of an iOS application's architecture.

##Overview

Life cycle blocks for UITabBarController.
The blocks are automatically removed once they UITabBarController is gone, so it isn't necessary to clean up - Swizzle Free(™)

### API

#### [Properties](https://github.com/seivan/SHTabBarControllerBlocks#properties-1)


##Installation

```ruby
pod 'SHTabBarControllerBlocks'
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


#pragma mark - Properties

#pragma mark - Setters
-(void)SH_setShouldSelectViewControllerBlock:(SHTabBarControllerPredicateBlock)theBlock;
-(void)SH_setDidSelectViewControllerBlock:(SHTabBarControllerBlock)theBlock;
-(void)SH_setWillBeginCustomizingViewControllersBlock:(SHTabBarControllerCustomizingBlock)theBlock;
-(void)SH_setWillEndCustomizingViewControllersBlock:(SHTabBarControllerCustomizingWithChangeBlock)theBlock;
-(void)SH_setDidEndCustomizingViewControllersBlock:(SHTabBarControllerCustomizingWithChangeBlock)theBlock;



#pragma mark - Getters
-(SHTabBarControllerPredicateBlock)SH_blockShouldSelectViewController;
-(SHTabBarControllerBlock)SH_blockDidSelectViewController;
-(SHTabBarControllerCustomizingBlock)SH_blockWillBeginCustomizingViewControllers;
-(SHTabBarControllerCustomizingWithChangeBlock)SH_blockWillEndCustomizingViewControllers;
-(SHTabBarControllerCustomizingWithChangeBlock)SH_blockDidEndCustomizingViewControllers;

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

