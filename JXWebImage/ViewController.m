//
//  ViewController.m
//  JXWebImage
//
//  Created by jinxiao on 9/7/16.
//  Copyright © 2016 JX. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+JXWebImage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(10, 50, 300, 150)];
    [self.view addSubview:imgv];
    
    __unsafe_unretained UIImageView *weakImagev = imgv;
    [imgv setImageWithURL:[NSURL URLWithString:@"http://image16-c.poco.cn/mypoco/myphoto/20140605/18/17457026820140605181136033_640.jpg?570x300_120"] withPlaceHolder:nil
                competion:^(UIImage *image) {
                    weakImagev.image = image;
                }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
