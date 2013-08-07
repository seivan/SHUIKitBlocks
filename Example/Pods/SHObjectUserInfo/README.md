SHObjectUserInfo
==========
[![Build Status](https://travis-ci.org/seivan/SHObjectUserInfo.png?branch=master)](https://travis-ci.org/seivan/SHObjectUserInfo)
[![Version](http://cocoapod-badges.herokuapp.com/v/SHObjectUserInfo/badge.png)](http://cocoadocs.org/docsets/SHObjectUserInfo)
[![Platform](http://cocoapod-badges.herokuapp.com/p/SHObjectUserInfo/badge.png)](http://cocoadocs.org/docsets/SHObjectUserInfo)

Overview
--------

SHObjectUserInfo is a category on top of NSObject to allow userInfo dictionary without swizzling. It's built on top of NSMapTable that works with weakToStrong references between an object and its userInfo. 


Swizzle & Junk free 
-------------------

No developer psyches were harmed or killed for this. I've noticed other similar libraries all swizzle like there is no tomorrow. If the API can remains the same without Swizzle, **then don't Swizzle.**

All in all; 50 loc for userInfo


Installation
------------

```ruby
pod 'SHObjectUserInfo'
```

***

Setup
-----

Put this either in specific classes or your project prefix file

```objective-c
#import "NSObject+SHObjectUserInfo.h"
```

or

```objective-c
#import "SHObjectUserInfo.h"
```

Usage
-----

```objective-c
myObjectThatInheritedFromNSObject.sh_userInfo = [@{@"myKey" : mYValue} mutableCopy];
``` 

If you're using [SHSegueBlocks](http://www.github.com/seivan/SHSegueBlocks)

```objective-c
[self SH_performSegueWithIdentifier:@"unwinder" withUserInfo:@{@"date" : [NSDate date]}];
```

In the destinationViewController

```objective-c
self.myDate = self.SH_userInfo[@"date"];
```

or

```objective-c
  [self SH_performSegueWithIdentifier:@"push" 
        andDestionationViewController:^(UIViewController * theDestinationViewController) {

    theDestinationViewController.SH_userInfo = myDictionary

  }];

```

Contact
-------

If you end up using SHObjectUserInfo in a project, I'd love to hear about it.

email: [seivan.heidari@icloud.com](mailto:seivan.heidari@icloud.com)  
twitter: [@seivanheidari](https://twitter.com/seivanheidari)

## License

SHObjectUserInfo is © 2013 [Seivan](http://www.github.com/seivan) and may be freely
distributed under the [MIT license](http://opensource.org/licenses/MIT).
See the [`LICENSE.md`](https://github.com/seivan/SHObjectUserInfo/blob/master/LICENSE.md) file.