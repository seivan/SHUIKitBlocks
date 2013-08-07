
#pragma mark -
#pragma mark Block Def
typedef BOOL (^SHPopverControllerShouldDismissBlock)(UIPopoverController * thePopoverController);
typedef void (^SHPopverControllerDidDismissBlock)(UIPopoverController * thePopoverController);

@interface UIPopoverController (SHPopoverControllerBlocks)


#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Setters

-(void)SH_setShouldDismissPopoverBlock:(SHPopverControllerShouldDismissBlock)theBlock;

-(void)SH_setDidDismissPopoverBlock:(SHPopverControllerDidDismissBlock)theBlock;

#pragma mark -
#pragma mark Getters

@property(nonatomic,readonly) SHPopverControllerShouldDismissBlock SH_blockShouldDismissPopoverBlock;
@property(nonatomic,readonly) SHPopverControllerDidDismissBlock    SH_blockDidDismissPopoverBlock;
@end