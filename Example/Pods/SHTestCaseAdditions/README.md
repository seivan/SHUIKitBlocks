SHTestCaseAdditions
==========
[![Build Status](https://travis-ci.org/seivan/SHTestCaseAdditions.png?branch=master)](https://travis-ci.org/seivan/SHTestCaseAdditions)
[![Version](http://cocoapod-badges.herokuapp.com/v/SHTestCaseAdditions/badge.png)](http://cocoadocs.org/docsets/SHTestCaseAdditions)
[![Platform](http://cocoapod-badges.herokuapp.com/p/SHTestCaseAdditions/badge.png)](http://cocoadocs.org/docsets/SHTestCaseAdditions)

Overview
--------
Prefixed Asynchronous test helpers as a category on SenTestCase and XCTestCase

* Swizzle and junk free
* Prefixed selectors.
* Works with both SentTest and/or XCTest
* For iOS and Mac OS
* Comes with tests and example. 


Navigation
----------
#### [Usage](https://github.com/seivan/SHTestCaseAdditions#usage-1)
#### [API](https://github.com/seivan/SHTestCaseAdditions#api-1)


Installation
------------

```ruby
pod 'SHTestCaseAdditions'
```

***

Setup
-----

Put this either in specific files or your project prefix file

```objective-c
#import "OCUnit+SHTestCaseAdditions.h"
```
or 
```objective-c
#import "SHTestCaseAdditions.h"
```

Usage
-----

```objective-c
-(void)testSH_runLoopUntilTestPassesWithBlock_withTimeOut; {
  NSString * keyPath = @"sampleSet";
  __block BOOL didPass = NO;

  [self SH_addObserverForKeyPaths:@[keyPath].SH_toSet withOptions:0 block:^(id weakSelf, NSString *keyPath, NSDictionary *change) {
    didPass = YES;
  }];

  double delayInSeconds = 2;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    [[self mutableSetValueForKey:keyPath] addObject:@"Lol"];
  });

  
  [self SH_runLoopUntilTestPassesWithBlock:^BOOL{
    return didPass;
  } withTimeOut:5];
  
  
  STAssertTrue(didPass, nil);
  
}

-(void)testSH_performAsyncTestsWithinBlock_withTimeout; {
  NSString * keyPath = @"sampleArray";
  __block BOOL didPass = NO;
  [self SH_performAsyncTestsWithinBlock:^(BOOL *didFinish) {
    
    [self SH_addObserverForKeyPaths:@[keyPath].SH_toSet withOptions:0 block:^(id weakSelf, NSString *keyPath, NSDictionary *change) {
      didPass = YES;
      *didFinish = YES;
    }];
    
    double delayInSeconds = 2;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
      [[self mutableArrayValueForKey:keyPath] addObject:@"Lol"];
    });
    
  } withTimeout:5];
  
  STAssertTrue(didPass, nil);
  
}

```

API
-----

```objective-c
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 70000 || __MAC_OS_X_VERSION_MIN_REQUIRED >= 1090)
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

```


Contact
-------

If you end up using SHTestCaseAdditions in a project, I'd love to hear about it.

email: [seivan.heidari@icloud.com](mailto:seivan.heidari@icloud.com)  
twitter: [@seivanheidari](https://twitter.com/seivanheidari)

## License

SHTestCaseAdditions is © 2013 [Seivan](http://www.github.com/seivan) and may be freely
distributed under the [MIT license](http://opensource.org/licenses/MIT).
See the [`LICENSE.md`](https://github.com/PodFactory/SHTestCaseAdditions/blob/master/LICENSE.md) file.

