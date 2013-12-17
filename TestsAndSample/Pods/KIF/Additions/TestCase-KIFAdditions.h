//
//  TestCase-KIFAdditions.h
//  KIF
//
//  Created by Tony DiPasquale on 12/9/13.
//
//

#import "KIFTestActor.h"

#ifdef XCT_EXPORT

#import <XCTest/XCTest.h>
@interface XCTestCase (KIFAdditions) <KIFTestActorDelegate>

#else

#import <SenTestingKit/SenTestingKit.h>
@interface SenTestCase (KIFAdditions) <KIFTestActorDelegate>

#endif

@end
