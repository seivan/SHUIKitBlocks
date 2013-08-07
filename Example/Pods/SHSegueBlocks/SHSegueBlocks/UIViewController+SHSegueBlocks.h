//
//  UIViewController+SHSegueBlock.h
//  Example
//
//  Created by Seivan Heidari on 5/16/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#pragma mark -
#pragma mark Block Defs

typedef void(^SHPrepareForSegue)(UIStoryboardSegue *theSegue);
typedef void(^SHPrepareForSegueDestinationViewController)(UIViewController * theDestinationViewController);
typedef void(^SHPrepareForSegueWithUserInfo)(NSMutableDictionary * theUserInfo);



@interface UIViewController (SHSegueBlocks)


//#pragma mark - Properties
//
//@property(nonatomic,strong) NSMutableDictionary * SH_userInfo;


#pragma mark - Segue Performers


-(void)SH_performSegueWithIdentifier:(NSString *)theIdentifier
           andPrepareForSegueBlock:(SHPrepareForSegue)theBlock;

-(void)SH_performSegueWithIdentifier:(NSString *)theIdentifier
             andDestinationViewController:(SHPrepareForSegueDestinationViewController)theBlock;

-(void)SH_performSegueWithIdentifier:(NSString *)theIdentifier
                        withUserInfo:(NSDictionary *)theUserInfo;


#pragma mark - Helpers
-(BOOL)SH_handlesBlockForSegue:(UIStoryboardSegue *)theSegue;



@end
