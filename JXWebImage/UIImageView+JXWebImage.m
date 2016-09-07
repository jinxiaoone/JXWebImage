//
//  UIImageView+JXWebImage.m
//  JXWebImage
//
//  Created by jinxiao on 9/7/16.
//  Copyright © 2016 JX. All rights reserved.
//

#import "UIImageView+JXWebImage.h"
#import "JXWebImageCache.h"

@implementation UIImageView (JXWebImage)

-(void)setImageWithURL:(NSURL *)url
{
    [self setImageWithURL:url withPlaceHolder:nil];
}

-(void)setImageWithURL:(NSURL *)url withPlaceHolder:(UIImage *)img
{
    [self setImageWithURL:url withPlaceHolder:img competion:nil];
}

-(void)setImageWithURL:(NSURL *)url withPlaceHolder:(UIImage *)img competion:(void(^)(UIImage *image))callback
{
    //先设置placeholder图片
    self.image = img;
    //下载图片
    
    //先从本地找url对应的图片
    BOOL exists = [[JXWebImageCache sharedInstance]isImageExist:url];
    
    //如果在本地存在对应的图片,直接将图片取出并设置到imageview上面
    if (exists) {
        if (callback) {
            callback([[JXWebImageCache sharedInstance]imageWithURL:url]);
        }
        else
        {
            self.image = [[JXWebImageCache sharedInstance]imageWithURL:url];
        }
    }
    //如果本地不存在,则下载并设置到imageview上面
    else
    {
        [[JXWebImageCache sharedInstance]downloadImageWithURL:url complete:^(UIImage *image) {
            if (callback) {
                callback(image);
            }
            else
            {
                self.image = image;
            }
            
            [[JXWebImageCache sharedInstance]saveImage:image withURL:url];
        }];
    }
    //将下载的图片缓存到本地
    
}

@end
