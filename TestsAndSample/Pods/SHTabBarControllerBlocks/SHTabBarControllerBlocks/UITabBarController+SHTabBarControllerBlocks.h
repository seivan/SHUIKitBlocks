
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


@interface UITabBarController (SHTabBarControllerBlocks)



#pragma mark - Properties

#pragma mark - Setters
-(void)SH_setShouldSelectViewControllerBlock:(SHTabBarControllerPredicateBlock)theBlock;
-(void)SH_setDidSelectViewControllerBlock:(SHTabBarControllerBlock)theBlock;
-(void)SH_setWillBeginCustomizingViewControllersBlock:(SHTabBarControllerCustomizingBlock)theBlock;
-(void)SH_setWillEndCustomizingViewControllersBlock:(SHTabBarControllerCustomizingWithChangeBlock)theBlock;
-(void)SH_setDidEndCustomizingViewControllersBlock:(SHTabBarControllerCustomizingWithChangeBlock)theBlock;



#pragma mark - Getters
-(SHTabBarControllerPredicateBlock)SH_blockShouldSelectViewController;
-(SHTabBarControllerBlock)SH_blockDidSelectViewController;
-(SHTabBarControllerCustomizingBlock)SH_blockWillBeginCustomizingViewControllers;
-(SHTabBarControllerCustomizingWithChangeBlock)SH_blockWillEndCustomizingViewControllers;
-(SHTabBarControllerCustomizingWithChangeBlock)SH_blockDidEndCustomizingViewControllers;

@end