



#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 70000 || __MAC_OS_X_VERSION_MIN_REQUIRED >= 1090)
#import <XCTest/XCTest.h>
@interface XCTestCase (SHTestCaseAdditions)
#else
#import <SenTestingKit/SenTestingKit.h>
@interface SenTestCase (SHTestCaseAdditions)
#endif


#pragma mark -
#pragma mark Block Definitions
typedef BOOL (^SHTestCaseConditional)();
typedef void (^SHTestCaseBlock)(BOOL *didFinish);

#pragma mark -
#pragma mark Helpers
-(void)SH_runLoopUntilTestPassesWithBlock:(SHTestCaseConditional)theBlock
                              withTimeOut:(NSTimeInterval)theTimeout;

-(void)SH_performAsyncTestsWithinBlock:(SHTestCaseBlock)theBlock
                           withTimeout:(NSTimeInterval)theTimeout;

@end


