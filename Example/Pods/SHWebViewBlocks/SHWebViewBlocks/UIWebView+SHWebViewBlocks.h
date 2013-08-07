
#pragma mark -
#pragma mark Block Def
typedef void (^SHWebViewBlock)(UIWebView * theWebView);

typedef void (^SHWebViewBlockWithError)(UIWebView * theWebView, NSError * theError);

typedef BOOL (^SHWebViewBlockWithRequest)(UIWebView * theWebView, NSURLRequest * theRequest,UIWebViewNavigationType theNavigationType);

@interface UIWebView (SHWebViewBlocks)

#pragma mark -
#pragma mark Helpers
-(void)SH_loadRequestWithString:(NSString *)theString;

#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Setters


-(void)SH_setShouldStartLoadWithRequestBlock:(SHWebViewBlockWithRequest)theBlock;

-(void)SH_setDidStartLoadBlock:(SHWebViewBlock)theBlock;

-(void)SH_setDidFinishLoadBlock:(SHWebViewBlock)theBlock;

-(void)SH_setDidFailLoadWithErrorBlock:(SHWebViewBlockWithError)theBlock;




#pragma mark -
#pragma mark Getters

@property(nonatomic,readonly) SHWebViewBlockWithRequest SH_blockShouldStartLoadingWithRequest;

@property(nonatomic,readonly) SHWebViewBlock SH_blockDidStartLoad;

@property(nonatomic,readonly) SHWebViewBlock SH_blockDidFinishLoad;

@property(nonatomic,readonly) SHWebViewBlockWithError SH_blockDidFailLoadWithError;

@end