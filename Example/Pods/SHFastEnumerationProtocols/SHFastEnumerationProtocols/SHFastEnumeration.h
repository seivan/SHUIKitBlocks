
#pragma mark - Block Definitions
//obj is the key for keyed indexed classes (NSDictionary, NSMapTable)
typedef void (^SHIteratorBlock)(id obj);
typedef void (^SHIteratorWithIndexBlock)(id obj, NSInteger index) ;

typedef id (^SHIteratorReturnIdBlock)(id obj);
typedef id (^SHIteratorReduceBlock)(id memo, id obj);

typedef BOOL (^SHIteratorPredicateBlock)(id obj);

#pragma mark - <SHFastEnumerationBlocks>
@protocol SHFastEnumerationBlocks <NSObject>
@required

//obj is the key for keyed indexed classes (NSDictionary, NSMapTable)
-(void)SH_each:(SHIteratorBlock)theBlock;

//the loop is on HIGH queue, each iteration on BACKGROUND, completion callback is on main
-(void)SH_concurrentEach:(SHIteratorBlock)theBlock onComplete:(SHIteratorBlock)theCompleteBlock;

//Collect
-(instancetype)SH_map:(SHIteratorReturnIdBlock)theBlock;

//Inject/FoldLeft
-(id)SH_reduceValue:(id)theValue withBlock:(SHIteratorReduceBlock)theBlock;

//Match
-(id)SH_find:(SHIteratorPredicateBlock)theBlock;

//Select/Filter
-(instancetype)SH_findAll:(SHIteratorPredicateBlock)theBlock;

//!Select/Filter
-(instancetype)SH_reject:(SHIteratorPredicateBlock)theBlock;

//Every
-(BOOL)SH_all:(SHIteratorPredicateBlock)theBlock;

//Some
-(BOOL)SH_any:(SHIteratorPredicateBlock)theBlock;

// !Every
-(BOOL)SH_none:(SHIteratorPredicateBlock)theBlock;
@end

#pragma mark - <SHFastEnumerationProperties>
@protocol SHFastEnumerationProperties <NSObject>
@required
@property(nonatomic,readonly) BOOL           SH_isEmpty;

@property(nonatomic,readonly) NSArray      * SH_toArray;
@property(nonatomic,readonly) NSSet        * SH_toSet;
@property(nonatomic,readonly) NSOrderedSet * SH_toOrderedSet;

//The objects are the values while the key will either be an NSNumber index (from ordered)
//or a counted key (unordereD)
@property(nonatomic,readonly) NSDictionary * SH_toDictionary;
@property(nonatomic,readonly) NSMapTable   * SH_toMapTableWeakToWeak;
@property(nonatomic,readonly) NSMapTable   * SH_toMapTableWeakToStrong;
@property(nonatomic,readonly) NSMapTable   * SH_toMapTableStrongToStrong;
@property(nonatomic,readonly) NSMapTable   * SH_toMapTableStrongToWeak;

@property(nonatomic,readonly) NSHashTable  * SH_toHashTableWeak;
@property(nonatomic,readonly) NSHashTable  * SH_toHashTableStrong;

//https://gist.github.com/seivan/6086183
@property(nonatomic,readonly) NSDecimalNumber  * SH_collectionAvg;
@property(nonatomic,readonly) NSDecimalNumber  * SH_collectionSum;
@property(nonatomic,readonly) id                 SH_collectionMax;
@property(nonatomic,readonly) id                 SH_collectionMin;

@end

#pragma mark - <SHFastEnumerationOrderedBlocks>
@protocol SHFastEnumerationOrderedBlocks <NSObject>
@required
-(void)SH_eachWithIndex:(SHIteratorWithIndexBlock)theBlock;
@end

#pragma mark - <SHFastEnumerationOrderedProperties>
@protocol SHFastEnumerationOrderedProperties <NSObject>
@required
@property(nonatomic,readonly) id SH_firstObject;
@property(nonatomic,readonly) id SH_lastObject;
@end


#pragma mark - <SHFastEnumerationOrdered>
@protocol SHFastEnumerationOrdered <NSObject>
@required
-(instancetype)SH_reverse;
@end


#pragma mark - <SHMutableFastEnumerationBlocks>
@protocol SHMutableFastEnumerationBlocks <NSObject>
@required
-(void)SH_modifyMap:(SHIteratorReturnIdBlock)theBlock;
-(void)SH_modifyFindAll:(SHIteratorPredicateBlock)theBlock;
-(void)SH_modifyReject:(SHIteratorPredicateBlock)theBlock;
@end


#pragma mark - <SHMutableFastEnumerationOrdered>
@protocol SHMutableFastEnumerationOrdered <NSObject>
@required
-(void)SH_modifyReverse;
-(id)SH_popObjectAtIndex:(NSInteger)theIndex;
-(id)SH_popFirstObject;
-(id)SH_popLastObject;
@end



