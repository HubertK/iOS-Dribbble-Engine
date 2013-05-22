//
//  HKConnection.m
//  RestConnection
//
//  Created by Hubert Kunnemeyer on 4/26/12.
//

#import "HKConnection.h"

@implementation HKConnection
@synthesize callBackBlock,requestdata;

- (id)initWithCallbackBlock:(HKConnectionBlock)block{
     self = [super init];
    if (!self) {
        return nil;
    }

    self.callBackBlock = block;
    self.requestdata = [NSMutableData data];
    

    return self;
}
- (id)initWithURL:(NSURL *)URL callback:(HKConnectionBlock)block{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.callBackBlock = block;
    
    [self sendRequest:URL];
    return self;
}


- (void)sendRequest:(NSURL*)URL{
    self.requestdata = [NSMutableData data];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    [connection start];

}

#pragma -mark
#pragma mark NSURLConnection
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.requestdata appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    self.callBackBlock(self.requestdata,nil);



}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{

     NSLog(@"ERROR Desription:%@\nREASON:%@\nRECOVERY SUGGESTION:%@",[error localizedDescription],[error localizedFailureReason],[error localizedRecoverySuggestion]);
        self.callBackBlock(nil,error);

   

}













@end
