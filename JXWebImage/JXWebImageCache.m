//
//  JXWebImageCache.m
//  JXWebImage
//
//  Created by jinxiao on 9/7/16.
//  Copyright © 2016 JX. All rights reserved.
//

#import "JXWebImageCache.h"
#import "NSString+MD5Addition.h"
#import "HTTPRequestManager.h"

@implementation JXWebImageCache
{
    NSString *_basePath;
    NSFileManager *_fileManager;
    
}

+(id)sharedInstance
{
    static JXWebImageCache *_c = nil;
    if (!_c) {
        _c = [[JXWebImageCache alloc]init];
    }
    return _c;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _basePath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"hhcache"];
        _fileManager = [NSFileManager defaultManager];
        if (![_fileManager fileExistsAtPath:_basePath]) {
            [_fileManager createDirectoryAtPath:_basePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }
    return self;
}

-(BOOL)isImageExist:(NSURL *)url
{
    return [_fileManager fileExistsAtPath:[self pathWithURL:url]];
}

-(UIImage *)imageWithURL:(NSURL *)url
{
    NSData *data = [NSData dataWithContentsOfFile:[self pathWithURL:url]];
    UIImage *img = [UIImage imageWithData:data];//png
    if (!img) {
        img = [UIImage imageWithData:data scale:1.0];//jpeg
    }
    return img;
}

-(void)saveImage:(UIImage *)img withURL:(NSURL *)url
{
    NSData *data = UIImageJPEGRepresentation(img, 1.0);
    if (!data) {
        data = UIImagePNGRepresentation(img);
    }
    [data writeToFile:[self pathWithURL:url] atomically:NO];
}

-(void)downloadImageWithURL:(NSURL *)url complete:(void(^)(UIImage *image))block
{
    _downloadCallback = block;
    [[HTTPRequestManager manager]download:url.description withComplete:^(BOOL success, NSData *data) {
        [self callback:data];
    }];
}

-(void)callback:(NSData *)data
{
    UIImage *img = [UIImage imageWithData:data];//png
    if (!img) {
        img = [UIImage imageWithData:data scale:1.0];//jpeg
    }
    _downloadCallback(img);
}

-(NSString *)pathWithURL:(NSURL *)url
{
    NSString *md5 = [url.description stringFromMD5];
    return [_basePath stringByAppendingPathComponent:md5];
}

@end
