
#import "OCUnit+SHTestCaseAdditions.h"


#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 70000 || __MAC_OS_X_VERSION_MIN_REQUIRED >= 1090)
@implementation XCTestCase (SHTestCaseAdditions)
#else
@implementation SenTestCase (SHTestCaseAdditions)
#endif

-(void)SH_runLoopUntilTestPassesWithBlock:(SHTestCaseConditional)theBlock withTimeOut:(NSTimeInterval)theTimeout; {
  NSParameterAssert(theBlock);
  NSParameterAssert(theTimeout >= 0);
  NSDate * timeoutDate = [NSDate dateWithTimeIntervalSinceNow:theTimeout];
  
  NSTimeInterval timeoutTime = [timeoutDate timeIntervalSinceReferenceDate];
  NSTimeInterval currentTime = 0.0;
  
  
  for (currentTime = [NSDate timeIntervalSinceReferenceDate];
       (theBlock() == NO && currentTime < timeoutTime);
       currentTime = [NSDate timeIntervalSinceReferenceDate]) {
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
  }
  
  STAssertTrue(currentTime <= timeoutTime, @"Timed out");
  
}

-(void)SH_performAsyncTestsWithinBlock:(SHTestCaseBlock)theBlock withTimeout:(NSTimeInterval)theTimeout; {
  NSParameterAssert(theBlock);
  NSParameterAssert(theTimeout >= 0);

  NSDate * timeoutDate = [NSDate dateWithTimeIntervalSinceNow:theTimeout];
  
  NSTimeInterval timeoutSeconds = [timeoutDate timeIntervalSinceReferenceDate];
  NSTimeInterval currentTime = 0.0;
  
  __block BOOL didFinish = NO;
  theBlock(&didFinish);
  for (currentTime = [NSDate timeIntervalSinceReferenceDate];
       (didFinish == NO && currentTime < timeoutSeconds);
       currentTime = [NSDate timeIntervalSinceReferenceDate]) {
    
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    
  }
  
  STAssertTrue(currentTime <= timeoutSeconds, @"Timed out");
}


@end
