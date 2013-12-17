//
//  ExampleTests.m
//  ExampleTests
//
//  Created by Seivan Heidari on 8/7/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "SHUIKitBlocks.h"

#import <XCTest/XCTest.h>

@interface SHUIKitBlocksTests : XCTestCase

@end


@implementation SHUIKitBlocksTests

-(void)testSHActionSheetBlocks ;{
  XCTAssertTrue([UIActionSheet.new
                respondsToSelector:@selector(SH_addButtonWithTitle:withBlock:)]);
}

-(void)testSHAlertViewBlocks ;{
  XCTAssertTrue([UIAlertView.new
                respondsToSelector:@selector(SH_addButtonWithTitle:withBlock:)]);
  
}

-(void)testSHBarButtonItemBlocks ;{
  XCTAssertTrue([UIBarButtonItem.new
                respondsToSelector:@selector(SH_addBlock:)]);
  
}

-(void)testSHControlBlocks ;{
  XCTAssertTrue([UIControl.new
                respondsToSelector:@selector(SH_addControlEvents:withBlock:)]);
  
}


-(void)testSHNavigationControllerBlocks ;{
  XCTAssertTrue([UINavigationController.new
                respondsToSelector:@selector(SH_setWillShowViewControllerBlock:)]);
  
}

-(void)testSHObjectUserInfo ;{
  XCTAssertTrue([NSObject.new
                respondsToSelector:@selector(SH_userInfo)]);
  
}

-(void)testSHPopoverControllerBlocks ;{
  if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    XCTAssertTrue([UIPopoverController.new
                  respondsToSelector:@selector(SH_setShouldDismissPopoverBlock:)]);

  }
    
}

-(void)testSHSegueBlocks ;{
  XCTAssertTrue([UIViewController.new
                respondsToSelector:@selector(SH_handlesBlockForSegue:)]);
 
}

-(void)testSHWebViewBlocks ;{
  XCTAssertTrue([UIWebView.new
                respondsToSelector:@selector(SH_setShouldStartLoadWithRequestBlock:)]);
  
}

-(void)testSHGestureRecognizerBlocks ;{
  XCTAssertTrue([UITapGestureRecognizer.new
                respondsToSelector:@selector(SH_addBlock:)]);
  
}

-(void)testSHTextFieldBlocks ;{
  XCTAssertTrue([UITextField.new
                respondsToSelector:@selector(SH_setShouldBeginEditingBlock:)]);
  
}

-(void)testSHTextViewBlocks; {
  XCTAssertTrue([UITextView.new
                respondsToSelector:@selector(SH_blockDidChangeSelection)]);
  
}

-(void)testSHTabBarControllerBlocks; {
  XCTAssertTrue([UITabBarController.new
                respondsToSelector:@selector(SH_setShouldSelectViewControllerBlock:)]);
  
}

@end
