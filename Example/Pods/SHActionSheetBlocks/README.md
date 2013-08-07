SHActionSheetBlocks
==========
[![Build Status](https://travis-ci.org/seivan/SHActionSheetBlocks.png?branch=master)](https://travis-ci.org/seivan/SHActionSheetBlocks)
[![Version](http://cocoapod-badges.herokuapp.com/v/SHActionSheetBlocks/badge.png)](http://cocoadocs.org/docsets/SHActionSheetBlocks)
[![Platform](http://cocoapod-badges.herokuapp.com/p/SHActionSheetBlocks/badge.png)](http://cocoadocs.org/docsets/SHActionSheetBlocks)


Screenshots
------------
[![Green default](/Screenshots/Green/default_th.jpg "Green default")](https://raw.github.com/seivan/SHActionSheetBlocks/master/Screenshots/Green/default.png)
[![Green selected](/Screenshots/Green/selected_th.jpg "Green selected")](https://raw.github.com/seivan/SHActionSheetBlocks/master/Screenshots/Green/selected.png)
[![Green cancel-selected](/Screenshots/Green/cancel-selected_th.jpg "Green cancel-selected")](https://raw.github.com/seivan/SHActionSheetBlocks/master/Screenshots/Green/cancel-selected.png)

[![Blue default](/Screenshots/Blue/default_th.jpg "Blue default")](https://raw.github.com/seivan/SHActionSheetBlocks/master/Screenshots/Blue/default.png)
[![Blue selected](/Screenshots/Blue/selected_th.jpg "Blue selected")](https://raw.github.com/seivan/SHActionSheetBlocks/master/Screenshots/Blue/selected.png)
[![Blue cancel-selected](/Screenshots/Blue/cancel-selected_th.jpg "Blue cancel-selected")](https://raw.github.com/seivan/SHActionSheetBlocks/master/Screenshots/Blue/cancel-selected.png)

[![Purple default](/Screenshots/Purple/default_th.jpg "Purple default")](https://raw.github.com/seivan/SHActionSheetBlocks/master/Screenshots/Purple/default.png)
[![Purple selected](/Screenshots/Purple/selected_th.jpg "Purple selected")](https://raw.github.com/seivan/SHActionSheetBlocks/master/Screenshots/Purple/selected.png)
[![Purple cancel-selected](/Screenshots/Purple/cancel-selected_th.jpg "Purple cancel-selected")](https://raw.github.com/seivan/SHActionSheetBlocks/master/Screenshots/Purple/cancel-selected.png)

Overview
--------
The blocks are automatically removed once the sheet is gone, so it isn't necessary to clean up - Swizzle Free(™)

### API

#### [Init](#init-1)

#### [Add](#add-1)

#### [Properties](#properties-1)


Installation
------------

```ruby
pod 'SHActionSheetBlocks'
```

***

Setup
-----

Put this either in specific files or your project prefix file

```objective-c
#import "UIActionSheet+SHActionSheetBlocks.h"
```
or
```objective-c
#import "SHActionSheetBlocks.h"
```

API
-----

### Init

```objective-c
#pragma mark -
#pragma mark Init
+(instancetype)SH_actionSheetWithTitle:(NSString *)theTitle;

+(instancetype)SH_actionSheetWithTitle:(NSString *)theTitle
                          buttonTitles:(id<NSFastEnumeration>)theButtonTitles
                           cancelTitle:(NSString *)theCancelTitle
                      destructiveTitle:(NSString *)theDestructiveTitle
                             withBlock:(SHActionSheetBlock)theBlock;

```

### Add

```objective-c
#pragma mark -
#pragma mark Adding
-(NSInteger)SH_addButtonWithTitle:(NSString *)theTitle
                      withBlock:(SHActionSheetBlock)theBlock;

///Will add a new destructive button and make previous Destructive buttons to normal
-(NSInteger)SH_addButtonDestructiveWithTitle:(NSString *)theTitle
                                    withBlock:(SHActionSheetBlock)theBlock;

///Will add a new destructive button and make previous Destructive buttons to normal
-(NSInteger)SH_addButtonCancelWithTitle:(NSString *)theTitle
                               withBlock:(SHActionSheetBlock)theBlock;

```

### Properties

```objective-c
#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Setters
-(void)SH_setButtonBlockForIndex:(NSInteger)theButtonIndex
                       withBlock:(SHActionSheetBlock)theBlock;


-(void)SH_setButtonDestructiveBlock:(SHActionSheetBlock)theBlock;
-(void)SH_setButtonCancelBlock:(SHActionSheetBlock)theBlock;

-(void)SH_setWillShowBlock:(SHActionSheetShowBlock)theBlock;
-(void)SH_setDidShowBlock:(SHActionSheetShowBlock)theBlock;

-(void)SH_setWillDismissBlock:(SHActionSheetDismissBlock)theBlock;
-(void)SH_setDidDismissBlock:(SHActionSheetDismissBlock)theBlock;

#pragma mark -
#pragma mark Getters
-(SHActionSheetBlock)SH_blockForButtonIndex:(NSInteger)theButtonIndex;

@property(nonatomic,readonly) SHActionSheetBlock SH_blockForDestructiveButton;
@property(nonatomic,readonly) SHActionSheetBlock SH_blockForCancelButton;


@property(nonatomic,readonly) SHActionSheetShowBlock    SH_blockWillShow;
@property(nonatomic,readonly) SHActionSheetShowBlock    SH_blockDidShow;

@property(nonatomic,readonly) SHActionSheetDismissBlock SH_blockWillDismiss;
@property(nonatomic,readonly) SHActionSheetDismissBlock SH_blockDidDismiss;

```


Contact
-------

If you end up using SHActionSheetBlocks in a project, I'd love to hear about it.

email: [seivan.heidari@icloud.com](mailto:seivan.heidari@icloud.com)  
twitter: [@seivanheidari](https://twitter.com/seivanheidari)

## License

SHActionSheetBlocks is © 2013 [Seivan](http://www.github.com/seivan) and may be freely
distributed under the [MIT license](http://opensource.org/licenses/MIT).
See the [`LICENSE.md`](https://github.com/seivan/SHActionSheetBlocks/blob/master/LICENSE.md) file.

