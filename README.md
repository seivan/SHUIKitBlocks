# SHUIKitBlocks

[![Build Status](https://travis-ci.org/seivan/SHUIKitBlocks.png?branch=master)](https://travis-ci.org/seivan/SHUIKitBlocks)
[![Version](https://cocoapod-badges.herokuapp.com/v/SHUIKitBlocks/badge.png)](http://cocoadocs.org/docsets/SHUIKitBlocks)
[![Platform](https://cocoapod-badges.herokuapp.com/p/SHUIKitBlocks/badge.png)](http://cocoadocs.org/docsets/SHUIKitBlocks)


##### Prefixed Blocks for UIKit on categories __without__ libffi and swizzling


`SHUIKitBlocks` allows you to use blocks instead of delegates for entire UIKit without any hacks or libffi dependencies. 

> This pod is part of a many components covering to plug the holes missing from Foundation, UIKit, CoreLocation, GameKit, MapKit and other aspects of an iOS application's architecture. 

- [SHFoundationAdditions](https://github.com/seivan/SHFoundationAdditions)
- [SHGameCenter](https://github.com/seivan/SHGameCenter)
- [SHMessageUIBlocks](https://github.com/seivan/SHMessageUIBlocks)


##Install
```ruby
pod 'SHUIKitBlocks' #for iOS 7
pod 'SHUIKitBlocks', '~> 1.6.0' # for iOS 6
```

##Dependency Status

| Library        | Tests           | Version  | Platform  |
| ------------- |:-------------:| -----:|  -----:| 
| [SHAlertViewBlocks](https://github.com/seivan/SHAlertViewBlocks)| [![Build Status](https://travis-ci.org/seivan/SHAlertViewBlocks.png?branch=master)](https://travis-ci.org/seivan/SHAlertViewBlocks)| [![Version](https://cocoapod-badges.herokuapp.com/v/SHAlertViewBlocks/badge.png)](http://cocoadocs.org/docsets/SHAlertViewBlocks) | [![Platform](https://cocoapod-badges.herokuapp.com/p/SHAlertViewBlocks/badge.png)](http://cocoadocs.org/docsets/SHAlertViewBlocks) |
| [SHControlBlocks](https://github.com/seivan/SHControlBlocks)| [![Build Status](https://travis-ci.org/seivan/SHControlBlocks.png?branch=master)](https://travis-ci.org/seivan/SHControlBlocks)| [![Version](https://cocoapod-badges.herokuapp.com/v/SHControlBlocks/badge.png)](http://cocoadocs.org/docsets/SHControlBlocks) | [![Platform](https://cocoapod-badges.herokuapp.com/p/SHControlBlocks/badge.png)](http://cocoadocs.org/docsets/SHControlBlocks) |
| [SHSegueBlocks](https://github.com/seivan/SHSegueBlocks)| [![Build Status](https://travis-ci.org/seivan/SHSegueBlocks.png?branch=master)](https://travis-ci.org/seivan/SHSegueBlocks)| [![Version](https://cocoapod-badges.herokuapp.com/v/SHSegueBlocks/badge.png)](http://cocoadocs.org/docsets/SHSegueBlocks) | [![Platform](https://cocoapod-badges.herokuapp.com/p/SHSegueBlocks/badge.png)](http://cocoadocs.org/docsets/SHSegueBlocks) |
| [SHNavigationControllerBlocks](https://github.com/seivan/SHNavigationControllerBlocks)| [![Build Status](https://travis-ci.org/seivan/SHNavigationControllerBlocks.png?branch=master)](https://travis-ci.org/seivan/SHNavigationControllerBlocks)| [![Version](https://cocoapod-badges.herokuapp.com/v/SHNavigationControllerBlocks/badge.png)](http://cocoadocs.org/docsets/SHNavigationControllerBlocks) | [![Platform](https://cocoapod-badges.herokuapp.com/p/SHNavigationControllerBlocks/badge.png)](http://cocoadocs.org/docsets/SHNavigationControllerBlocks) |
| [SHWebViewBlocks](https://github.com/seivan/SHWebViewBlocks)| [![Build Status](https://travis-ci.org/seivan/SHWebViewBlocks.png?branch=master)](https://travis-ci.org/seivan/SHWebViewBlocks)| [![Version](https://cocoapod-badges.herokuapp.com/v/SHWebViewBlocks/badge.png)](http://cocoadocs.org/docsets/SHWebViewBlocks) | [![Platform](https://cocoapod-badges.herokuapp.com/p/SHWebViewBlocks/badge.png)](http://cocoadocs.org/docsets/SHWebViewBlocks) |
| [SHPopoverControllerBlocks](https://github.com/seivan/SHPopoverControllerBlocks)| [![Build Status](https://travis-ci.org/seivan/SHPopoverControllerBlocks.png?branch=master)](https://travis-ci.org/seivan/SHPopoverControllerBlocks)| [![Version](https://cocoapod-badges.herokuapp.com/v/SHPopoverControllerBlocks/badge.png)](http://cocoadocs.org/docsets/SHPopoverControllerBlocks) | [![Platform](https://cocoapod-badges.herokuapp.com/p/SHPopoverControllerBlocks/badge.png)](http://cocoadocs.org/docsets/SHPopoverControllerBlocks) |
| [SHBarButtonItemBlocks](https://github.com/seivan/SHBarButtonItemBlocks)| [![Build Status](https://travis-ci.org/seivan/SHBarButtonItemBlocks.png?branch=master)](https://travis-ci.org/seivan/SHBarButtonItemBlocks)| [![Version](https://cocoapod-badges.herokuapp.com/v/SHBarButtonItemBlocks/badge.png)](http://cocoadocs.org/docsets/SHBarButtonItemBlocks) | [![Platform](https://cocoapod-badges.herokuapp.com/p/SHBarButtonItemBlocks/badge.png)](http://cocoadocs.org/docsets/SHBarButtonItemBlocks) |
| [SHActionSheetBlocks](https://github.com/seivan/SHActionSheetBlocks)| [![Build Status](https://travis-ci.org/seivan/SHActionSheetBlocks.png?branch=master)](https://travis-ci.org/seivan/SHActionSheetBlocks)| [![Version](https://cocoapod-badges.herokuapp.com/v/SHActionSheetBlocks/badge.png)](http://cocoadocs.org/docsets/SHActionSheetBlocks) | [![Platform](https://cocoapod-badges.herokuapp.com/p/SHActionSheetBlocks/badge.png)](http://cocoadocs.org/docsets/SHActionSheetBlocks) |
| [SHGestureRecognizerBlocks](https://github.com/seivan/SHGestureRecognizerBlocks)| [![Build Status](https://travis-ci.org/seivan/SHGestureRecognizerBlocks.png?branch=master)](https://travis-ci.org/seivan/SHGestureRecognizerBlocks)| [![Version](https://cocoapod-badges.herokuapp.com/v/SHGestureRecognizerBlocks/badge.png)](http://cocoadocs.org/docsets/SHGestureRecognizerBlocks) | [![Platform](https://cocoapod-badges.herokuapp.com/p/SHGestureRecognizerBlocks/badge.png)](http://cocoadocs.org/docsets/SHGestureRecognizerBlocks) |
| [SHTextFieldBlocks](https://github.com/seivan/SHTextFieldBlocks)| [![Build Status](https://travis-ci.org/seivan/SHTextFieldBlocks.png?branch=master)](https://travis-ci.org/seivan/SHTextFieldBlocks)| [![Version](https://cocoapod-badges.herokuapp.com/v/SHTextFieldBlocks/badge.png)](http://cocoadocs.org/docsets/SHTextFieldBlocks) | [![Platform](https://cocoapod-badges.herokuapp.com/p/SHTextFieldBlocks/badge.png)](http://cocoadocs.org/docsets/SHTextFieldBlocks) |
| [SHTextViewBlocks](https://github.com/seivan/SHTextViewBlocks)| [![Build Status](https://travis-ci.org/seivan/SHTextViewBlocks.png?branch=master)](https://travis-ci.org/seivan/SHTextViewBlocks)| [![Version](https://cocoapod-badges.herokuapp.com/v/SHTextViewBlocks/badge.png)](http://cocoadocs.org/docsets/SHTextViewBlocks) | [![Platform](https://cocoapod-badges.herokuapp.com/p/SHTextViewBlocks/badge.png)](http://cocoadocs.org/docsets/SHTextViewBlocks) |
| [SHTabBarControllerBlocks](https://github.com/seivan/SHTabBarControllerBlocks)| [![Build Status](https://travis-ci.org/seivan/SHTabBarControllerBlocks.png?branch=master)](https://travis-ci.org/seivan/SHTabBarControllerBlocks)| [![Version](https://cocoapod-badges.herokuapp.com/v/SHTabBarControllerBlocks/badge.png)](http://cocoadocs.org/docsets/SHTabBarControllerBlocks) | [![Platform](https://cocoapod-badges.herokuapp.com/p/SHTabBarControllerBlocks/badge.png)](http://cocoadocs.org/docsets/SHTabBarControllerBlocks) |
| [SHTransitionBlocks](https://github.com/seivan/SHTransitionBlocks)| [![Build Status](https://travis-ci.org/seivan/SHTransitionBlocks.png?branch=master)](https://travis-ci.org/seivan/SHTransitionBlocks)| [![Version](https://cocoapod-badges.herokuapp.com/v/SHTransitionBlocks/badge.png)](http://cocoadocs.org/docsets/SHTransitionBlocks) | [![Platform](https://cocoapod-badges.herokuapp.com/p/SHTransitionBlocks/badge.png)](http://cocoadocs.org/docsets/SHTransitionBlocks) |

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
