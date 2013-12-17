//
//  UIViewController+SHSegueBlock.m
//  Example
//
//  Created by Seivan Heidari on 5/16/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "UIViewController+SHSegueBlocks.h"
#import "SHObjectUserInfo.h"

@interface SHSegueBlocksManager : NSObject

@property(nonatomic,strong) NSMapTable * mapBlocks;

+(instancetype)sharedManager;

-(void)SH_memoryDebugger;
@end


@implementation SHSegueBlocksManager

#pragma mark - Init & Dealloc
-(instancetype)init; {
  self = [super init];
  if (self) {
    self.mapBlocks      = [NSMapTable strongToStrongObjectsMapTable];

//    [self SH_memoryDebugger];
  }
  
  return self;
}

+(instancetype)sharedManager; {
  static SHSegueBlocksManager *_sharedInstance;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedInstance = [[SHSegueBlocksManager alloc] init];
    
  });
  
  return _sharedInstance;
  
}


#pragma mark - Debugger
-(void)SH_memoryDebugger; {
  double delayInSeconds = 5.0;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){

    NSLog(@"BLOCK %@",self.mapBlocks);
    [self SH_memoryDebugger];
  });
}

@end

@interface UIViewController ()

@property(nonatomic,readonly) NSMapTable * mapBlocks;


@end

@implementation UIViewController (SHSegueBlock)


#pragma mark - Segue Performers


-(void)SH_performSegueWithIdentifier:(NSString *)theIdentifier
           andPrepareForSegueBlock:(SHPrepareForSegue)theBlock; {
  NSMutableDictionary * blocks = [self.mapBlocks objectForKey:self];
  if(blocks == nil) blocks = @{}.mutableCopy;
  if(theBlock) blocks[theIdentifier] = [theBlock copy];
  [self.mapBlocks setObject:blocks forKey:self];
  [self performSegueWithIdentifier:theIdentifier sender:self];
}

-(void)SH_performSegueWithIdentifier:(NSString *)theIdentifier
       andDestinationViewController:(SHPrepareForSegueDestinationViewController)theBlock; {
  [self SH_performSegueWithIdentifier:theIdentifier andPrepareForSegueBlock:^(UIStoryboardSegue *theSegue) {
    UIViewController * destinationViewController = theSegue.destinationViewController;
    if(theBlock) theBlock(destinationViewController);
  }];
}

-(void)SH_performSegueWithIdentifier:(NSString *)theIdentifier
                        withUserInfo:(NSDictionary *)theUserInfo; {
  [self SH_performSegueWithIdentifier:theIdentifier andDestinationViewController:^(UIViewController * theDestinationViewController) {
    theDestinationViewController.SH_userInfo = [theUserInfo mutableCopy];
  }];
}

#pragma mark - Segue Observers
-(void)SH_observeSegueWithIdentifier:(NSString *)theIdentifier
             andPrepareForSegueBlock:(SHPrepareForSegue)theBlock; {
  NSMutableDictionary * blocks = [self.mapBlocks objectForKey:self];
  if(blocks == nil) blocks = @{}.mutableCopy;
  if(theBlock) blocks[theIdentifier] = [theBlock copy];
  [self.mapBlocks setObject:blocks forKey:self];

}



#pragma mark - Helpers

-(BOOL)SH_handlesBlockForSegue:(UIStoryboardSegue *)theSegue; {
  BOOL handlesBlockForSegue = NO;
  NSMutableDictionary * blocks = [SHSegueBlocksManager.sharedManager.mapBlocks objectForKey:self];
  SHPrepareForSegue block = blocks[theSegue.identifier];
  if(block) {
    handlesBlockForSegue = YES;
    block(theSegue);
  }
  return handlesBlockForSegue;

}



#pragma mark - Privates

#pragma mark - Properties

#pragma mark - Getters
-(NSMapTable *)mapBlocks; {
  return SHSegueBlocksManager.sharedManager.mapBlocks;
}
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender; {
  NSMutableDictionary * blocks = [SHSegueBlocksManager.sharedManager.mapBlocks objectForKey:self];
  SHPrepareForSegue block = blocks[segue.identifier];
  if(block) block(segue);
//Don't need to do this as we have weak2weak references  [blocks removeObjectForKey:segue.identifier];
  [SHSegueBlocksManager.sharedManager.mapBlocks setObject:blocks forKey:self];

}
#pragma clang diagnostic pop



@end
