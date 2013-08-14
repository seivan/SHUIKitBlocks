
@protocol SHFastEnumerationProperties;


@interface SHCommonEnumerationOperation : NSObject
//https://gist.github.com/seivan/6086183


+(NSDecimalNumber *)avgForEnumeration:(id<SHFastEnumerationProperties>)theEnumeration;
+(NSDecimalNumber *)sumForEnumeration:(id<SHFastEnumerationProperties>)theEnumeration;

+(id)maxForEnumeration:(id<SHFastEnumerationProperties>)theEnumeration;
+(id)minForEnumeration:(id<SHFastEnumerationProperties>)theEnumeration;
@end