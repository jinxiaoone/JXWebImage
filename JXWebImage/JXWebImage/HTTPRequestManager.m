//
//  HTTPRequestManager.m
//  JXWebImage
//
//  Created by jinxiao on 9/7/16.
//  Copyright © 2016 JX. All rights reserved.
//

#import "HTTPRequestManager.h"
@interface HTTPRequest : NSObject

@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) void(^callback)(BOOL success, NSData *data);

-(void)startRequest;

@end

@implementation HTTPRequest
-(void)startRequest
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_url]];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error:%@",error);
        }
        _callback(YES,data);
    }];
    [task resume];
    
}
@end

@implementation HTTPRequestManager

+(id)manager
{
    static HTTPRequestManager *_m = nil;
    if (!_m) {
        _m = [[HTTPRequestManager alloc]init];
    }
    return _m;
}

-(void)download:(NSString *)url withComplete:(void(^)(BOOL success, NSData *data))callback
{
    HTTPRequest *req = [[HTTPRequest alloc]init];
    req.url = url;
    req.callback = callback;
    [req startRequest];
}

@end
