//
//  LSAHTTPConst.h
//  Management
//
//  Created by 杜Arlen on 2018/9/29.
//  Copyright © 2018年 杜Arlen. All rights reserved.
//

#ifndef LSAHTTPConst_h
#define LSAHTTPConst_h

#import <AFNetworking/AFNetworking.h>

@class LSAHTTPRequestModel;
@class LSAHTTPResponModel;

//请求时的进度
typedef void(^LSAHttpProgressBlock)(NSProgress *progress);
//请求时上传的数据
typedef void(^LSAHTTPConstructingBodyBlock)(id<AFMultipartFormData> formData);
//请求的结果
typedef void(^LSAHttpResultBlock)(LSAHTTPResponModel *respon);

//请求方式
typedef enum : NSUInteger {
    LSAHttpRequestMethodPost,
    LSAHttpRequestMethodGet,
    LSAHttpRequestMethodHeader,
    LSAHttpRequestMethodPut,
    LSAHttpRequestMethodPatch,
    LSAHttpRequestMethodDelete,
} LSAHttpRequestMethod;

//请求类型
typedef enum : NSUInteger {
    LSAHttpTypeDefault,
    LSAHttpTypeHttps,
} LSAHttpType;

typedef enum : NSUInteger {
    LSAHTTPRequestSerializerTypeDefault,
    LSAHTTPRequestSerializerTypeJson,
    LSAHTTPRequestSerializerTypePropertyList,
} LSAHTTPRequestSerializerType;

#endif /* LSAHTTPConst_h */
