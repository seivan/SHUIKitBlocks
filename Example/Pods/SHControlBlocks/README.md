SHControlBlocks
==========

Overview
--------
The blocks and events are automatically removed once their control is gone, so it isn't necessary to clean up - Swizzle Free(™)

### API

#### [Creating](https://github.com/seivan/SHControlBlocks#creating-2)

#### [Removing](https://github.com/seivan/SHControlBlocks#removing-2)

#### [Helpers and Properties](https://github.com/seivan/SHControlBlocks#helpers-and-properties-2)

### USAGE

#### [Creating](https://github.com/seivan/SHControlBlocks#creating-3)

#### [Removing](https://github.com/seivan/SHControlBlocks#removing-3)

#### [Helpers and Properties](https://github.com/seivan/SHControlBlocks#helpers-and-properties-3)

Installation
------------

```ruby
pod 'SHControlBlocks'
```

***

Setup
-----

Put this either in specific files or your project prefix file

```objective-c
#import 'UIControl+SHControlBlocks.h'
```
or
```objective-c
#import 'SHControlBlocks.h'
```

API
-----

### Creating

```objective-c
#pragma mark -
#pragma mark Add block
-(void)SH_addControlEvents:(UIControlEvents)controlEvents
                 withBlock:(SHControlEventBlock)theBlock;

-(void)SH_addControlEventTouchUpInsideWithBlock:(SHControlEventBlock)theBlock;

```

### Removing

```objective-c
#pragma mark -
#pragma mark Remove block
-(void)SH_removeControlEventTouchUpInside;
-(void)SH_removeBlocksForControlEvents:(UIControlEvents)controlEvents;
-(void)SH_removeControlEventsForBlock:(SHControlEventBlock)theBlock;
-(void)SH_removeAllControlEventsBlocks;


```

### Helpers and Properties

```objective-c
#pragma mark -
#pragma mark Helpers
-(NSSet *)SH_blocksForControlEvents:(UIControlEvents)theControlEvents;
-(NSSet *)SH_controlEventsForBlock:(SHControlEventBlock)theBlock;


#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Getters
@property(nonatomic,readonly) BOOL SH_isTouchUpInsideEnabled;

@property(nonatomic,readonly) NSDictionary * SH_controlBlocks;

```

Usage
-----

### Creating

With SHControlBlocks you can set auto-removed blocks instead of using selectors

```objective-c
  [self.btnFirst SH_addControlEvents:UIControlEventTouchDown withBlock:^(UIControl *sender) {
    [weakSelf performSegueWithIdentifier:@"second" sender:nil];
    NSLog(@"first");
  }];
``` 

or if you want add additional blocks

```objective-c
  [btnSecond SH_addControlEvents:UIControlEventTouchUpInside withBlock:counterBlock];
  [btnSecond SH_addControlEvents:UIControlEventTouchDown withBlock:counterBlock];
```

Convenience selector for touchUpInside

```objective-c
  [button SH_addControlEventTouchUpInsideWithBlock:^(UIControl *sender) {
    [button removeFromSuperview]; //this will also remove the block :)
  }];
```

### Removing


#### Remove specific blocks - will also remove the Event from the target if it was the last block

```objective-c
  [btnSecond SH_removeControlEventsForBlock:counterBlock];
```

#### Remove specific events

```objective-c
  [btnSecond SH_removeBlocksForControlEvents:UIControlEventTouchUpInside];
  [btnSecond SH_removeControlEventTouchUpInside];
```

#### Remove all blocks and events

```objective-c
  [button SH_removeAllControlEventsBlocks];
```


### Helpers and Properties
------ 

```objective-c
  [button SH_addControlEventTouchUpInsideWithBlock:blockOne];
  [button SH_addControlEventTouchUpInsideWithBlock:blockTwo];
  [button SH_addControlEventTouchUpInsideWithBlock:blockThree];

  NSSet * controlBlocks = button.SH_controlBlocks[@(UIControlEventTouchUpInside)];  
  NSAssert(button.SH_isTouchUpInsideEnabled,    @"Touch up inside should be enabled");
  NSAssert(button.SH_controlBlocks.count  == 1, @"There should be one event");
  NSAssert(controlBlocks.count            == 3, @"There should be three blocks");

```



Contact
-------

If you end up using SHControlBlocks in a project, I'd love to hear about it.

email: [seivan.heidari@icloud.com](mailto:seivan.heidari@icloud.com)  
twitter: [@seivanheidari](https://twitter.com/seivanheidari)

## License

SHControlBlocks is © 2013 [Seivan](http://www.github.com/seivan) and may be freely
distributed under the [MIT license](http://opensource.org/licenses/MIT).
See the [`LICENSE.md`](https://github.com/seivan/SHControlBlocks/blob/master/LICENSE.md) file.
