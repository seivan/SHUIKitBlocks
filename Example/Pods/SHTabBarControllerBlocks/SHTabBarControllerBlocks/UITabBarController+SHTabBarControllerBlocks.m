
#import "UITabBarController+SHTabBarControllerBlocks.h"

#define SHStaticConstString(X) static NSString * const X = @#X

SHStaticConstString(SH_blockShouldSelectViewController);
SHStaticConstString(SH_blockDidSelectViewController);
SHStaticConstString(SH_blockWillBeginCustomizingViewControllers);
SHStaticConstString(SH_blockWillEndCustomizingViewControllers);
SHStaticConstString(SH_blockDidEndCustomizingViewControllers);




@interface SHTabBarControllerBlocksManager : NSObject
<UITabBarControllerDelegate>

@property(nonatomic,strong) NSMapTable     * mapBlocks;

+(instancetype)sharedManager;
-(void)SH_memoryDebugger;
-(void)setMapTable:(NSMapTable *)theMapTable forObject:(id)theObject;
-(NSMapTable *)mapTableForObject:(id)theObject;
@end
@implementation SHTabBarControllerBlocksManager

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
  static SHTabBarControllerBlocksManager *_sharedInstance;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedInstance = [[SHTabBarControllerBlocksManager alloc] init];
    
  });
  
  return _sharedInstance;
  
}

#pragma mark - Debugger
-(void)SH_memoryDebugger; {
  __weak typeof(self) weakSelf = self;
  double delayInSeconds = 2.0;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    NSLog(@"MAP %@",weakSelf.mapBlocks);
    [weakSelf SH_memoryDebugger];
  });
}

#pragma mark - Setter
-(void)setMapTable:(NSMapTable *)theMapTable forObject:(id)theObject; {
  [[[SHTabBarControllerBlocksManager sharedManager] mapBlocks] setObject:theMapTable
                                       forKey:theObject];
}

#pragma mark - Getter

-(NSMapTable *)mapTableForObject:(id)theObject; {
  return [self.mapBlocks objectForKey:theObject];
}

#pragma mark - <UITabBarControllerDelegate>

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0); {
  
  BOOL shouldSelectViewController = YES;
  SHTabBarControllerPredicateBlock block = [[self mapTableForObject:tabBarController]
                                            objectForKey:SH_blockShouldSelectViewController];
  if(block) shouldSelectViewController = block(tabBarController, viewController);
  return shouldSelectViewController;
  
}
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController; {
  
  SHTabBarControllerBlock block = [[self mapTableForObject:tabBarController]
                                            objectForKey:SH_blockDidSelectViewController];
  if(block) block(tabBarController, viewController);
}

- (void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray *)viewControllers NS_AVAILABLE_IOS(3_0); {
  
  SHTabBarControllerCustomizingBlock block = [[self mapTableForObject:tabBarController]
                                            objectForKey:SH_blockWillBeginCustomizingViewControllers];
  if(block) block(tabBarController, viewControllers);
  
}
- (void)tabBarController:(UITabBarController *)tabBarController willEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed NS_AVAILABLE_IOS(3_0); {
  
  SHTabBarControllerCustomizingWithChangeBlock block = [[self mapTableForObject:tabBarController]
                                            objectForKey:SH_blockWillEndCustomizingViewControllers];
  if(block) block(tabBarController, viewControllers, changed);
  
}
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed; {
  
  SHTabBarControllerCustomizingWithChangeBlock block = [[self mapTableForObject:tabBarController]
                                            objectForKey:SH_blockDidEndCustomizingViewControllers];
  if(block) block(tabBarController, viewControllers, changed);
  
}



@end



@interface UITabBarController (Private)
@property(nonatomic,readonly) NSMapTable * mapBlocks;
-(void)setBlock:(id)theBlock forKey:(NSString *)theKey;
@end



@implementation UITabBarController (SHTabBarControllerBlocks)

#pragma mark - Setters
-(void)SH_setShouldSelectViewControllerBlock:(SHTabBarControllerPredicateBlock)theBlock; {
  [self setBlock:theBlock forKey:SH_blockShouldSelectViewController];
}

-(void)SH_setDidSelectViewControllerBlock:(SHTabBarControllerBlock)theBlock; {
  [self setBlock:theBlock forKey:SH_blockDidSelectViewController];
}

-(void)SH_setWillBeginCustomizingViewControllersBlock:(SHTabBarControllerCustomizingBlock)theBlock; {
  [self setBlock:theBlock forKey:SH_blockWillBeginCustomizingViewControllers];
}

-(void)SH_setWillEndCustomizingViewControllersBlock:(SHTabBarControllerCustomizingWithChangeBlock)theBlock; {
  [self setBlock:theBlock forKey:SH_blockWillEndCustomizingViewControllers];
}

-(void)SH_setDidEndCustomizingViewControllersBlock:(SHTabBarControllerCustomizingWithChangeBlock)theBlock;{
  [self setBlock:theBlock forKey:SH_blockDidEndCustomizingViewControllers]; 
}


#pragma mark - Getters
-(SHTabBarControllerPredicateBlock)SH_blockShouldSelectViewController; {
  return [self.mapBlocks objectForKey:SH_blockShouldSelectViewController];
}

-(SHTabBarControllerBlock)SH_blockDidSelectViewController; {
  return [self.mapBlocks objectForKey:SH_blockDidSelectViewController];
}

-(SHTabBarControllerCustomizingBlock)SH_blockWillBeginCustomizingViewControllers; {
  return [self.mapBlocks objectForKey:SH_blockWillBeginCustomizingViewControllers];
}

-(SHTabBarControllerCustomizingWithChangeBlock)SH_blockWillEndCustomizingViewControllers; {
  return [self.mapBlocks objectForKey:SH_blockWillEndCustomizingViewControllers];
}

-(SHTabBarControllerCustomizingWithChangeBlock)SH_blockDidEndCustomizingViewControllers; {
  return [self.mapBlocks objectForKey:SH_blockDidEndCustomizingViewControllers];
}


#pragma mark - Private

#pragma mark - Properties
#pragma mark - setters
-(void)setBlock:(id)theBlock forKey:(NSString *)theKey; {
  NSParameterAssert(theKey);
  if(theBlock) [self.mapBlocks setObject:[theBlock copy]  forKey:theKey];
  else         [self.mapBlocks removeObjectForKey:theKey];
}

#pragma mark - Getter
-(NSMapTable *)mapBlocks; {
  SHTabBarControllerBlocksManager * manager =[SHTabBarControllerBlocksManager sharedManager];
  self.delegate = manager;
  NSMapTable * mapTable = [manager mapTableForObject:self];
  if(mapTable == nil) mapTable = [NSMapTable strongToStrongObjectsMapTable];
  [manager setMapTable:mapTable forObject:self];
  return mapTable;
  
}

@end

