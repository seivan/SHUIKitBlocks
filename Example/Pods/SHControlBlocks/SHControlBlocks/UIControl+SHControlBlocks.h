//
//  UIControl+SHControlEventBlock.h
//  Example
//
//  Created by Seivan Heidari on 5/16/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#pragma mark -
#pragma mark Block Defs
typedef void (^SHControlEventBlock)(UIControl * sender);

@interface UIControl (SHControlBlocks)

#pragma mark -
#pragma mark Add block
-(void)SH_addControlEvents:(UIControlEvents)controlEvents
                 withBlock:(SHControlEventBlock)theBlock;

-(void)SH_addControlEventTouchUpInsideWithBlock:(SHControlEventBlock)theBlock;


#pragma mark -
#pragma mark Remove block
-(void)SH_removeControlEventTouchUpInside;
-(void)SH_removeBlocksForControlEvents:(UIControlEvents)controlEvents;
-(void)SH_removeControlEventsForBlock:(SHControlEventBlock)theBlock;
-(void)SH_removeAllControlEventsBlocks;

#pragma mark -
#pragma mark Helpers
-(NSSet *)SH_blocksForControlEvents:(UIControlEvents)theControlEvents;
-(NSSet *)SH_controlEventsForBlock:(SHControlEventBlock)theBlock;


#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Getters
@property(nonatomic,readonly) BOOL SH_isTouchUpInsideEnabled;

@property(nonatomic,readonly) NSDictionary * SH_controlBlocks;


@end
