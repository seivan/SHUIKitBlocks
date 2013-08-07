//
//  UIActionSheet+SHActionSheetBlocks.h
//  Example
//
//  Created by Seivan Heidari on 5/16/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "UIActionSheet+SHActionSheetBlocks.h"


static NSString * const SH_blockWillShow    = @"SH_blockWillShow";
static NSString * const SH_blockDidShow     = @"SH_blockDidShow";
static NSString * const SH_blockWillDismiss = @"SH_blockWillDismiss";
static NSString * const SH_blockDidDismiss  = @"SH_blockDidDismiss";

@interface UIActionSheet ()
@property(nonatomic,strong) NSMutableDictionary * mapOfBlocks;
@end


@interface SHActionSheetBlocksManager : NSObject
<UIActionSheetDelegate>

@property(nonatomic,strong)   NSMapTable   * mapBlocks;

+(instancetype)sharedManager;
-(void)SH_memoryDebugger;
@end
@implementation SHActionSheetBlocksManager

#pragma mark -
#pragma mark Init & Dealloc
-(instancetype)init; {
  self = [super init];
  if (self) {
    self.mapBlocks            = [NSMapTable weakToStrongObjectsMapTable];
//    [self SH_memoryDebugger];
  }
  
  return self;
}

+(instancetype)sharedManager; {
  static SHActionSheetBlocksManager * _sharedInstance;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedInstance = [[SHActionSheetBlocksManager alloc] init];
    
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



#pragma mark -
#pragma mark <UIActionSheetDelegate>


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;{
  NSDictionary * mapBlocks = [self.mapBlocks objectForKey:actionSheet];
  SHActionSheetBlock block = mapBlocks[@(buttonIndex)];
  if(block)block(buttonIndex);
}


-(void)willPresentActionSheet:(UIActionSheet *)actionSheet;{
  NSDictionary * mapBlocks = [self.mapBlocks objectForKey:actionSheet];
  SHActionSheetShowBlock block = mapBlocks[SH_blockWillShow];
  if(block) block(actionSheet);
  
}

-(void)didPresentActionSheet:(UIActionSheet *)actionSheet; {
  NSDictionary * mapBlocks = [self.mapBlocks objectForKey:actionSheet];
  SHActionSheetShowBlock block = mapBlocks[SH_blockDidShow];
  if(block) block(actionSheet);

}


-(void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex; {
  NSDictionary * mapBlocks = [self.mapBlocks objectForKey:actionSheet];
  SHActionSheetDismissBlock block = mapBlocks[SH_blockWillDismiss];
  if(block) block(actionSheet, buttonIndex);

}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex; {
  NSDictionary * mapBlocks = [self.mapBlocks objectForKey:actionSheet];
  SHActionSheetDismissBlock block = mapBlocks[SH_blockDidDismiss];
  if(block) block(actionSheet, buttonIndex);
  actionSheet.mapOfBlocks = nil;
}


@end


@interface UIActionSheet ()
@end

@interface UIActionSheet (Private)
-(void)addBlock:(SHActionSheetBlock)theBlock forIndex:(NSInteger)theIndex;
-(void)addBlock:(id)theBlock forKey:(NSString *)theKey;
-(id)blockForKey:(NSString *)theKey;
@end




@implementation UIActionSheet (SHActionSheetBlocks)


#pragma mark -
#pragma mark Init
+(instancetype)SH_actionSheetWithTitle:(NSString *)theTitle; {
  return [[self alloc] initWithTitle:theTitle
                    delegate:[SHActionSheetBlocksManager sharedManager]
           cancelButtonTitle:nil
      destructiveButtonTitle:nil
           otherButtonTitles:nil, nil];

}

+(instancetype)SH_actionSheetWithTitle:(NSString *)theTitle
                          buttonTitles:(NSArray *)theButtonTitles
                          cancelTitle:(NSString *)theCancelTitle
                      destructiveTitle:(NSString *)theDestructiveTitle
                             withBlock:(SHActionSheetBlock)theBlock; {

  UIActionSheet * sheet = [self SH_actionSheetWithTitle:theTitle];

  if(theDestructiveTitle)
    [sheet SH_addButtonDestructiveWithTitle:theDestructiveTitle withBlock:theBlock];
  
  for (NSString * title in theButtonTitles)
    [sheet SH_addButtonWithTitle:title withBlock:theBlock];
  
  
  if(theCancelTitle)
    [sheet SH_addButtonCancelWithTitle:theCancelTitle withBlock:theBlock];
  return sheet;
}


#pragma mark -
#pragma mark Adding
-(NSInteger)SH_addButtonWithTitle:(NSString *)theTitle
                         withBlock:(SHActionSheetBlock)theBlock; {
  NSInteger indexButton = [self addButtonWithTitle:theTitle];
  [self addBlock:[theBlock copy]  forIndex:indexButton];
  return indexButton;
  
}




-(NSInteger)SH_addButtonDestructiveWithTitle:(NSString *)theTitle
                                    withBlock:(SHActionSheetBlock)theBlock; {
  NSInteger indexButton = [self SH_addButtonWithTitle:theTitle withBlock:theBlock];
  [self setDestructiveButtonIndex:indexButton];
  return indexButton;
  
}

-(NSInteger)SH_addButtonCancelWithTitle:(NSString *)theTitle
                               withBlock:(SHActionSheetBlock)theBlock; {
  NSInteger indexButton = [self SH_addButtonWithTitle:theTitle withBlock:theBlock];
  [self setCancelButtonIndex:indexButton];
  return indexButton;
  
}




#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Setters
-(void)SH_setButtonBlockForIndex:(NSInteger)theButtonIndex
                  withBlock:(SHActionSheetBlock)theBlock;{
  [self addBlock:theBlock forIndex:theButtonIndex];
}



-(void)SH_setButtonDestructiveBlock:(SHActionSheetBlock)theBlock;{
  if(self.destructiveButtonIndex >= 0)
    [self addBlock:theBlock forIndex:self.destructiveButtonIndex];
}

-(void)SH_setButtonCancelBlock:(SHActionSheetBlock)theBlock;{
  if(self.cancelButtonIndex >= 0)
    [self addBlock:theBlock forIndex:self.cancelButtonIndex];
}

-(void)SH_setWillShowBlock:(SHActionSheetShowBlock)theBlock; {
  [self addBlock:theBlock forKey:SH_blockWillShow];
}

-(void)SH_setDidShowBlock:(SHActionSheetShowBlock)theBlock; {
  [self addBlock:theBlock forKey:SH_blockDidShow];
}

-(void)SH_setWillDismissBlock:(SHActionSheetDismissBlock)theBlock; {
  [self addBlock:theBlock forKey:SH_blockWillDismiss];
}

-(void)SH_setDidDismissBlock:(SHActionSheetDismissBlock)theBlock; {
  [self addBlock:theBlock forKey:SH_blockDidDismiss]; 
}


#pragma mark -
#pragma mark Getters

-(SHActionSheetBlock)SH_blockForButtonIndex:(NSInteger)theButtonIndex; {
  return self.mapOfBlocks[@(theButtonIndex)];
}


-(SHActionSheetBlock)SH_blockForDestructiveButton; {
  SHActionSheetBlock block = nil;
  if(self.destructiveButtonIndex >= 0)
    block = self.mapOfBlocks[@(self.destructiveButtonIndex)];
  return block;
}

-(SHActionSheetBlock)SH_blockForCancelButton; {
  SHActionSheetBlock block = nil;
  if(self.cancelButtonIndex >= 0)
    block = self.mapOfBlocks[@(self.cancelButtonIndex)];
  return block; 
}

-(SHActionSheetShowBlock)SH_blockWillShow;{
  return self.mapOfBlocks[SH_blockWillShow];    
}

-(SHActionSheetShowBlock)SH_blockDidShow;{
  return self.mapOfBlocks[SH_blockDidShow];
}

-(SHActionSheetDismissBlock)SH_blockWillDismiss;{
  return self.mapOfBlocks[SH_blockWillDismiss];
}

-(SHActionSheetDismissBlock)SH_blockDidDismiss;{
  return self.mapOfBlocks[SH_blockDidDismiss];
}

#pragma mark -
#pragma mark Privates
-(void)addBlock:(SHActionSheetBlock)theBlock forIndex:(NSInteger)theIndex; {
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
  NSMutableDictionary * mapOfBlocks =  [[SHActionSheetBlocksManager sharedManager].mapBlocks objectForKey:self];
  if(mapOfBlocks == nil) {
    mapOfBlocks = @{}.mutableCopy;
    self.mapOfBlocks = mapOfBlocks;
  }

  return mapOfBlocks;
}

-(void)setMapOfBlocks:(NSMutableDictionary *)mapOfBlocks; {
  if(mapOfBlocks)
    [[SHActionSheetBlocksManager sharedManager].mapBlocks setObject:mapOfBlocks forKey:self];
  else {
    [[SHActionSheetBlocksManager sharedManager].mapBlocks removeObjectForKey:self];
  }

}


@end

