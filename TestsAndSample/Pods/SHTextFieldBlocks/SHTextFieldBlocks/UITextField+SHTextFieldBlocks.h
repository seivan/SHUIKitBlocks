//
//  UIControl+SHControlEventBlock.h
//  Example
//
//  Created by Seivan Heidari on 5/16/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//


#pragma mark - Block Defs
typedef void (^SHTextFieldBlock)(UITextField * textField);
typedef BOOL (^SHTextFieldPredicateBlock)(UITextField * textField);

typedef BOOL (^SHTextFieldRangeReplacementBlock)(UITextField * textField,
NSRange shouldChangeCharactersInRange,
NSString * string);

@interface UITextField (SHTextFieldBlocks)


#pragma mark - Helpers

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

@end
