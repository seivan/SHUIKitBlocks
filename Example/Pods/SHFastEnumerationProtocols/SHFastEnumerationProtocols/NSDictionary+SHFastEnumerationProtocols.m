//
//  NSDictionary+SHFastEnumerationBlocks.m
//  Pods
//
//  Created by Seivan Heidari on 7/15/13.
//
//

#import "NSDictionary+SHFastEnumerationProtocols.h"

#import "SHCommonEnumerationOperation.h"

@interface NSDictionary (Private)
-(NSMapTable *)mapTableWith:(NSMapTable *)theMapTable;
@end

@implementation NSDictionary (SHFastEnumerationProtocols)
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
  NSMutableDictionary * map = [NSMutableDictionary dictionaryWithCapacity:self.count];
  for (id key in self) {
    id value = theBlock(key);
    if(value) [map setObject:value forKey:key];
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
  for (id obj in self) {
    BOOL isPassed = theBlock(obj);
    if(isPassed && value == nil) {
      value = obj;
      break;
    }
  }
  return value;
}

-(instancetype)SH_findAll:(SHIteratorPredicateBlock)theBlock; { NSParameterAssert(theBlock);
  NSMutableDictionary * map = [NSMutableDictionary dictionaryWithCapacity:self.count];

  [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
    if(theBlock(key)) [map setObject:obj forKey:key];
  }];
  
  return map;
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
  NSMutableArray * array = [NSMutableArray arrayWithCapacity:self.count];
  [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
    [array addObject:@[key,obj]];
  }];
  return array.copy;
}

-(NSSet *)SH_toSet; {
  NSMutableSet * set = [NSMutableSet setWithCapacity:self.count];
  [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
    [set addObject:[NSSet setWithObjects:key,obj, nil]];
  }];
  return set.copy;
}

-(NSOrderedSet *)SH_toOrderedSet; {
  NSMutableOrderedSet * orderedSet = [NSMutableOrderedSet orderedSetWithCapacity:self.count];
  [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
    [orderedSet addObject:[NSOrderedSet orderedSetWithObjects:key,obj, nil]];
  }];
  return orderedSet.copy;
}

-(NSDictionary *)SH_toDictionary; {
  return self.copy;
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
  NSHashTable * hashTable = [NSHashTable weakObjectsHashTable];
  
  [self SH_each:^(id obj) {
    NSHashTable * table = [NSHashTable weakObjectsHashTable];
    [table addObject:obj];
    [table addObject:[self objectForKey:obj]];
    [hashTable addObject:table];
    
  }];
  return hashTable;

}

-(NSHashTable *)SH_toHashTableStrong; {
  NSHashTable * hashTable = [[NSHashTable alloc]
                             initWithOptions:NSPointerFunctionsStrongMemory
                             capacity:self.count];
  [self SH_each:^(id obj) {
    NSHashTable * table = [[NSHashTable alloc]
                           initWithOptions:NSPointerFunctionsStrongMemory
                           capacity:2];
    [table addObject:obj];
    [table addObject:[self objectForKey:obj]];
    [hashTable addObject:table];
  }];
  return hashTable;

}

-(NSDecimalNumber *)SH_collectionAvg; {
  id<SHFastEnumerationProperties> values = (id<SHFastEnumerationProperties>)self.allValues;
  return [SHCommonEnumerationOperation avgForEnumeration:values];
}

-(NSDecimalNumber  *) SH_collectionSum; {
  id<SHFastEnumerationProperties> values = (id<SHFastEnumerationProperties>)self.allValues;
  return [SHCommonEnumerationOperation sumForEnumeration:values];
}

-(id)SH_collectionMax; {
  id<SHFastEnumerationProperties> values = (id<SHFastEnumerationProperties>)self.allValues;
  return [SHCommonEnumerationOperation maxForEnumeration:values];
}

-(id)SH_collectionMin; {
  id<SHFastEnumerationProperties> values = (id<SHFastEnumerationProperties>)self.allValues;
  return [SHCommonEnumerationOperation minForEnumeration:values];
}



@end

@implementation NSMutableDictionary (SHFastEnumerationProtocols)
#pragma mark - <SHMutableFastEnumerationBlocks>
-(void)SH_modifyMap:(SHIteratorReturnIdBlock)theBlock; { NSParameterAssert(theBlock);
  [self setDictionary:[self SH_map:theBlock].mutableCopy];
}

-(void)SH_modifyFindAll:(SHIteratorPredicateBlock)theBlock; { NSParameterAssert(theBlock);
  [self setDictionary:[self SH_findAll:theBlock].mutableCopy];
}

-(void)SH_modifyReject:(SHIteratorPredicateBlock)theBlock; { NSParameterAssert(theBlock);
  [self setDictionary:[self SH_reject:theBlock].mutableCopy];
  
}


@end

@implementation NSDictionary (Private)

#pragma mark - Private
-(NSMapTable *)mapTableWith:(NSMapTable *)theMapTable; {
  [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
    [theMapTable setObject:obj forKey:key];
  }];
  return theMapTable;
}

@end