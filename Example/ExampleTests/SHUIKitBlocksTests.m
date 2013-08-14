//
//  ExampleTests.m
//  ExampleTests
//
//  Created by Seivan Heidari on 8/7/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "SHUIKitBlocks.h"

#import <SenTestingKit/SenTestingKit.h>

@interface SHUIKitBlocksTests : SenTestCase

@end


@implementation SHUIKitBlocksTests

-(void)testSHActionSheetBlocks ;{
  STAssertTrue([UIActionSheet.new
                respondsToSelector:@selector(SH_addButtonWithTitle:withBlock:)], nil);
}

-(void)testSHAlertViewBlocks ;{
  STAssertTrue([UIAlertView.new
                respondsToSelector:@selector(SH_addButtonWithTitle:withBlock:)], nil);
  
}

-(void)testSHBarButtonItemBlocks ;{
  STAssertTrue([UIBarButtonItem.new
                respondsToSelector:@selector(SH_addBlock:)], nil);
  
}

-(void)testSHControlBlocks ;{
  STAssertTrue([UIControl.new
                respondsToSelector:@selector(SH_addControlEvents:withBlock:)], nil);
  
}


-(void)testSHNavigationControllerBlocks ;{
  STAssertTrue([UINavigationController.new
                respondsToSelector:@selector(SH_setWillShowViewControllerBlock:)], nil);
  
}

-(void)testSHObjectUserInfo ;{
  STAssertTrue([NSObject.new
                respondsToSelector:@selector(SH_userInfo)], nil);
  
}

-(void)testSHPopoverControllerBlocks ;{
  if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    STAssertTrue([UIPopoverController.new
                  respondsToSelector:@selector(SH_setShouldDismissPopoverBlock:)], nil);

  }
    
}

-(void)testSHSegueBlocks ;{
  STAssertTrue([UIViewController.new
                respondsToSelector:@selector(SH_handlesBlockForSegue:)], nil);
 
}

-(void)testSHWebViewBlocks ;{
  STAssertTrue([UIWebView.new
                respondsToSelector:@selector(SH_setShouldStartLoadWithRequestBlock:)], nil);
  
}

-(void)testSHGestureRecognizerBlocks ;{
  STAssertTrue([UITapGestureRecognizer.new
                respondsToSelector:@selector(SH_addBlock:)], nil);
  
}

-(void)testSHTextFieldBlocks ;{
  STAssertTrue([UITextField.new
                respondsToSelector:@selector(SH_setShouldBeginEditingBlock:)], nil);
  
}

@end
