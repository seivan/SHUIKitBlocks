//
//  UIControl+SHControlEventBlock.h
//  Example
//
//  Created by Seivan Heidari on 5/16/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "UITextView+SHTextViewBlocks.h"

#define SHStaticConstString(X) static NSString * const X = @#X

SHStaticConstString(SH_blockShouldBeginEditing);
SHStaticConstString(SH_blockShouldEndEditing);

SHStaticConstString(SH_blockDidBeginEditing);
SHStaticConstString(SH_blockDidEndEditing);

SHStaticConstString(SH_blockShouldChangeCharactersInRangeWithReplacementText);
SHStaticConstString(SH_blockDidChange);
SHStaticConstString(SH_blockDidChangeSelection);


@interface UITextViewBlocksManager : NSObject
<UITextViewDelegate>
@property(nonatomic,strong) NSMapTable     * mapBlocks;

+(void)setMapTable:(NSMapTable *)theMapTable forTextView:(UITextView *)theTextView;
+(NSMapTable *)mapTableForTextView:(UITextView *)theTextView;
+(instancetype)sharedManager;
-(void)SH_memoryDebugger;
-(NSMapTable *)mapTableForTextView:(UITextView *)theTextView;
@end
@implementation UITextViewBlocksManager

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
  static UITextViewBlocksManager *_sharedInstance;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedInstance = [[UITextViewBlocksManager alloc] init];
    
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
+(void)setMapTable:(NSMapTable *)theMapTable forTextView:(UITextView *)theTextView; {
  [[[UITextViewBlocksManager sharedManager] mapBlocks] setObject:theMapTable
                                                           forKey:theTextView];
}

#pragma mark - Getter
+(NSMapTable *)mapTableForTextView:(UITextView *)theTextView; {
  return [[[UITextViewBlocksManager sharedManager] mapBlocks] objectForKey:theTextView];
}

-(NSMapTable *)mapTableForTextView:(UITextView *)theTextView; {
  return [[[UITextViewBlocksManager sharedManager] mapBlocks] objectForKey:theTextView];
}

#pragma mark - <UITextViewDelegate>
// return NO to disallow editing.
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView; {
  BOOL textViewShouldBeginEditing = YES;
  SHTextViewPredicateBlock block = [[self mapTableForTextView:textView]
                                     objectForKey:SH_blockShouldBeginEditing];
  if(block) textViewShouldBeginEditing = block(textView);
  return textViewShouldBeginEditing;
}

// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end

-(BOOL)textViewShouldEndEditing:(UITextView *)textView; {
  BOOL textViewShouldEndEditing = YES;
  SHTextViewPredicateBlock block = [[self mapTableForTextView:textView]
                                    objectForKey:SH_blockShouldEndEditing];
  if(block) textViewShouldEndEditing = block(textView);
  return textViewShouldEndEditing;
  
}



// became first responder
-(void)textViewDidBeginEditing:(UITextView *)textView; {
  SHTextViewBlock block = [[self mapTableForTextView:textView]
                            objectForKey:SH_blockDidBeginEditing];
  if(block) block(textView);
  
}


// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
-(void)textViewDidEndEditing:(UITextView *)textView; {
  SHTextViewBlock block = [[self mapTableForTextView:textView]
                            objectForKey:SH_blockDidEndEditing];
  if(block) block(textView);

}

// return NO to not change text
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text; {
  BOOL shouldChangeTextInRange = YES;
  SHTextViewRangeReplacementBlock block = [[self mapTableForTextView:textView]
                                     objectForKey:SH_blockShouldChangeCharactersInRangeWithReplacementText];
  if(block) shouldChangeTextInRange = block(textView,range,text);
  return shouldChangeTextInRange;

}


- (void)textViewDidChange:(UITextView *)textView; {
  SHTextViewBlock block = [[self mapTableForTextView:textView]
                           objectForKey:SH_blockDidChange];
  if(block) block(textView);
  
}

