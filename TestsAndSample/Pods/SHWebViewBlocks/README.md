SHWebViewBlocks
==========
[![Build Status](https://travis-ci.org/seivan/SHWebViewBlocks.png?branch=master)](https://travis-ci.org/seivan/SHWebViewBlocks)
[![Version](https://cocoapod-badges.herokuapp.com/v/SHWebViewBlocks/badge.png)](http://cocoadocs.org/docsets/SHWebViewBlocks)
[![Platform](https://cocoapod-badges.herokuapp.com/p/SHWebViewBlocks/badge.png)](http://cocoadocs.org/docsets/SHWebViewBlocks)

> This pod is used by [`SHUIKitBlocks`](https://github.com/seivan/SHUIKitBlocks) as part of many components covering to plug the holes missing from Foundation, UIKit, CoreLocation, GameKit, MapKit and other aspects of an iOS application's architecture.

Overview
--------
Request blocks for UIWebView. 
The blocks are automatically removed once they UIWebView is gone, so it isn't necessary to clean up - Swizzle Free(™)

### API

#### [Helpers](https://github.com/seivan/SHWebViewBlocks#helpers-1)

#### [Properties](https://github.com/seivan/SHWebViewBlocks#properties-1)


Installation
------------

```ruby
pod 'SHWebViewBlocks'
```

***

Setup
-----

Put this either in specific files or your project prefix file

```objective-c
#import "UIWebView+SHWebViewBlocks.h"
```
or
```objective-c
#import "SHWebViewBlocks.h"
```


API
-----

### Helpers

```objective-c

#pragma mark -
#pragma mark Helpers
-(void)SH_loadRequestWithString:(NSString *)theString;


```

### Properties

```objective-c

#pragma mark -
#pragma mark Block Def
typedef void (^SHWebViewBlock)(UIWebView * theWebView);

typedef void (^SHWebViewBlockWithError)(UIWebView * theWebView, NSError * theError);

typedef BOOL (^SHWebViewBlockWithRequest)(UIWebView * theWebView, NSURLRequest * theRequest,UIWebViewNavigationType theNavigationType);

                                            
#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Setters


-(void)SH_setShouldStartLoadWithRequestBlock:(SHWebViewBlockWithRequest)theBlock;

-(void)SH_setDidStartLoadBlock:(SHWebViewBlock)theBlock;

-(void)SH_setDidFinishLoadBlock:(SHWebViewBlock)theBlock;

-(void)SH_setDidFailLoadWithErrorBlock:(SHWebViewBlockWithError)theBlock;




#pragma mark -
#pragma mark Getters

@property(nonatomic,readonly) SHWebViewBlockWithRequest SH_blockShouldStartLoadingWithRequest;

@property(nonatomic,readonly) SHWebViewBlock SH_blockDidStartLoad;

@property(nonatomic,readonly) SHWebViewBlock SH_blockDidFinishLoad;

@property(nonatomic,readonly) SHWebViewBlockWithError SH_blockDidFailLoadWithError;

```


Contact
-------

If you end up using SHWebViewBlocks in a project, I'd love to hear about it.

email: [seivan.heidari@icloud.com](mailto:seivan.heidari@icloud.com)  
twitter: [@seivanheidari](https://twitter.com/seivanheidari)

## License

SHWebViewBlocks is © 2013 [Seivan](http://www.github.com/seivan) and may be freely
distributed under the [MIT license](http://opensource.org/licenses/MIT).
See the [`LICENSE.md`](https://github.com/seivan/SHWebViewBlocks/blob/master/LICENSE.md) file.

