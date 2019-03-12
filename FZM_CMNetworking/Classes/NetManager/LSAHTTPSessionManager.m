//
//  LSAHTTPSessionManager.m
//  Management
//
//  Created by 杜Arlen on 2018/9/28.
//  Copyright © 2018年 杜Arlen. All rights reserved.
//

#import "LSAHTTPSessionManager.h"

typedef void(^LSANetSuccessBlock)(NSURLSessionDataTask *task, id responseObject);
typedef void(^LSANetFailedBlock)(NSURLSessionDataTask *task, NSError *error);

@interface LSAHTTPSessionManager ()

@property (nonatomic, strong) LSAHTTPRequestModel *requestModel;

@end

@implementation LSAHTTPSessionManager


+ (NSURLSessionDataTask *)taskWithRequestModel:(__kindof LSAHTTPRequestModel *)model finish:(LSAHttpResultBlock)finish {
    return [self taskWithRequestModel:model constructingBodyWithBlock:nil progress:nil finish:finish];
}

+ (NSURLSessionDataTask *)taskWithRequestModel:(__kindof LSAHTTPRequestModel *)model
                     constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                        finish:(LSAHttpResultBlock)finish {
    return [self taskWithRequestModel:model constructingBodyWithBlock:block progress:nil finish:finish];
}

+ (NSURLSessionDataTask *)taskWithRequestModel:(__kindof LSAHTTPRequestModel *)model
                                      progress:(nullable void (^)(NSProgress * _Nonnull))progress
                                        finish:(LSAHttpResultBlock)finish {
    return [self taskWithRequestModel:model constructingBodyWithBlock:nil progress:progress finish:finish];
}

+ (NSURLSessionDataTask *)taskWithRequestModel:(__kindof LSAHTTPRequestModel *)model
                     constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                      progress:(nullable void (^)(NSProgress * _Nonnull))progress
                                        finish:(LSAHttpResultBlock)finish {
    
    //请求成功
    LSANetSuccessBlock success = ^(NSURLSessionDataTask *task, id responseObject) {
        LSAHTTPResponModel *respon = [[LSAHTTPResponModel alloc] init];
        respon.success = YES;
        respon.task = task;
        respon.responseObject = responseObject;
        finish(respon);
    };
    //请求失败
    LSANetFailedBlock failed = ^(NSURLSessionDataTask *task, NSError *error) {
        LSAHTTPResponModel *respon = [[LSAHTTPResponModel alloc] init];
        respon.success = NO;
        respon.task = task;
        respon.error = error;
        finish(respon);
    };
    
    NSURL *baseURL = [NSURL URLWithString:model.requestBaseURL];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager manager] initWithBaseURL:baseURL];;
    
    //设置请求方式
    if (model.requestSerializerType == LSAHTTPRequestSerializerTypeJson) {
        manager.requestSerializer = [[AFJSONRequestSerializer alloc] init];
    } else if (model.requestSerializerType == LSAHTTPRequestSerializerTypePropertyList) {
        manager.requestSerializer = [[AFPropertyListRequestSerializer alloc] init];
    }
    
    //添加所有的请求头
    [model.allHTTPHeaderFields enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    
    manager.requestSerializer.timeoutInterval = model.timeoutInterval;
    
    //设置响应数据内容格式
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/xml",@"text/html",@"text/plain", nil];
    
    //设置https证书
    if (model.securityPolicy) {
        manager.securityPolicy = model.securityPolicy;
    }
    
    
    //开始请求
    LSAHttpRequestMethod method = model.requestMethod;
    NSString *url = model.requestAbsoluteURL;
    id parameters = model.param;
    if (method == LSAHttpRequestMethodGet)
    {
        return [manager GET:url parameters:parameters progress:progress success:success failure:failed];
    }
    else if (method == LSAHttpRequestMethodPost)
    {
        if (block)
        {
            return [manager POST:url parameters:parameters constructingBodyWithBlock:block progress:progress success:success failure:failed];
        }
        else
        {
            return [manager POST:url parameters:parameters progress:progress success:success failure:failed];
        }
    }
    else if (method == LSAHttpRequestMethodHeader)
    {
        return [manager HEAD:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task) {
            success(task,nil);
        } failure:failed];
    }
    else if (method == LSAHttpRequestMethodPut)
    {
        return [manager PUT:url parameters:parameters success:success failure:failed];
    }
    else if (method == LSAHttpRequestMethodPatch)
    {
        return [manager PATCH:url parameters:parameters success:success failure:failed];
    }
    else if (method == LSAHttpRequestMethodDelete)
    {
        return [manager DELETE:url parameters:parameters success:success failure:failed];
    }
    return nil;
    
}



@end