- (void)textViewDidChangeSelection:(UITextView *)textView; {
  SHTextViewBlock block = [[self mapTableForTextView:textView]
                           objectForKey:SH_blockDidChangeSelection];
  if(block) block(textView);
  
}

@end



@interface UITextView (Private)
@property(nonatomic,readonly) NSMapTable * mapBlocks;
-(void)setBlock:(id)theBlock forKey:(NSString *)theKey;
@end



@implementation UITextView (SHTextViewBlocks)

#pragma mark - Setters

-(void)SH_setShouldBeginEditingBlock:(SHTextViewPredicateBlock)theBlock; {
  [self setBlock:theBlock forKey:SH_blockShouldBeginEditing];
}

-(void)SH_setDidBeginEditingBlock:(SHTextViewBlock)theBlock; {
  [self setBlock:theBlock forKey:SH_blockDidBeginEditing];

}

-(void)SH_setShouldEndEditingBlock:(SHTextViewPredicateBlock)theBlock; {
  [self setBlock:theBlock forKey:SH_blockShouldEndEditing];

}

-(void)SH_setDidEndEditingBlock:(SHTextViewBlock)theBlock; {
  [self setBlock:theBlock forKey:SH_blockDidEndEditing];
}

-(void)SH_setShouldChangeCharactersInRangeWithReplacementTextBlock:(SHTextViewRangeReplacementBlock)theBlock; {
  [self setBlock:theBlock
          forKey:SH_blockShouldChangeCharactersInRangeWithReplacementText];

}

-(void)SH_setDidChangeBlock:(SHTextViewBlock)theBlock; {
  [self setBlock:theBlock forKey:SH_blockDidChange];
}

-(void)SH_setDidChangeSelection:(SHTextViewBlock)theBlock; {
  [self setBlock:theBlock forKey:SH_blockDidChangeSelection];  
}




#pragma mark - Getters

-(SHTextViewPredicateBlock)SH_blockShouldBeginEditing; {
  return [self.mapBlocks objectForKey:SH_blockShouldBeginEditing];
}

-(SHTextViewBlock)SH_blockDidBeginEditing; {
  return [self.mapBlocks objectForKey:SH_blockDidBeginEditing];
}

-(SHTextViewPredicateBlock)SH_blockShouldEndEditing; {
  return [self.mapBlocks objectForKey:SH_blockShouldEndEditing];
}

-(SHTextViewBlock)SH_blockDidEndEditing; {
  return [self.mapBlocks objectForKey:SH_blockDidEndEditing];
}

-(SHTextViewRangeReplacementBlock)SH_blockShouldChangeCharactersInRangeWithReplacementText; {
  return [self.mapBlocks objectForKey:SH_blockShouldChangeCharactersInRangeWithReplacementText];
}


-(SHTextViewBlock)SH_blockDidChange; {
  return [self.mapBlocks objectForKey:SH_blockDidChange];
  
}

-(SHTextViewBlock)SH_blockDidChangeSelection; {
  return [self.mapBlocks objectForKey:SH_blockDidChangeSelection];
}

#pragma mark - Private

#pragma mark - Properties
#pragma mark - setters
-(void)setBlock:(id)theBlock forKey:(NSString *)theKey; {
  NSParameterAssert(theKey);
  if(theBlock) [self.mapBlocks setObject:theBlock forKey:theKey];
  else         [self.mapBlocks removeObjectForKey:theKey];
}

#pragma mark - Getter
-(NSMapTable *)mapBlocks; {
  self.delegate = [UITextViewBlocksManager sharedManager];
  NSMapTable * mapTable = [UITextViewBlocksManager mapTableForTextView:self];
  if(mapTable == nil) mapTable = [NSMapTable strongToStrongObjectsMapTable];
  [UITextViewBlocksManager setMapTable:mapTable forTextView:self];
  return mapTable;
  
}

@end

