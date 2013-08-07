//
//  UIControl+SHControlEventBlock.h
//  Example
//
//  Created by Seivan Heidari on 5/16/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#pragma mark -
#pragma mark Block Defs
typedef void (^SHBarButtonItemBlock)(UIBarButtonItem * sender);

@interface UIBarButtonItem (SHBarButtonItemBlocks)

#pragma mark -
#pragma mark Init
+(instancetype)SH_barButtonItemWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem
                                 withBlock:(SHBarButtonItemBlock)theBlock;

+(instancetype)SH_barButtonItemWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style
                   withBlock:(SHBarButtonItemBlock)theBlock;

+(instancetype)SH_barButtonItemWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style
                   withBlock:(SHBarButtonItemBlock)theBlock;

#pragma mark -
#pragma mark Add
-(void)SH_addBlock:(SHBarButtonItemBlock)theBlock;

#pragma mark -
#pragma mark Remove
-(void)SH_removeBlock:(SHBarButtonItemBlock)theBlock;
-(void)SH_removeAllBlocks;

#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Getters
@property(nonatomic,readonly) NSSet * SH_blocks;

@end
