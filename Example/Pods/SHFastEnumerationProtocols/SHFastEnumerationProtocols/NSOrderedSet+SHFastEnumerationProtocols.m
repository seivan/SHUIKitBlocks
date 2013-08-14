//
//  NSOrderedSet+SHFastEnumerationBlocks.m
//  Pods
//
//  Created by Seivan Heidari on 7/15/13.
//
//

#import "NSOrderedSet+SHFastEnumerationProtocols.h"

#import "SHCommonEnumerationOperation.h"

@interface NSOrderedSet (Private)
-(NSMapTable *)mapTableWith:(NSMapTable *)theMapTable;
@end

@implementation NSOrderedSet (SHFastEnumerationProtocols)
@dynamic SH_firstObject;
@dynamic SH_lastObject;
@dynamic SH_toArray;
@dynamic SH_toSet;
@dynamic SH_toOrderedSet;
@dynamic SH_toDictionary;
@dynamic SH_toMapTableWeakToWeak;
@dynamic SH_toMapTableWeakToStrong;
@dynamic SH_toMapTableStrongToStrong;
@dynamic SH_toMapTableStrongToWeak;
@dynamic SH_toHashTableWeak;
@dynamic SH_toHashTableStrong;

#pragma mark - <SHFastEnumerationBlocks>
-(void)SH_each:(SHIteratorBlock)theBlock; { NSParameterAssert(theBlock);
  for (id obj in self) theBlock(obj);
}


-(void)SH_concurrentEach:(SHIteratorBlock)theBlock onComplete:(SHIteratorBlock)theCompleteBlock; { NSParameterAssert(theBlock);
  dispatch_group_t group = dispatch_group_create();
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
    [self SH_each:^(id obj) {
      dispatch_group_enter(group);
      
      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        theBlock(obj);
        dispatch_group_leave(group);
      });
      
    }];
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
      theCompleteBlock(self);
    });
    
  });
}
-(instancetype)SH_map:(SHIteratorReturnIdBlock)theBlock; { NSParameterAssert(theBlock);
  
  NSMutableOrderedSet * map = [NSMutableOrderedSet orderedSet];
  
  for (id obj in self) {
    id value = theBlock(obj);
    if(value) [map addObject:value];
  }
  return map.copy;
}

-(id)SH_reduceValue:(id)theValue withBlock:(SHIteratorReduceBlock)theBlock; { NSParameterAssert(theBlock);
  
  id result = theValue;
	for (id obj in self)result = theBlock(result,obj);
	return result;
  
}

-(id)SH_find:(SHIteratorPredicateBlock)theBlock; { NSParameterAssert(theBlock);
  id value = nil;
	NSInteger index = [self indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) { return theBlock(obj); }];
	
	if (index != NSNotFound) value = self[index];
	
	return value;
  
}

-(instancetype)SH_findAll:(SHIteratorPredicateBlock)theBlock; { NSParameterAssert(theBlock);
  return [NSOrderedSet orderedSetWithArray:[self objectsAtIndexes:
          [self indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger _, BOOL *__) {
		return theBlock(obj);
	}]]];
}

-(instancetype)SH_reject:(SHIteratorPredicateBlock)theBlock; { NSParameterAssert(theBlock);
  return [self SH_findAll:^BOOL(id obj) { return theBlock(obj) == NO; }];
}

-(BOOL)SH_all:(SHIteratorPredicateBlock)theBlock; { NSParameterAssert(theBlock);
  return [self SH_findAll:theBlock].count == self.count;
}

-(BOOL)SH_any:(SHIteratorPredicateBlock)theBlock; { NSParameterAssert(theBlock);
  return [self SH_find:theBlock] != nil;
}

-(BOOL)SH_none:(SHIteratorPredicateBlock)theBlock; { NSParameterAssert(theBlock);
  return [self SH_all:theBlock] == NO;
}

#pragma mark - <SHFastEnumerationProperties>
-(BOOL)SH_isEmpty; {
  return self.count == 0;
}
-(NSArray *)SH_toArray; {
  return self.array;
}

-(NSSet *)SH_toSet; {
  return self.set;
}

-(NSOrderedSet *)SH_toOrderedSet; {
  return self.copy;
}

-(NSDictionary *)SH_toDictionary; {
  __block NSInteger counter = -1;
  return [NSDictionary dictionaryWithObjects:self.SH_toArray
                                     forKeys:
          [self SH_map:^id(id obj) {return @(counter +=1);}].SH_toArray];
}

-(NSMapTable *)SH_toMapTableWeakToWeak; {
  NSMapTable * mapTable = [NSMapTable weakToWeakObjectsMapTable];
  return [self mapTableWith:mapTable];
}

