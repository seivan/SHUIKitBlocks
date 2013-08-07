
#import "UIWebView+SHWebViewBlocks.h"

static NSString * const SH_blockShouldStartLoadingWithRequest = @"SH_blockShouldStartLoadingWithRequest";
static NSString * const SH_blockDidStartLoad = @"SH_blockDidStartLoad";
static NSString * const SH_blockDidFinishLoad = @"SH_blockDidFinishLoad";
static NSString * const SH_blockDidFailLoadWithError = @"SH_blockDidFailLoadWithError";

@protocol SHWebViewDelegate <NSObject>
@required
+(void)setDelegateForWebView:(UIWebView *)theWebView;
@end


@interface SHWebViewBlockManager : NSObject
<UIWebViewDelegate>

@property(nonatomic,strong)   NSMapTable   * mapBlocks;
+(instancetype)sharedManager;
-(void)SH_memoryDebugger;

#pragma mark -
#pragma mark Class selectors

#pragma mark -
#pragma mark Setter
+(void)setDelegateForWebView:(UIWebView *)theWebView;

+(void)setBlock:(id)theBlock
  forWebView:(UIWebView *)theWebView
        withKey:(NSString *)theKey;

#pragma mark -
#pragma mark Getter
+(id)blockForWebView:(UIWebView *)theWebView withKey:(NSString *)theKey;

@end

@implementation SHWebViewBlockManager

#pragma mark -
#pragma mark Init & Dealloc
-(instancetype)init; {
  self = [super init];
  if (self) {
    self.mapBlocks            = [NSMapTable weakToStrongObjectsMapTable];
//    [self SH_memoryDebugger];
  }
  
  return self;
}

+(instancetype)sharedManager; {
  static SHWebViewBlockManager * _sharedInstance;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedInstance = [[SHWebViewBlockManager alloc] init];
    
  });
  
  return _sharedInstance;
  
}


#pragma mark -
#pragma mark Debugger
-(void)SH_memoryDebugger; {
  double delayInSeconds = 2.0;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    NSLog(@"MAP %@",self.mapBlocks);
    [self SH_memoryDebugger];
  });
}

#pragma mark -
#pragma mark Class selectors

#pragma mark -
#pragma mark Setter
+(void)setDelegateForWebView:(UIWebView *)theWebView ;{
  [theWebView setDelegate:[SHWebViewBlockManager sharedManager]];
}

+(void)setBlock:(id)theBlock forWebView:(UIWebView *)theWebView withKey:(NSString *)theKey; {

  NSAssert(theWebView, @"Must pass theWebView");
  
  id block = [theBlock copy];
  
  SHWebViewBlockManager * manager = [SHWebViewBlockManager
                                                  sharedManager];
  NSMutableDictionary * map = [manager.mapBlocks objectForKey:theWebView];
  if(map == nil) {
    map = [@{} mutableCopy];
    [manager.mapBlocks setObject:map forKey:theWebView];
  }
  if(block == nil) {
    [map removeObjectForKey:theKey];
    if(map.count == 0) [manager.mapBlocks removeObjectForKey:theWebView];
  }
  
  else map[theKey] = block;
      
}

#pragma mark -
#pragma mark Getter
+(id)blockForWebView:(UIWebView *)theWebView withKey:(NSString *)theKey; {
  NSAssert(theWebView, @"Must pass theWebView to fetch blocks for");
  return [[[SHWebViewBlockManager sharedManager].mapBlocks
          objectForKey:theWebView] objectForKey:theKey];
}

#pragma mark -
#pragma mark Delegates


#pragma mark -
#pragma mark <UIWebViewDelegate>
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType; {
  BOOL shouldStartLoadWithRequest = YES;
  SHWebViewBlockWithRequest block = [webView SH_blockShouldStartLoadingWithRequest];
  if(block) shouldStartLoadWithRequest =  block(webView, request, navigationType);
  return shouldStartLoadWithRequest;
}

-(void)webViewDidStartLoad:(UIWebView *)webView; {
  SHWebViewBlock block = [webView SH_blockDidStartLoad];
  if(block) block(webView);
  
}

-(void)webViewDidFinishLoad:(UIWebView *)webView; {
  SHWebViewBlock block = [webView SH_blockDidFinishLoad];
  if(block) block(webView);
  
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error; {
  SHWebViewBlockWithError block = [webView SH_blockDidFailLoadWithError];
  if(block) block(webView, error);
  
}



@end

@interface UIWebView (Private)
-(void)SH_setNavigationBlocks;
@end

@implementation UIWebView  (SHWebViewBlocks)

#pragma mark -
#pragma mark Private
-(void)SH_setNavigationBlocks; {
  [SHWebViewBlockManager setDelegateForWebView:self];
}

#pragma mark -
#pragma mark Helpers
-(void)SH_loadRequestWithString:(NSString *)theString; {
  NSAssert(theString, @"Must pass theString");
  [self loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:theString]]];
}


#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Setters

-(void)SH_setShouldStartLoadWithRequestBlock:(SHWebViewBlockWithRequest)theBlock; {
  [self SH_setNavigationBlocks];
  [SHWebViewBlockManager setBlock:theBlock forWebView:self withKey:SH_blockShouldStartLoadingWithRequest];
}

-(void)SH_setDidStartLoadBlock:(SHWebViewBlock)theBlock; {
  [self SH_setNavigationBlocks];
  [SHWebViewBlockManager setBlock:theBlock forWebView:self withKey:SH_blockDidStartLoad];
  
}

-(void)SH_setDidFinishLoadBlock:(SHWebViewBlock)theBlock; {
  [self SH_setNavigationBlocks];
  [SHWebViewBlockManager setBlock:theBlock forWebView:self withKey:SH_blockDidFinishLoad];
  
}

-(void)SH_setDidFailLoadWithErrorBlock:(SHWebViewBlockWithError)theBlock; {
  [self SH_setNavigationBlocks];
  [SHWebViewBlockManager setBlock:theBlock forWebView:self withKey:SH_blockDidFailLoadWithError];
  
}



#pragma mark -
#pragma mark Getters

-(SHWebViewBlockWithRequest)SH_blockShouldStartLoadingWithRequest; {
  return [SHWebViewBlockManager blockForWebView:self withKey:SH_blockShouldStartLoadingWithRequest];
}

-(SHWebViewBlock)SH_blockDidStartLoad; {
  return [SHWebViewBlockManager blockForWebView:self withKey:SH_blockDidStartLoad];
}

-(SHWebViewBlock)SH_blockDidFinishLoad; {
  return [SHWebViewBlockManager blockForWebView:self withKey:SH_blockDidFinishLoad];
}

-(SHWebViewBlockWithError)SH_blockDidFailLoadWithError; {
  return [SHWebViewBlockManager blockForWebView:self withKey:SH_blockDidFailLoadWithError]; 
}


@end