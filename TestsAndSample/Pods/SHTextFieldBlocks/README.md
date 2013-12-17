#SHTextFieldBlocks

[![Build Status](https://travis-ci.org/seivan/SHTextFieldBlocks.png?branch=master)](https://travis-ci.org/seivan/SHTextFieldBlocks)
[![Version](https://cocoapod-badges.herokuapp.com/v/SHTextFieldBlocks/badge.png)](http://cocoadocs.org/docsets/SHTextFieldBlocks)
[![Platform](https://cocoapod-badges.herokuapp.com/p/SHTextFieldBlocks/badge.png)](http://cocoadocs.org/docsets/SHTextFieldBlocks)

> This pod is used by [`SHUIKitBlocks`](https://github.com/seivan/SHUIKitBlocks) as part of many components covering to plug the holes missing from Foundation, UIKit, CoreLocation, GameKit, MapKit and other aspects of an iOS application's architecture.

##Overview

Using blocks instead of delegate callbacks for UITextField. The blocks are gone once the textfield is gone - Swizzle Free(™)

##Installation

```ruby
pod 'SHTextFieldBlocks'
```


##Setup

Put this either in specific files or your project prefix file
```objective-c
#import "UITextField+SHTextFieldBlocks.h"
```
or
```objective-c
#import "SHTextFieldBlocks.h"
```

##API

```objective-c
#pragma mark - Block Defs
typedef void (^SHTextFieldBlock)(UITextField * textField);
typedef BOOL (^SHTextFieldPredicateBlock)(UITextField * textField);

typedef BOOL (^SHTextFieldRangeReplacementBlock)(UITextField * textField,
NSRange shouldChangeCharactersInRange,
NSString * string);

#pragma mark - Properties

#pragma mark - Setters

-(void)SH_setShouldBeginEditingBlock:(SHTextFieldPredicateBlock)theBlock;

-(void)SH_setDidBeginEditingBlock:(SHTextFieldBlock)theBlock;

-(void)SH_setShouldEndEditingBlock:(SHTextFieldPredicateBlock)theBlock;

-(void)SH_setDidEndEditingBlock:(SHTextFieldBlock)theBlock;

-(void)SH_setShouldChangeCharactersInRangeWithReplacementStringBlock:(SHTextFieldRangeReplacementBlock)theBlock;

-(void)SH_setShouldClearBlock:(SHTextFieldPredicateBlock)theBlock;

-(void)SH_setShouldReturnBlock:(SHTextFieldPredicateBlock)theBlock;


#pragma mark - Getters

-(SHTextFieldPredicateBlock)SH_blockShouldBeginEditing;

-(SHTextFieldBlock)SH_blockDidBeginEditing;

-(SHTextFieldPredicateBlock)SH_blockShouldEndEditing;

-(SHTextFieldBlock)SH_blockDidEndEditing;

-(SHTextFieldRangeReplacementBlock)SH_blockShouldChangeCharactersInRangeWithReplacementString;

-(SHTextFieldPredicateBlock)SH_blockShouldClear;

-(SHTextFieldPredicateBlock)SH_blockShouldReturn;


```


Contact
-------

If you end up using SHTextFieldBlocks in a project, I'd love to hear about it.

email: [seivan.heidari@icloud.com](mailto:seivan.heidari@icloud.com)  
twitter: [@seivanheidari](https://twitter.com/seivanheidari)

## License

SHTextFieldBlocks is © 2013 [Seivan](http://www.github.com/seivan) and may be freely
distributed under the [MIT license](http://opensource.org/licenses/MIT).
See the [`LICENSE.md`](https://github.com/seivan/SHTextFieldBlocks/blob/master/LICENSE.md) file.
