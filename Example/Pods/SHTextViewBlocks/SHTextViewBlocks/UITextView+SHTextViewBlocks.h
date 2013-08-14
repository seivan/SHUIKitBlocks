//
//  UIControl+SHControlEventBlock.h
//  Example
//
//  Created by Seivan Heidari on 5/16/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//


#pragma mark - Block Defs
typedef void (^SHTextViewBlock)(UITextView * textView);
typedef BOOL (^SHTextViewPredicateBlock)(UITextView * textView);

typedef BOOL (^SHTextViewRangeReplacementBlock)(UITextView * textView,
NSRange shouldChangeTextInRange,
NSString * string);

@interface UITextView (SHTextViewBlocks)


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

-(SHTextViewBlock)SH_blockDidChange;

-(SHTextViewBlock)SH_blockDidChangeSelection;

@end
