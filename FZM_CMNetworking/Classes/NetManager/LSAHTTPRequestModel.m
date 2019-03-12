//
//  LSAHTTPRequestModel.m
//  Management
//
//  Created by 杜Arlen on 2018/9/28.
//  Copyright © 2018年 杜Arlen. All rights reserved.
//

#import "LSAHTTPRequestModel.h"

@implementation LSAHTTPRequestModel

+ (instancetype)requestModel {
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _allHTTPHeaderFields = [NSMutableDictionary dictionary];
        _param = [NSMutableDictionary dictionary];
        _timeoutInterval = 60;
    }
    return self;
}

@end