-(NSMapTable *)SH_toMapTableWeakToStrong; {
  NSMapTable * mapTable = [NSMapTable weakToStrongObjectsMapTable];
  return [self mapTableWith:mapTable];
}

-(NSMapTable *)SH_toMapTableStrongToStrong; {
  NSMapTable * mapTable = [NSMapTable strongToStrongObjectsMapTable];
  return [self mapTableWith:mapTable];
}

-(NSMapTable *)SH_toMapTableStrongToWeak; {
  NSMapTable * mapTable = [NSMapTable strongToWeakObjectsMapTable];
  return [self mapTableWith:mapTable];
}

-(NSHashTable *)SH_toHashTableWeak; {
  NSHashTable * hashTable = [[NSHashTable alloc] initWithOptions:NSPointerFunctionsStrongMemory capacity:self.count];
  
  [self SH_each:^(id obj) { [hashTable addObject:obj]; }];
  return hashTable;
}

-(NSHashTable *)SH_toHashTableStrong; {
  NSHashTable * hashTable = [NSHashTable weakObjectsHashTable];
  
  [self SH_each:^(id obj) { [hashTable addObject:obj]; }];
  return hashTable;
}

-(NSDecimalNumber *)SH_collectionAvg; {
  return [SHCommonEnumerationOperation avgForEnumeration:self];
}

-(NSDecimalNumber  *) SH_collectionSum; {
  return [SHCommonEnumerationOperation sumForEnumeration:self];
}

-(id)SH_collectionMax; {
  return [SHCommonEnumerationOperation maxForEnumeration:self];
}

-(id)SH_collectionMin; {
  return [SHCommonEnumerationOperation minForEnumeration:self];
}



#pragma mark - <SHFastEnumerationOrderedBlocks>

-(void)SH_eachWithIndex:(SHIteratorWithIndexBlock)theBlock; { NSParameterAssert(theBlock);
  
  [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *_) {
    theBlock(obj,idx);
  }];
}


#pragma mark - <SHFastEnumerationOrderedProperties>
-(id)SH_firstObject; {
  id obj = nil;
  if(self.count > 0) obj = [self objectAtIndex:0];
  return obj;
}

-(id)SH_lastObject; {
  return self.lastObject;
}


#pragma mark - <SHFastEnumerationOrdered>
-(instancetype)SH_reverse; {
  return self.reversedOrderedSet;
}

@end

@implementation NSMutableOrderedSet (SHFastEnumerationProtocols)


#pragma mark - <SHMutableFastEnumerationBlocks>
-(void)SH_modifyMap:(SHIteratorReturnIdBlock)theBlock; { NSParameterAssert(theBlock);
  typeof(self) newSelf = self.copy;
  [self removeAllObjects];
	[self addObjectsFromArray:[newSelf SH_map:theBlock].SH_toArray];
}

-(void)SH_modifyFindAll:(SHIteratorPredicateBlock)theBlock; { NSParameterAssert(theBlock);
  typeof(self) newSelf = self.copy;
  [self removeAllObjects];
	[self addObjectsFromArray:[newSelf SH_findAll:theBlock].SH_toArray];


}

-(void)SH_modifyReject:(SHIteratorPredicateBlock)theBlock; { NSParameterAssert(theBlock);
  typeof(self) newSelf = self.copy;
  [self removeAllObjects];
	[self addObjectsFromArray:[newSelf SH_reject:theBlock].SH_toArray];
}

#pragma mark - <SHMutableFastEnumerationOrdered>

-(void)SH_modifyReverse; {
  typeof(self) newSelf = self.copy;
  [self removeAllObjects];
  [self addObjectsFromArray:newSelf.SH_reverse.SH_toArray];
}


-(id)SH_popObjectAtIndex:(NSInteger)theIndex; {
  id obj = [self objectAtIndex:theIndex];
  [self removeObjectAtIndex:theIndex];
  return obj;
}

-(id)SH_popFirstObject; {
  id obj = nil;
  if(self.count > 0) obj = [self SH_popObjectAtIndex:0];
  return obj;
  
}

-(id)SH_popLastObject; {
  id obj = nil;
  NSInteger lastIndex = self.count-1;
  if(lastIndex >= 0) obj = [self SH_popObjectAtIndex:lastIndex];
  return obj;
}


@end

@implementation NSOrderedSet (Private)

#pragma mark - Private
-(NSMapTable *)mapTableWith:(NSMapTable *)theMapTable; {
  [self SH_eachWithIndex:^(id obj, NSInteger index) {
    [theMapTable setObject:obj forKey:@(index)];
  }];
  return theMapTable;
}

@end