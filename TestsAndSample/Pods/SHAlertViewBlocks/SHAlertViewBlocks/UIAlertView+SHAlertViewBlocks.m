//
//  UIAlertView+SHAlertViewBlocks.h
//  Example
//
//  Created by Seivan Heidari on 5/16/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "UIAlertView+SHAlertViewBlocks.h"


static NSString * const SH_blockWillShow    = @"SH_blockWillShow";
static NSString * const SH_blockDidShow     = @"SH_blockDidShow";
static NSString * const SH_blockWillDismiss = @"SH_blockWillDismiss";
static NSString * const SH_blockDidDismiss  = @"SH_blockDidDismiss";

static NSString * const SH_blockAlertViewShouldEnableFirstOtherButton = @"SH_blockAlertViewShouldEnableFirstOtherButton";

static NSString * const SH_firstButtonDisabled = @"SH_firstButtonDisabled";


@interface UIAlertView ()
@property(nonatomic,strong) NSMutableDictionary * mapOfBlocks;
@end


@interface SHAlertViewBlocksManager : NSObject
<UIAlertViewDelegate>

@property(nonatomic,strong)   NSMapTable   * mapBlocks;

+(instancetype)sharedManager;
-(void)SH_memoryDebugger;
@end
@implementation SHAlertViewBlocksManager


#pragma mark - Init & Dealloc
-(instancetype)init; {
  self = [super init];
  if (self) {
    self.mapBlocks            = [NSMapTable weakToStrongObjectsMapTable];
//    [self SH_memoryDebugger];
  }
  
  return self;
}

+(instancetype)sharedManager; {
  static SHAlertViewBlocksManager * _sharedInstance;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedInstance = [[SHAlertViewBlocksManager alloc] init];
    
  });
  
  return _sharedInstance;
  
}


#pragma mark -
#pragma mark Debugger
-(void)SH_memoryDebugger; {
  double delayInSeconds = 2.0;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    NSLog(@"MAP %@",self.mapBlocks);
    [self SH_memoryDebugger];
  });
}

#


#pragma mark - <UIAlertViewDelegate>

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;{
  NSDictionary * mapBlocks = [self.mapBlocks objectForKey:alertView];
  SHAlertViewBlock block = mapBlocks[@(buttonIndex)];
  if(block)block(buttonIndex);
}


-(void)willPresentAlertView:(UIAlertView *)alertView;{
  NSDictionary * mapBlocks = [self.mapBlocks objectForKey:alertView];
  SHAlertViewShowBlock block = mapBlocks[SH_blockWillShow];
  if(block) block(alertView);
}

-(void)didPresentAlertView:(UIAlertView *)alertView; {
  NSDictionary * mapBlocks = [self.mapBlocks objectForKey:alertView];
  SHAlertViewShowBlock block = mapBlocks[SH_blockDidShow];
  if(block) block(alertView);
}


-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex; {
  NSDictionary * mapBlocks = [self.mapBlocks objectForKey:alertView];
  SHAlertViewDismissBlock block = mapBlocks[SH_blockWillDismiss];
  if(block) block(alertView, buttonIndex);

}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex; {
  NSDictionary * mapBlocks = [self.mapBlocks objectForKey:alertView];
  SHAlertViewDismissBlock block = mapBlocks[SH_blockDidDismiss];
  if(block) block(alertView, buttonIndex);
  alertView.mapOfBlocks = nil;
}

