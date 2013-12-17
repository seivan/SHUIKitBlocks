//
//  UIAlertView+SHAlertViewBlocks.h
//  Example
//
//  Created by Seivan Heidari on 5/16/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#pragma mark -
#pragma mark Block Defs
typedef void (^SHAlertViewBlock)(NSInteger theButtonIndex);
typedef void (^SHAlertViewShowBlock)(UIAlertView * theAlertView);
typedef void (^SHAlertViewDismissBlock)(UIAlertView * theAlertView, NSInteger theButtonIndex);

typedef BOOL (^SHAlertViewFirstButtonEnabledBlock)(UIAlertView * theAlertView);

@interface UIAlertView (SHAlertViewBlocks)


#pragma mark - Init
+(instancetype)SH_alertViewWithTitle:(NSString *)theTitle withMessage:(NSString *)theMessage;

+(instancetype)SH_alertViewWithTitle:(NSString *)theTitle
                          andMessage:(NSString *)theMessage
                        buttonTitles:(NSArray *)theButtonTitles
                         cancelTitle:(NSString *)theCancelTitle
                           withBlock:(SHAlertViewBlock)theBlock;



#pragma mark - Adding
-(NSInteger)SH_addButtonWithTitle:(NSString *)theTitle
                         withBlock:(SHAlertViewBlock)theBlock;


///Will add a new cancel button and make previous cancel buttons to a normal button
-(NSInteger)SH_addButtonCancelWithTitle:(NSString *)theTitle
                               withBlock:(SHAlertViewBlock)theBlock;


#pragma mark - Properties


#pragma mark - Setters
-(void)SH_setButtonBlockForIndex:(NSInteger)theButtonIndex
                       withBlock:(SHAlertViewBlock)theBlock;

-(void)SH_setButtonCancelBlock:(SHAlertViewBlock)theBlock;

-(void)SH_setWillShowBlock:(SHAlertViewShowBlock)theBlock;
-(void)SH_setDidShowBlock:(SHAlertViewShowBlock)theBlock;

-(void)SH_setWillDismissBlock:(SHAlertViewDismissBlock)theBlock;
-(void)SH_setDidDismissBlock:(SHAlertViewDismissBlock)theBlock;

-(void)SH_setFirstButtonEnabledBlock:(SHAlertViewFirstButtonEnabledBlock)theBlock;


#pragma mark - Getters
-(SHAlertViewBlock)SH_blockForButtonIndex:(NSInteger)theButtonIndex;


@property(nonatomic,readonly) SHAlertViewBlock SH_blockForCancelButton;


@property(nonatomic,readonly) SHAlertViewShowBlock    SH_blockWillShow;
@property(nonatomic,readonly) SHAlertViewShowBlock    SH_blockDidShow;

@property(nonatomic,readonly) SHAlertViewDismissBlock SH_blockWillDismiss;
@property(nonatomic,readonly) SHAlertViewDismissBlock SH_blockDidDismiss;

@property(nonatomic,readonly) SHAlertViewFirstButtonEnabledBlock SH_blockForFirstButtonEnabled;

@end
