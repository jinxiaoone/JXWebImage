//
//  HTTPRequestManager.h
//  JXWebImage
//
//  Created by jinxiao on 9/7/16.
//  Copyright © 2016 JX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPRequestManager : NSObject

+(id)manager;

-(void)download:(NSString *)url withComplete:(void(^)(BOOL success, NSData *data))callback;

@end
