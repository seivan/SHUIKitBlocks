
#pragma mark - Block Defintions
typedef BOOL (^SHTabBarControllerPredicateBlock)(UITabBarController  * theTabBarController,
UIViewController * theViewController);

typedef void (^SHTabBarControllerBlock)(UITabBarController  * theTabBarController,
UIViewController * theViewController);

typedef void (^SHTabBarControllerCustomizingBlock)(UITabBarController  * theTabBarController,
NSArray  * theViewControllers);

typedef void (^SHTabBarControllerCustomizingWithChangeBlock)(UITabBarController  * theTabBarController,
NSArray * theViewControllers,
BOOL      isChanged);

typedef id<UIViewControllerInteractiveTransitioning>
(^SHTabBarControllerInteractiveControllerBlock)(UITabBarController * tabBarController,
                                                id<UIViewControllerAnimatedTransitioning> animationController
                                                );

typedef id<UIViewControllerAnimatedTransitioning>
(^SHTabBarControllerAnimatedControllerBlock) (UITabBarController * tabBarController,
                                              UIViewController * fromVC,
                                              UIViewController * toVC
                                              );



@interface UITabBarController (SHTabBarControllerBlocks)



#pragma mark - Properties

#pragma mark - Setters
-(void)SH_setShouldSelectViewControllerBlock:(SHTabBarControllerPredicateBlock)theBlock;
-(void)SH_setDidSelectViewControllerBlock:(SHTabBarControllerBlock)theBlock;
-(void)SH_setWillBeginCustomizingViewControllersBlock:(SHTabBarControllerCustomizingBlock)theBlock;
-(void)SH_setWillEndCustomizingViewControllersBlock:(SHTabBarControllerCustomizingWithChangeBlock)theBlock;
-(void)SH_setDidEndCustomizingViewControllersBlock:(SHTabBarControllerCustomizingWithChangeBlock)theBlock;
-(void)SH_setInteractiveControllerBlock:(SHTabBarControllerInteractiveControllerBlock)theBlock;
-(void)SH_setAnimatedControllerBlock:(SHTabBarControllerAnimatedControllerBlock)theBlock;



#pragma mark - Getters
@property(nonatomic,readonly) SHTabBarControllerPredicateBlock SH_blockShouldSelectViewController;
@property(nonatomic,readonly) SHTabBarControllerBlock SH_blockDidSelectViewController;
@property(nonatomic,readonly) SHTabBarControllerCustomizingBlock SH_blockWillBeginCustomizingViewControllers;
@property(nonatomic,readonly) SHTabBarControllerCustomizingWithChangeBlock SH_blockWillEndCustomizingViewControllers;
@property(nonatomic,readonly) SHTabBarControllerCustomizingWithChangeBlock SH_blockDidEndCustomizingViewControllers;
@property(nonatomic,readonly) SHTabBarControllerInteractiveControllerBlock SH_blockInteractiveController;
@property(nonatomic,readonly) SHTabBarControllerAnimatedControllerBlock SH_blockAnimatedController;

@end