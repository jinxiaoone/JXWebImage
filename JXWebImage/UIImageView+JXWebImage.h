//
//  UIImageView+JXWebImage.h
//  JXWebImage
//
//  Created by jinxiao on 9/7/16.
//  Copyright © 2016 JX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (JXWebImage)

-(void)setImageWithURL:(NSURL *)url;

-(void)setImageWithURL:(NSURL *)url withPlaceHolder:(UIImage *)img;

-(void)setImageWithURL:(NSURL *)url withPlaceHolder:(UIImage *)img competion:(void(^)(UIImage *image))callback;

@end
