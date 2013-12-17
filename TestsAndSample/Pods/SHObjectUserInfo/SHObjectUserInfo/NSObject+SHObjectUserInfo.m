//
//  UIViewController+SHSegueBlock.m
//  Example
//
//  Created by Seivan Heidari on 5/16/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "NSObject+SHObjectUserInfo.h"

@interface SHObjectUserInfoManager : NSObject


@property(nonatomic,strong) NSMapTable * mapUserInfo;

+(instancetype)sharedManager;

-(void)SH_memoryDebugger;
@end


@implementation SHObjectUserInfoManager
#pragma mark -
#pragma mark Init & Dealloc
-(instancetype)init; {
  self = [super init];
  if (self) {
    self.mapUserInfo    = [NSMapTable weakToStrongObjectsMapTable];
//    [self SH_memoryDebugger];
  }
  
  return self;
}

+(instancetype)sharedManager; {
  static SHObjectUserInfoManager *_sharedInstance;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedInstance = [[SHObjectUserInfoManager alloc] init];
    
  });
  
  return _sharedInstance;
  
}

#pragma mark -
#pragma mark Debugger
-(void)SH_memoryDebugger; {
  double delayInSeconds = 5.0;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    NSLog(@"USERINFO %@",self.mapUserInfo);
    [self SH_memoryDebugger];
  });
}

@end

@interface NSObject ()

@property(nonatomic,readonly) NSMapTable * mapUserInfo;

@end

@implementation NSObject (SHObjectUserInfo)

#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Getters

-(NSMutableDictionary *)SH_userInfo; {
  NSMutableDictionary * userInfo = [self.mapUserInfo objectForKey:self];
  if(userInfo == nil){
    userInfo = @{}.mutableCopy;
    self.SH_userInfo = userInfo;
  }
  return userInfo;
}

#pragma mark -
#pragma mark Setters

-(void)setSH_userInfo:(NSMutableDictionary *)userInfo; {
  if(userInfo)
    [self.mapUserInfo setObject:userInfo forKey:self];
  else
    [self.mapUserInfo removeObjectForKey:self];
}


#pragma mark -
#pragma mark Privates

#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Getters
-(NSMapTable *)mapUserInfo; {
  return SHObjectUserInfoManager.sharedManager.mapUserInfo;
}



@end
