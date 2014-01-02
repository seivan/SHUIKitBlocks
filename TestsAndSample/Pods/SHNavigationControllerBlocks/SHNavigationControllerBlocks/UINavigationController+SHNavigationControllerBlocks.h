

#pragma mark - Block Definitions
typedef void (^SHNavigationControllerBlock)(UINavigationController * navigationController,
                                            UIViewController       * viewController,
                                            BOOL                      isAnimated);

typedef UIInterfaceOrientation(^SHNavigationControllerOrientationBlock)(UINavigationController * navigationController);

typedef id<UIViewControllerInteractiveTransitioning>
(^SHNavigationControllerInteractiveTransitionBlock)(UINavigationController * navigationController,
                                                    id<UIViewControllerAnimatedTransitioning> animationController);

typedef id<UIViewControllerAnimatedTransitioning>
(^SHNavigationControllerAnimatedTransitionBlock) (UINavigationController * navigationController,
                                                  UINavigationControllerOperation operation,
                                                  UIViewController * fromVC,
                                                  UIViewController * toVC
                                                  );


@interface UINavigationController (SHNavigationControllerBlocks)



#pragma mark - Properties

#pragma mark - Setters

-(void)SH_setWillShowViewControllerBlock:(SHNavigationControllerBlock)theBlock;

-(void)SH_setDidShowViewControllerBlock:(SHNavigationControllerBlock)theBlock;

-(void)SH_setPreferredInterfaceOrientationForPresentatationBlock:(SHNavigationControllerOrientationBlock)theBlock;

-(void)SH_setInteractiveTransitioningBlock:(SHNavigationControllerInteractiveTransitionBlock)theBlock;

-(void)SH_setAnimatedTransitioningBlock:(SHNavigationControllerAnimatedTransitionBlock)theBlock;

#pragma mark - Getters

@property(nonatomic,readonly) SHNavigationControllerBlock SH_blockWillShowViewController;
@property(nonatomic,readonly) SHNavigationControllerBlock SH_blockDidShowViewController;
@property(nonatomic,readonly) SHNavigationControllerOrientationBlock SH_blockInterfaceOrientationForPresentation;
@property(nonatomic,readonly) SHNavigationControllerInteractiveTransitionBlock SH_blockInteractiveTransitioning;
@property(nonatomic,readonly) SHNavigationControllerAnimatedTransitionBlock SH_blockAnimatedTransitioning;


@end