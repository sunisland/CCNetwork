//
//  LSAHTTPSessionManager.h
//  Management
//
//  Created by 杜Arlen on 2018/9/28.
//  Copyright © 2018年 杜Arlen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "LSAHTTPConst.h"
#import "LSAHTTPRequestModel.h"
#import "LSAHTTPResponModel.h"

@interface LSAHTTPSessionManager : AFHTTPSessionManager

+ (NSURLSessionDataTask *)taskWithRequestModel:(__kindof LSAHTTPRequestModel *)model
                                        finish:(LSAHttpResultBlock)finish;

+ (NSURLSessionDataTask *)taskWithRequestModel:(__kindof LSAHTTPRequestModel *)model
                     constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                        finish:(LSAHttpResultBlock)finish;

+ (NSURLSessionDataTask *)taskWithRequestModel:(__kindof LSAHTTPRequestModel *)model
                                      progress:(nullable void (^)(NSProgress * progress))progress
                                        finish:(LSAHttpResultBlock)finish;

+ (NSURLSessionDataTask *)taskWithRequestModel:(__kindof LSAHTTPRequestModel *)model
                     constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                      progress:(nullable void (^)(NSProgress * progress))progress
                                        finish:(LSAHttpResultBlock)finish;


@end


