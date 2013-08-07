
#import "UIPopoverController+SHPopoverControllerBlocks.h"

static NSString * const SH_blockShouldDismissPopoverBlock = @"SH_blockShouldDismissPopoverBlock";
static NSString * const SH_blockDidDismissPopoverBlock    = @"SH_blockDidDismissPopoverBlock";

@protocol SHNavigationDelegate <NSObject>
@required
+(void)setDelegateForObject:(id)theObject;
@end


@interface SHPopoverControllerBlockManager : NSObject
<UINavigationControllerDelegate>

@property(nonatomic,strong)   NSMapTable   * mapBlocks;
+(instancetype)sharedManager;
-(void)SH_memoryDebugger;

#pragma mark -
#pragma mark Class selectors

#pragma mark -
#pragma mark Setter
+(void)setDelegateForObject:(id)theObject;

+(void)setBlock:(id)theBlock
      forObject:(id)theObject
        withKey:(NSString *)theKey;

#pragma mark -
#pragma mark Getter
+(id)blockForObject:(id)theObject withKey:(NSString *)theKey;

@end

@implementation SHPopoverControllerBlockManager

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
  static SHPopoverControllerBlockManager * _sharedInstance;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedInstance = [[SHPopoverControllerBlockManager alloc] init];
    
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
#pragma mark Class selectors

#pragma mark -
#pragma mark Setter
+(void)setDelegateForObject:(id)theObject;{
  [theObject setDelegate:[SHPopoverControllerBlockManager sharedManager]];
}

+(void)setBlock:(id)theBlock
      forObject:(UIViewController *)theObject
        withKey:(NSString *)theKey; {
  
  NSAssert(theObject, @"Must pass theObject");
  
  id block = [theBlock copy];
  
  SHPopoverControllerBlockManager * manager = [SHPopoverControllerBlockManager
                                               sharedManager];
  NSMutableDictionary * map = [manager.mapBlocks objectForKey:theObject];
  if(map == nil) {
    map = [@{} mutableCopy];
    [manager.mapBlocks setObject:map forKey:theObject];
  }
  if(block == nil) {
    [map removeObjectForKey:theKey];
    if(map.count == 0) [manager.mapBlocks removeObjectForKey:theObject];
  }
  
  else map[theKey] = block;
  
}

#pragma mark -
#pragma mark Getter
+(id)blockForObject:(id)theObject withKey:(NSString *)theKey; {
  NSAssert(theObject, @"Must pass theObject to fetch blocks for");
  return [[[SHPopoverControllerBlockManager sharedManager].mapBlocks
           objectForKey:theObject] objectForKey:theKey];
}

#pragma mark -
#pragma mark Delegates


#pragma mark -
#pragma mark <SHPopoverViewControllerDelegate>
-(BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController; {
  BOOL popoverControllerShouldDismissPopover = YES;
  SHPopverControllerShouldDismissBlock block = [popoverController SH_blockShouldDismissPopoverBlock];
  if(block) popoverControllerShouldDismissPopover =  block(popoverController);

  return popoverControllerShouldDismissPopover;
}

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController; {
  SHPopverControllerDidDismissBlock block = [popoverController SH_blockDidDismissPopoverBlock];
  if(block) block(popoverController);
  
}




@end

@interface UIPopoverController (Private)
#pragma mark -
#pragma mark Private
-(void)SH_setDelegateToManager;


@end

@implementation UIPopoverController  (SHPopoverControllerBlocks)

#pragma mark -
#pragma mark Setup
-(void)SH_setDelegateToManager; {
  [SHPopoverControllerBlockManager setDelegateForObject:self];
}


#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Setters
-(void)SH_setShouldDismissPopoverBlock:(SHPopverControllerShouldDismissBlock)theBlock; {
  [self SH_setDelegateToManager];
  [SHPopoverControllerBlockManager setBlock:theBlock forObject:self withKey:SH_blockShouldDismissPopoverBlock];
}

-(void)SH_setDidDismissPopoverBlock:(SHPopverControllerDidDismissBlock)theBlock; {
  [self SH_setDelegateToManager];
  [SHPopoverControllerBlockManager setBlock:theBlock forObject:self withKey:SH_blockDidDismissPopoverBlock];
  
}


#pragma mark -
#pragma mark Getters
-(SHPopverControllerShouldDismissBlock)SH_blockShouldDismissPopoverBlock; {
  return [SHPopoverControllerBlockManager blockForObject:self withKey:SH_blockShouldDismissPopoverBlock];
}
-(SHPopverControllerDidDismissBlock)SH_blockDidDismissPopoverBlock; {
  return [SHPopoverControllerBlockManager blockForObject:self withKey:SH_blockDidDismissPopoverBlock];
}
@end