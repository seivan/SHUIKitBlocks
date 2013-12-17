
#pragma mark -
#pragma mark Block Def
typedef void (^SHNavigationControllerBlock)(UINavigationController * theNavigationController,
                                            UIViewController       * theViewController,
                                            BOOL                      isAnimated);


@interface UINavigationController (SHNavigationControllerBlocks)



#pragma mark - Properties

#pragma mark - Setters

-(void)SH_setWillShowViewControllerBlock:(SHNavigationControllerBlock)theBlock;

-(void)SH_setDidShowViewControllerBlock:(SHNavigationControllerBlock)theBlock;


#pragma mark - Getters

@property(nonatomic,readonly) SHNavigationControllerBlock SH_blockWillShowViewController;
@property(nonatomic,readonly) SHNavigationControllerBlock SH_blockDidShowViewController;
@end