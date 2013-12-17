//
//  UIControl+SHControlEventBlock.h
//  Example
//
//  Created by Seivan Heidari on 5/16/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "UIBarButtonItem+SHBarButtonItemBlocks.h"



@interface SHBarButtonItemBlocksManager : NSObject
@property(nonatomic,strong) NSMapTable * mapBlocks;
+(instancetype)sharedManager;
+(SEL)selectorAction;
-(void)SH_memoryDebugger;
-(void)performAction:(UIBarButtonItem *)theSender;
@end
@implementation SHBarButtonItemBlocksManager
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
  static SHBarButtonItemBlocksManager * _sharedInstance;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedInstance = [[SHBarButtonItemBlocksManager alloc] init];
    
  });
  
  return _sharedInstance;
  
}

+(SEL)selectorAction; { return @selector(performAction:); }

-(void)performAction:(UIBarButtonItem *)theSender; {
  NSSet * blocks = [self.mapBlocks objectForKey:theSender];
  for (SHBarButtonItemBlock block in blocks) {
    block(theSender);
  }
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
@end


@interface UIBarButtonItem ()
@property(nonatomic,readonly) NSMutableSet * setOfBlocks;
@end




@implementation UIBarButtonItem (SHBarButtonItemBlocks)
#pragma mark -
#pragma mark Init

+(instancetype)SH_barButtonItemWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem
                                 withBlock:(SHBarButtonItemBlock)theBlock; {
  
  UIBarButtonItem * barButtonItem =  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:systemItem
                                                                                   target:nil
                                                                                   action:nil];
  [barButtonItem SH_addBlock:theBlock];
  return barButtonItem;
}

+(instancetype)SH_barButtonItemWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style
                   withBlock:(SHBarButtonItemBlock)theBlock; {
  
  UIBarButtonItem * barButtonItem =  [[UIBarButtonItem alloc] initWithImage:image
                                                                      style:style
                                                                     target:nil
                                                                     action:nil];
  [barButtonItem SH_addBlock:theBlock];
  return barButtonItem;
  
}

+(instancetype)SH_barButtonItemWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style
                   withBlock:(SHBarButtonItemBlock)theBlock; {
  
  UIBarButtonItem * barButtonItem =  [[UIBarButtonItem alloc] initWithTitle:title
                                                                      style:style
                                                                     target:nil
                                                                     action:nil];
  [barButtonItem SH_addBlock:theBlock];
  return barButtonItem;
  
}

#pragma mark -
#pragma mark Add
-(void)SH_addBlock:(SHBarButtonItemBlock)theBlock; {
  NSAssert(theBlock, @"theBlock is required");
  SHBarButtonItemBlock block = [theBlock copy];
  self.target = [SHBarButtonItemBlocksManager sharedManager];
  self.action = [SHBarButtonItemBlocksManager selectorAction];
  [self.setOfBlocks addObject:block];
}

#pragma mark -
#pragma mark Remove
-(void)SH_removeBlock:(SHBarButtonItemBlock)theBlock; {
  [self.setOfBlocks removeObject:theBlock];
  if(self.setOfBlocks.count == 0) [self SH_removeAllBlocks];

}

-(void)SH_removeAllBlocks; {
  self.setOfBlocks = nil;
}



#pragma mark -
#pragma mark Properties


#pragma mark -
#pragma mark Getters
-(NSSet *)SH_blocks; {
  return self.setOfBlocks.copy;
}

#pragma mark -
#pragma mark Privates

-(NSMutableSet *)setOfBlocks; {
  NSMutableSet * setOfBlocks =  [[SHBarButtonItemBlocksManager sharedManager].mapBlocks objectForKey:self];
  if(setOfBlocks == nil) {
    setOfBlocks = [NSMutableSet set];
    self.setOfBlocks = setOfBlocks;
  }

  return setOfBlocks;
}

-(void)setSetOfBlocks:(NSMutableSet *)setOfBlocks; {
  if(setOfBlocks)
    [[SHBarButtonItemBlocksManager sharedManager].mapBlocks setObject:setOfBlocks forKey:self];
  else {
    self.target = nil;
    self.action = nil;
    [[SHBarButtonItemBlocksManager sharedManager].mapBlocks removeObjectForKey:self];
  }

}


@end

