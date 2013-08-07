
#import "UINavigationController+SHNavigationControllerBlocks.h"

static NSString * const SH_blockWillShowViewController = @"SH_blockWillShowViewController";
static NSString * const SH_blockDidShowViewController = @"SH_blockDidShowViewController";

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

  NSAssert(theController, @"Must pass theController");
  
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
  NSAssert(theController, @"Must pass a controller to fetch blocks for");
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


#pragma mark - Getters
-(SHNavigationControllerBlock)SH_blockWillShowViewController; {
  return [SHNavigationControllerBlockManager blockForController:self
                                                        withKey:SH_blockWillShowViewController];
}
-(SHNavigationControllerBlock)SH_blockDidShowViewController; {
  return [SHNavigationControllerBlockManager blockForController:self
                                                        withKey:SH_blockDidShowViewController];
}
@end