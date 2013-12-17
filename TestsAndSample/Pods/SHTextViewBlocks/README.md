#SHTextViewBlocks

[![Build Status](https://travis-ci.org/seivan/SHTextViewBlocks.png?branch=master)](https://travis-ci.org/seivan/SHTextViewBlocks)
[![Version](https://cocoapod-badges.herokuapp.com/v/SHTextViewBlocks/badge.png)](http://cocoadocs.org/docsets/SHTextViewBlocks)
[![Platform](https://cocoapod-badges.herokuapp.com/p/SHTextViewBlocks/badge.png)](http://cocoadocs.org/docsets/SHTextViewBlocks)

> This pod is used by [`SHUIKitBlocks`](https://github.com/seivan/SHUIKitBlocks) as part of many components covering to plug the holes missing from Foundation, UIKit, CoreLocation, GameKit, MapKit and other aspects of an iOS application's architecture.

##Overview

Using blocks instead of delegate callbacks for SHTextViewBlocks. The blocks are gone once the textfield is gone - Swizzle Free(™)

##Installation

```ruby
pod 'SHTextViewBlocks'
```

##Setup

Put this either in specific files or your project prefix file
```objective-c
#import "UITextView+SHTextViewBlocks.h"
```
or
```objective-c
#import "SHTextViewBlocks.h"
```

##API

```objective-c
#pragma mark - Block Defs
typedef void (^SHTextViewBlock)(UITextView * textView);
typedef BOOL (^SHTextViewPredicateBlock)(UITextView * textView);

typedef BOOL (^SHTextViewRangeReplacementBlock)(UITextView * textView,
NSRange shouldChangeTextInRange,
NSString * string);




#pragma mark - Helpers

#pragma mark - Properties

#pragma mark - Setters

-(void)SH_setShouldBeginEditingBlock:(SHTextViewPredicateBlock)theBlock;

-(void)SH_setShouldEndEditingBlock:(SHTextViewPredicateBlock)theBlock;

-(void)SH_setDidBeginEditingBlock:(SHTextViewBlock)theBlock;

-(void)SH_setDidEndEditingBlock:(SHTextViewBlock)theBlock;

-(void)SH_setShouldChangeCharactersInRangeWithReplacementTextBlock:(SHTextViewRangeReplacementBlock)theBlock;

-(void)SH_setDidChangeBlock:(SHTextViewBlock)theBlock;

-(void)SH_setDidChangeSelection:(SHTextViewBlock)theBlock;



#pragma mark - Getters

-(SHTextViewPredicateBlock)SH_blockShouldBeginEditing;

-(SHTextViewPredicateBlock)SH_blockShouldEndEditing;


-(SHTextViewBlock)SH_blockDidBeginEditing;

-(SHTextViewBlock)SH_blockDidEndEditing;

-(SHTextViewRangeReplacementBlock)SH_blockShouldChangeCharactersInRangeWithReplacementText;

-(SHTextViewBlock)SH_blockDidChangeBlock;

-(SHTextViewBlock)SH_blockDidChangeSelection;


```


##Contact


If you end up using SHTextViewBlocks in a project, I'd love to hear about it.

email: [seivan.heidari@icloud.com](mailto:seivan.heidari@icloud.com)  
twitter: [@seivanheidari](https://twitter.com/seivanheidari)

## License

SHTextViewBlocks is © 2013 [Seivan](http://www.github.com/seivan) and may be freely
distributed under the [MIT license](http://opensource.org/licenses/MIT).
See the [`LICENSE.md`](https://github.com/seivan/SHTextViewBlocks/blob/master/LICENSE.md) file.
