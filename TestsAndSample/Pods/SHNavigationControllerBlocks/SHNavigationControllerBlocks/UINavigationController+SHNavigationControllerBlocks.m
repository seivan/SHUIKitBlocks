
#import "UINavigationController+SHNavigationControllerBlocks.h"

#define SHStaticConstString(X) static NSString * const X = @#X

SHStaticConstString(SH_blockWillShowViewController);
SHStaticConstString(SH_blockDidShowViewController);
SHStaticConstString(SH_blockInterfaceOrientationForPresentation);
SHStaticConstString(SH_blockInteractiveController);
SHStaticConstString(SH_blockAnimatedController);

@protocol SHNavigationDelegate <NSObject>
@required
+(void)setDelegateForController:(UINavigationController *)theNavigationController;
@end


@interface SHNavigationControllerBlockManager : NSObject
<UINavigationControllerDelegate>

@property(nonatomic,strong)   NSMapTable   * mapBlocks;
+(instancetype)sharedManager;
-(void)SH_memoryDebugger;


#pragma mark - Class selectors


#pragma mark - Setter
+(void)setDelegateForController:(UINavigationController *)theNavigationController;

+(void)setBlock:(id)theBlock
  forController:(UIViewController *)theController
        withKey:(NSString *)theKey;


#pragma mark - Getter
+(id)blockForController:(UIViewController *)theController withKey:(NSString *)theKey;

@end

@implementation SHNavigationControllerBlockManager


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
  static SHNavigationControllerBlockManager * _sharedInstance;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedInstance = [[SHNavigationControllerBlockManager alloc] init];
    
  });
  
  return _sharedInstance;
  
}



#pragma mark - Debugger
-(void)SH_memoryDebugger; {
  double delayInSeconds = 2.0;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    NSLog(@"MAP %@",self.mapBlocks);
    [self SH_memoryDebugger];
  });
}


#pragma mark - Class selectors


#pragma mark - Setter
+(void)setDelegateForController:(UINavigationController *)theNavigationController;{
  [theNavigationController setDelegate:[SHNavigationControllerBlockManager sharedManager]];
}

+(void)setBlock:(id)theBlock
  forController:(UIViewController *)theController
        withKey:(NSString *)theKey; {

  NSParameterAssert(theController);
  
  SHNavigationControllerBlock block = [theBlock copy];
  
  SHNavigationControllerBlockManager * manager = [SHNavigationControllerBlockManager
                                                  sharedManager];
  NSMutableDictionary * map = [manager.mapBlocks objectForKey:theController];
  if(map == nil) {
    map = [@{} mutableCopy];
    [manager.mapBlocks setObject:map forKey:theController];
  }
  if(block == nil) {
    [map removeObjectForKey:theKey];
    if(map.count == 0) [manager.mapBlocks removeObjectForKey:theController];
  }
  
  else map[theKey] = block;
      
}


#pragma mark - Getter
+(id)blockForController:(UIViewController *)theController withKey:(NSString *)theKey; {
  NSParameterAssert(theController);
  return [[[SHNavigationControllerBlockManager sharedManager].mapBlocks
          objectForKey:theController] objectForKey:theKey];
}


#pragma mark - Delegates

#pragma mark - <UINavigationControllerDelegate>
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated; {
  SHNavigationControllerBlock block = [navigationController SH_blockWillShowViewController];
  if(block) block(navigationController, viewController, animated);
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated; {
  SHNavigationControllerBlock block = [navigationController SH_blockDidShowViewController];
  if(block) block(navigationController, viewController, animated);
  
}

-(UIInterfaceOrientation)navigationControllerPreferredInterfaceOrientationForPresentation:(UINavigationController *)navigationController NS_AVAILABLE_IOS(7_0); {
  SHNavigationControllerOrientationBlock block = [navigationController SH_blockInterfaceOrientationForPresentation];
  UIInterfaceOrientation orientation = kNilOptions;
  if(block) orientation = block(navigationController);
  return orientation;
}

-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController NS_AVAILABLE_IOS(7_0); {
  SHNavigationControllerInteractiveControllerBlock block = [navigationController SH_blockInteractiveController];
  id<UIViewControllerInteractiveTransitioning> transition = nil;
  if(block) transition = block(navigationController, animationController);
  return transition;
  
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0); {
  SHNavigationControllerAnimatedControllerBlock block = [navigationController SH_blockAnimatedController];
  id<UIViewControllerAnimatedTransitioning> transition = nil;
  if(block) transition = block(navigationController, operation, fromVC, toVC);
  return transition;
  
}


@end

@interface UINavigationController (Private)

#pragma mark - Private
-(void)SH_setNavigationBlocks;


@end

@implementation UINavigationController  (SHNavigationControllerBlocks)


#pragma mark - Setup
-(void)SH_setNavigationBlocks; {
  [SHNavigationControllerBlockManager setDelegateForController:self];
}



#pragma mark - Properties

#pragma mark - Setters

-(void)SH_setWillShowViewControllerBlock:(SHNavigationControllerBlock)theBlock; {
  [self SH_setNavigationBlocks];
  [SHNavigationControllerBlockManager setBlock:theBlock
                                 forController:self
                                       withKey:SH_blockWillShowViewController];
}

-(void)SH_setDidShowViewControllerBlock:(SHNavigationControllerBlock)theBlock; {
  [self SH_setNavigationBlocks];
  [SHNavigationControllerBlockManager setBlock:theBlock
                                 forController:self
                                       withKey:SH_blockDidShowViewController];
  
}

-(void)SH_setPreferredInterfaceOrientationForPresentatationBlock:(SHNavigationControllerOrientationBlock)theBlock; {
  [self SH_setNavigationBlocks];
  [SHNavigationControllerBlockManager setBlock:theBlock forController:self withKey:SH_blockInterfaceOrientationForPresentation];
  
}

-(void)SH_setInteractiveControllerBlock:(SHNavigationControllerInteractiveControllerBlock)theBlock; {
  [self SH_setNavigationBlocks];
  [SHNavigationControllerBlockManager setBlock:theBlock forController:self withKey:SH_blockInteractiveController];
}

-(void)SH_setAnimatedControllerBlock:(SHNavigationControllerAnimatedControllerBlock)theBlock; {
  [self SH_setNavigationBlocks];
  [SHNavigationControllerBlockManager setBlock:theBlock forController:self withKey:SH_blockAnimatedController];

}



#pragma mark - Getters
-(SHNavigationControllerBlock)SH_blockWillShowViewController; {
  return [SHNavigationControllerBlockManager blockForController:self
                                                        withKey:NSStringFromSelector(_cmd)];
}
-(SHNavigationControllerBlock)SH_blockDidShowViewController; {
  return [SHNavigationControllerBlockManager blockForController:self
                                                        withKey:NSStringFromSelector(_cmd)];
}
-(SHNavigationControllerOrientationBlock)SH_blockInterfaceOrientationForPresentation; {
  return [SHNavigationControllerBlockManager blockForController:self
                                                        withKey:NSStringFromSelector(_cmd)];
  
}
-(SHNavigationControllerInteractiveControllerBlock)SH_blockInteractiveController; {
  return [SHNavigationControllerBlockManager blockForController:self
                                                        withKey:NSStringFromSelector(_cmd)];
}

-(SHNavigationControllerAnimatedControllerBlock)SH_blockAnimatedController; {
  return [SHNavigationControllerBlockManager blockForController:self
                                                        withKey:NSStringFromSelector(_cmd)];
}

@end