-(BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView; {
  BOOL alertViewShouldEnableFirstOtherButton = YES;
  NSDictionary * mapBlocks = [self.mapBlocks objectForKey:alertView];
  SHAlertViewFirstButtonEnabledBlock block = mapBlocks[SH_blockAlertViewShouldEnableFirstOtherButton];
  if(block) alertViewShouldEnableFirstOtherButton = block(alertView);
  return alertViewShouldEnableFirstOtherButton;
}
@end


@interface UIAlertView ()
@end

@interface UIAlertView (Private)
-(void)addBlock:(SHAlertViewBlock)theBlock forIndex:(NSInteger)theIndex;
-(void)addBlock:(id)theBlock forKey:(NSString *)theKey;
-(id)blockForKey:(NSString *)theKey;
@end




@implementation UIAlertView (SHAlertViewBlocks)



#pragma mark - Init
+(instancetype)SH_alertViewWithTitle:(NSString *)theTitle withMessage:(NSString *)theMessage; {
  UIAlertView * alert = [[self alloc] initWithTitle:theTitle
                                            message:theMessage
                                           delegate:[SHAlertViewBlocksManager sharedManager] cancelButtonTitle:nil
                                  otherButtonTitles:nil, nil];
  alert.mapOfBlocks[SH_firstButtonDisabled] = @(YES);

  return alert;
}

+(instancetype)SH_alertViewWithTitle:(NSString *)theTitle
                          andMessage:(NSString *)theMessage
                        buttonTitles:(NSArray *)theButtonTitles
                         cancelTitle:(NSString *)theCancelTitle
                           withBlock:(SHAlertViewBlock)theBlock; {
  NSString * firstButton = nil;
  if(theButtonTitles.count > 0)
    firstButton = theButtonTitles[0];
    
  theButtonTitles = [theButtonTitles subarrayWithRange:NSMakeRange(1, theButtonTitles.count-1)];
  
  UIAlertView * alert = [[self alloc] initWithTitle:theTitle
                                            message:theMessage
                                           delegate:[SHAlertViewBlocksManager sharedManager]
                                  cancelButtonTitle:theCancelTitle
                                  otherButtonTitles:firstButton, nil];
  
  if(firstButton == nil)
    alert.mapOfBlocks[SH_firstButtonDisabled] = @(YES);
  
  if(theCancelTitle)
    [alert SH_setButtonCancelBlock:theBlock];
  
  if(firstButton)
    [alert SH_setButtonBlockForIndex:alert.firstOtherButtonIndex withBlock:theBlock];
  
  for (NSString * title in theButtonTitles)
    [alert SH_addButtonWithTitle:title withBlock:theBlock];
  
  return alert;

}



#pragma mark - Adding
-(NSInteger)SH_addButtonWithTitle:(NSString *)theTitle
                         withBlock:(SHAlertViewBlock)theBlock; {
  NSInteger indexButton = [self addButtonWithTitle:theTitle];
  [self addBlock:[theBlock copy]  forIndex:indexButton];
  return indexButton;
  
}




-(NSInteger)SH_addButtonCancelWithTitle:(NSString *)theTitle
                               withBlock:(SHAlertViewBlock)theBlock;{
  NSInteger indexButton = [self SH_addButtonWithTitle:theTitle withBlock:theBlock];
  [self setCancelButtonIndex:indexButton];
  return indexButton;
  
}


#pragma mark - Properties
#pragma mark - Setters
-(void)SH_setButtonBlockForIndex:(NSInteger)theButtonIndex
                       withBlock:(SHAlertViewBlock)theBlock;{
  [self addBlock:theBlock forIndex:theButtonIndex];
}


-(void)SH_setButtonCancelBlock:(SHAlertViewBlock)theBlock;{
  if(self.cancelButtonIndex >= 0)
    [self addBlock:theBlock forIndex:self.cancelButtonIndex];
}

-
(void)SH_setWillShowBlock:(SHAlertViewShowBlock)theBlock; {
  [self addBlock:theBlock forKey:SH_blockWillShow];
}

-(void)SH_setDidShowBlock:(SHAlertViewShowBlock)theBlock; {
  [self addBlock:theBlock forKey:SH_blockDidShow];
}

-(void)SH_setWillDismissBlock:(SHAlertViewDismissBlock)theBlock; {
  [self addBlock:theBlock forKey:SH_blockWillDismiss];
}

-(void)SH_setDidDismissBlock:(SHAlertViewDismissBlock)theBlock; {
  [self addBlock:theBlock forKey:SH_blockDidDismiss]; 
}

-(void)SH_setFirstButtonEnabledBlock:(SHAlertViewFirstButtonEnabledBlock)theBlock; {
  NSAssert(self.mapOfBlocks[SH_firstButtonDisabled] == nil, @"Can't use SHAlertViewFirstButtonEnabledBlock without passing button title with an initializer");
  [self addBlock:theBlock forKey:SH_blockAlertViewShouldEnableFirstOtherButton];
}


#pragma mark - Getters
-(SHAlertViewBlock)SH_blockForButtonIndex:(NSInteger)theButtonIndex; {
  return self.mapOfBlocks[@(theButtonIndex)];
}

-(SHAlertViewBlock)SH_blockForCancelButton; {
  SHAlertViewBlock block = nil;
  if(self.cancelButtonIndex >= 0)
    block = self.mapOfBlocks[@(self.cancelButtonIndex)];
  return block;
}


-(SHAlertViewShowBlock)SH_blockWillShow;{
  return self.mapOfBlocks[SH_blockWillShow];    
}

-(SHAlertViewShowBlock)SH_blockDidShow;{
  return self.mapOfBlocks[SH_blockDidShow];
}

-(SHAlertViewDismissBlock)SH_blockWillDismiss;{
  return self.mapOfBlocks[SH_blockWillDismiss];
}

-(SHAlertViewDismissBlock)SH_blockDidDismiss;{
  return self.mapOfBlocks[SH_blockDidDismiss];
}

-(SHAlertViewFirstButtonEnabledBlock)SH_blockForFirstButtonEnabled; {
  return self.mapOfBlocks[SH_blockAlertViewShouldEnableFirstOtherButton];
}


#pragma mark - Privates
-(void)addBlock:(SHAlertViewBlock)theBlock forIndex:(NSInteger)theIndex; {
  if(theBlock) self.mapOfBlocks[@(theIndex)] = theBlock;
  else [self.mapOfBlocks removeObjectForKey:@(theIndex)];
}

-(void)addBlock:(id)theBlock forKey:(NSString *)theKey; {
  self.mapOfBlocks[theKey] = [theBlock copy];
}

-(id)blockForKey:(NSString *)theKey; {
  id block = self.mapOfBlocks[theKey];
  return block;
}

-(NSMutableDictionary *)mapOfBlocks; {
  SHAlertViewBlocksManager * manager = [SHAlertViewBlocksManager sharedManager];
  if(self.delegate != manager) self.delegate = manager;
  NSMutableDictionary * mapOfBlocks =  [manager.mapBlocks objectForKey:self];
  if(mapOfBlocks == nil) {
    mapOfBlocks = @{}.mutableCopy;
    self.mapOfBlocks = mapOfBlocks;
  }

  return mapOfBlocks;
}

-(void)setMapOfBlocks:(NSMutableDictionary *)mapOfBlocks; {
  SHAlertViewBlocksManager * manager = [SHAlertViewBlocksManager sharedManager];
  if(mapOfBlocks)
    [manager.mapBlocks setObject:mapOfBlocks forKey:self];
  else {
    [manager.mapBlocks removeObjectForKey:self];
  }

}


@end

