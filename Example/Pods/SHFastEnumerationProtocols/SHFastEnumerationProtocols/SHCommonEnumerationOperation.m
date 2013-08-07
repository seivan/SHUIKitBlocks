#import "SHFastEnumeration.h"
#import "SHCommonEnumerationOperation.h"

@protocol SHCommonEnumeration <SHFastEnumerationProperties, NSFastEnumeration>
@end


@implementation SHCommonEnumerationOperation
+(NSDecimalNumber *)avgForEnumeration:(id<SHCommonEnumeration>)theEnumeration; {
    return [[theEnumeration SH_toArray] valueForKeyPath:@"@avg.self"];
//  SEL doubleValueSelector = @selector(doubleValue);
//  __block CGFloat sum = 0;
//  __block NSInteger counter = 0;
//  for (id obj in theEnumeration) {
//    counter += 1;
//    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:
//                                [[obj class] instanceMethodSignatureForSelector:doubleValueSelector]];
//    [invocation setSelector:doubleValueSelector];
//    [invocation setTarget:obj];
//    [invocation invoke];
//    CGFloat returnValue;
//    [invocation getReturnValue:&returnValue];
//    sum += returnValue;
//  }
//  
//  CGFloat average = sum/counter;
//  return [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f", average]];
  
}

+(NSDecimalNumber *)sumForEnumeration:(id<SHCommonEnumeration>)theEnumeration; {
    return [[theEnumeration SH_toArray] valueForKeyPath:@"@sum.self"];
//  SEL doubleValueSelector = @selector(doubleValue);
//  __block CGFloat sum = 0;
//
//  for (id obj in theEnumeration) {
//    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:
//                                [[obj class] instanceMethodSignatureForSelector:doubleValueSelector]];
//    [invocation setSelector:doubleValueSelector];
//    [invocation setTarget:obj];
//    [invocation invoke];
//    CGFloat returnValue;
//    [invocation getReturnValue:&returnValue];
//    sum += returnValue;
//  }
//  
//  return [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f", sum]];

}

+(id)maxForEnumeration:(id<SHCommonEnumeration>)theEnumeration; {
  return [[theEnumeration SH_toArray] valueForKeyPath:@"@max.self"];
  
}

+(id)minForEnumeration:(id<SHCommonEnumeration>)theEnumeration; {
  return [[theEnumeration SH_toArray] valueForKeyPath:@"@min.self"];
}
  

@end