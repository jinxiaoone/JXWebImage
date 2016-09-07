//
//  JXWebImageCache.h
//  JXWebImage
//
//  Created by jinxiao on 9/7/16.
//  Copyright © 2016 JX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JXWebImageCache : NSObject

@property (nonatomic,copy) void(^downloadCallback)(UIImage *);

+(id)sharedInstance;

-(BOOL)isImageExist:(NSURL *)url;

-(UIImage *)imageWithURL:(NSURL *)url;

-(void)saveImage:(UIImage *)img withURL:(NSURL *)url;

-(void)downloadImageWithURL:(NSURL *)url complete:(void(^)(UIImage *image))block;

@end
