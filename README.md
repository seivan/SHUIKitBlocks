Deprecated please use http://[RxCocoa](https://github.com/ReactiveX/RxSwift)
# SHUIKitBlocks

[![CI Status](https://img.shields.io/travis/seivan/SHUIKitBlocks.svg?style=flat)](https://travis-ci.org/seivan/SHUIKitBlocks)
[![Version](https://img.shields.io/cocoapods/v/SHUIKitBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHUIKitBlocks)
[![Platform](https://img.shields.io/cocoapods/p/SHUIKitBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHUIKitBlocks)
[![License](https://img.shields.io/cocoapods/l/SHUIKitBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHUIKitBlocks)



##### Prefixed Blocks for UIKit on categories __without__ libffi and swizzling


`SHUIKitBlocks` allows you to use blocks instead of delegates for most of UIKit without any hacks or libffi dependencies. Works perfectly on 64bit (iPhone 5s) 

> This pod is part of a many components covering to plug the holes missing from Foundation, UIKit, CoreLocation, GameKit, MapKit and other aspects of an iOS application's architecture. Other components are: 

- [SHFoundationAdditions](https://github.com/seivan/SHFoundationAdditions)
- [SHGameCenter](https://github.com/seivan/SHGameCenter)
- [SHMessageUIBlocks](https://github.com/seivan/SHMessageUIBlocks)


##Install
```ruby
pod 'SHUIKitBlocks' #for iOS 7
pod 'SHUIKitBlocks', '~> 1.6.0' # for iOS 6
```

##Dependency Status

| Library        | Tests           | Version  | Platform  | License |
| ------------- |:-------------:| -----:|  -----:| -----:| -----:|  
| [SHAlertViewBlocks](https://github.com/seivan/SHAlertViewBlocks) | [![CI Status](https://img.shields.io/travis/seivan/SHAlertViewBlocks.svg?style=flat)](https://travis-ci.org/seivan/SHAlertViewBlocks) | [![Version](https://img.shields.io/cocoapods/v/SHAlertViewBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHAlertViewBlocks) | [![Platform](https://img.shields.io/cocoapods/p/SHAlertViewBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHAlertViewBlocks) | [![License](https://img.shields.io/cocoapods/l/SHAlertViewBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHAlertViewBlocks)
| [SHControlBlocks](https://github.com/seivan/SHControlBlocks) | [![CI Status](https://img.shields.io/travis/seivan/SHControlBlocks.svg?style=flat)](https://travis-ci.org/seivan/SHControlBlocks) | [![Version](https://img.shields.io/cocoapods/v/SHControlBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHControlBlocks) | [![Platform](https://img.shields.io/cocoapods/p/SHControlBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHControlBlocks) | [![License](https://img.shields.io/cocoapods/l/SHControlBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHControlBlocks)
| [SHSegueBlocks](https://github.com/seivan/SHSegueBlocks) | [![CI Status](https://img.shields.io/travis/seivan/SHSegueBlocks.svg?style=flat)](https://travis-ci.org/seivan/SHSegueBlocks) | [![Version](https://img.shields.io/cocoapods/v/SHSegueBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHSegueBlocks) | [![Platform](https://img.shields.io/cocoapods/p/SHSegueBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHSegueBlocks) | [![License](https://img.shields.io/cocoapods/l/SHSegueBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHSegueBlocks)
| [SHNavigationControllerBlocks](https://github.com/seivan/SHNavigationControllerBlocks) | [![CI Status](https://img.shields.io/travis/seivan/SHNavigationControllerBlocks.svg?style=flat)](https://travis-ci.org/seivan/SHNavigationControllerBlocks) | [![Version](https://img.shields.io/cocoapods/v/SHNavigationControllerBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHNavigationControllerBlocks) | [![Platform](https://img.shields.io/cocoapods/p/SHNavigationControllerBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHNavigationControllerBlocks) | [![License](https://img.shields.io/cocoapods/l/SHNavigationControllerBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHNavigationControllerBlocks)
| [SHWebViewBlocks](https://github.com/seivan/SHWebViewBlocks) | [![CI Status](https://img.shields.io/travis/seivan/SHWebViewBlocks.svg?style=flat)](https://travis-ci.org/seivan/SHWebViewBlocks) | [![Version](https://img.shields.io/cocoapods/v/SHWebViewBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHWebViewBlocks) | [![Platform](https://img.shields.io/cocoapods/p/SHWebViewBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHWebViewBlocks) | [![License](https://img.shields.io/cocoapods/l/SHWebViewBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHWebViewBlocks)
| [SHPopoverControllerBlocks](https://github.com/seivan/SHPopoverControllerBlocks) | [![CI Status](https://img.shields.io/travis/seivan/SHPopoverControllerBlocks.svg?style=flat)](https://travis-ci.org/seivan/SHPopoverControllerBlocks) | [![Version](https://img.shields.io/cocoapods/v/SHPopoverControllerBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHPopoverControllerBlocks) | [![Platform](https://img.shields.io/cocoapods/p/SHPopoverControllerBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHPopoverControllerBlocks) | [![License](https://img.shields.io/cocoapods/l/SHPopoverControllerBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHPopoverControllerBlocks)
| [SHBarButtonItemBlocks](https://github.com/seivan/SHBarButtonItemBlocks) | [![CI Status](https://img.shields.io/travis/seivan/SHBarButtonItemBlocks.svg?style=flat)](https://travis-ci.org/seivan/SHBarButtonItemBlocks) | [![Version](https://img.shields.io/cocoapods/v/SHBarButtonItemBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHBarButtonItemBlocks) | [![Platform](https://img.shields.io/cocoapods/p/SHBarButtonItemBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHBarButtonItemBlocks) | [![License](https://img.shields.io/cocoapods/l/SHBarButtonItemBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHBarButtonItemBlocks)
| [SHActionSheetBlocks](https://github.com/seivan/SHActionSheetBlocks) | [![CI Status](https://img.shields.io/travis/seivan/SHActionSheetBlocks.svg?style=flat)](https://travis-ci.org/seivan/SHActionSheetBlocks) | [![Version](https://img.shields.io/cocoapods/v/SHActionSheetBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHActionSheetBlocks) | [![Platform](https://img.shields.io/cocoapods/p/SHActionSheetBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHActionSheetBlocks) | [![License](https://img.shields.io/cocoapods/l/SHActionSheetBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHActionSheetBlocks)
| [SHGestureRecognizerBlocks](https://github.com/seivan/SHGestureRecognizerBlocks) | [![CI Status](https://img.shields.io/travis/seivan/SHGestureRecognizerBlocks.svg?style=flat)](https://travis-ci.org/seivan/SHGestureRecognizerBlocks) | [![Version](https://img.shields.io/cocoapods/v/SHGestureRecognizerBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHGestureRecognizerBlocks) | [![Platform](https://img.shields.io/cocoapods/p/SHGestureRecognizerBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHGestureRecognizerBlocks) | [![License](https://img.shields.io/cocoapods/l/SHGestureRecognizerBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHGestureRecognizerBlocks)
| [SHTextFieldBlocks](https://github.com/seivan/SHTextFieldBlocks) | [![CI Status](https://img.shields.io/travis/seivan/SHTextFieldBlocks.svg?style=flat)](https://travis-ci.org/seivan/SHTextFieldBlocks) | [![Version](https://img.shields.io/cocoapods/v/SHTextFieldBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHTextFieldBlocks) | [![Platform](https://img.shields.io/cocoapods/p/SHTextFieldBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHTextFieldBlocks) | [![License](https://img.shields.io/cocoapods/l/SHTextFieldBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHTextFieldBlocks)
| [SHTextViewBlocks](https://github.com/seivan/SHTextViewBlocks) | [![CI Status](https://img.shields.io/travis/seivan/SHTextViewBlocks.svg?style=flat)](https://travis-ci.org/seivan/SHTextViewBlocks) | [![Version](https://img.shields.io/cocoapods/v/SHTextViewBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHTextViewBlocks) | [![Platform](https://img.shields.io/cocoapods/p/SHTextViewBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHTextViewBlocks) | [![License](https://img.shields.io/cocoapods/l/SHTextViewBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHTextViewBlocks)
| [SHTabBarControllerBlocks](https://github.com/seivan/SHTabBarControllerBlocks) | [![CI Status](https://img.shields.io/travis/seivan/SHTabBarControllerBlocks.svg?style=flat)](https://travis-ci.org/seivan/SHTabBarControllerBlocks) | [![Version](https://img.shields.io/cocoapods/v/SHTabBarControllerBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHTabBarControllerBlocks) | [![Platform](https://img.shields.io/cocoapods/p/SHTabBarControllerBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHTabBarControllerBlocks) | [![License](https://img.shields.io/cocoapods/l/SHTabBarControllerBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHTabBarControllerBlocks)
| [SHTransitionBlocks](https://github.com/seivan/SHTransitionBlocks) | [![CI Status](https://img.shields.io/travis/seivan/SHTransitionBlocks.svg?style=flat)](https://travis-ci.org/seivan/SHTransitionBlocks) | [![Version](https://img.shields.io/cocoapods/v/SHTransitionBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHTransitionBlocks) | [![Platform](https://img.shields.io/cocoapods/p/SHTransitionBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHTransitionBlocks) | [![License](https://img.shields.io/cocoapods/l/SHTransitionBlocks.svg?style=flat)](http://cocoadocs.org/docsets/SHTransitionBlocks)

##Import

>Per Library

```objective-c
#import "<Library>.h"
```

>For everything

```objective-c
#import "SHUIKitBlocks.h"
```

##Contact


If you end up using SHUIKitBlocks in a project, I'd love to hear about it.

email: [seivan.heidari@icloud.com](mailto:seivan.heidari@icloud.com)  
twitter: [@seivanheidari](https://twitter.com/seivanheidari)

##License

SHUIKitBlocks is © 2013 [Seivan](https://www.github.com/seivan) and may be freely
distributed under the [MIT license](https://opensource.org/licenses/MIT).
See the [`LICENSE.md`](https://github.com/seivan/SHUIKitBlocks/blob/master/LICENSE.md) file.
