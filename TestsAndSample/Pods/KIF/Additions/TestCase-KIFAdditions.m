//
//  TestCase-KIFAdditions.m
//  KIF
//
//  Created by Tony DiPasquale on 12/9/13.
//
//

#import "TestCase-KIFAdditions.h"
#import "LoadableCategory.h"

MAKE_CATEGORIES_LOADABLE(TestCase_KIFAdditions)

#ifdef XCT_EXPORT
@implementation XCTestCase (KIFAdditions)
#else
@implementation SenTestCase (KIFAdditions)
#endif

- (void)failWithException:(NSException *)exception stopTest:(BOOL)stop
{
#ifdef XCT_EXPORT
    [self recordFailureWithDescription:exception.description inFile:exception.userInfo[@"SenTestFilenameKey"] atLine:[exception.userInfo[@"SenTestLineNumberKey"] unsignedIntegerValue] expected:YES];
#else
    if (stop) {
        [self raiseAfterFailure];
    }
    [self failWithException:exception];
#endif
    [self continueAfterFailure];
}

- (void)failWithExceptions:(NSArray *)exceptions stopTest:(BOOL)stop
{
    NSException *lastException = exceptions.lastObject;
    for (NSException *exception in exceptions) {
        [self failWithException:exception stopTest:(exception == lastException ? stop : NO)];
    }
}

@end
