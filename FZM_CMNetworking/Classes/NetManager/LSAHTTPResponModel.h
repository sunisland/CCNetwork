//
//  LSAHTTPResponModel.h
//  Management
//
//  Created by 杜Arlen on 2018/9/28.
//  Copyright © 2018年 杜Arlen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSAHTTPConst.h"


@interface LSAHTTPResponModel : NSObject

@property (nonatomic, assign) BOOL success;
@property (nonatomic, strong) NSURLSessionDataTask *task;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) id responseObject;

@end

