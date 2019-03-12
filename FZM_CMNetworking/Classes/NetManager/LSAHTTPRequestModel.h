//
//  LSAHTTPRequestModel.h
//  Management
//
//  Created by 杜Arlen on 2018/9/28.
//  Copyright © 2018年 杜Arlen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSAHTTPConst.h"

@interface LSAHTTPRequestModel : NSObject

+ (instancetype)requestModel;

//http类型
@property (nonatomic, assign) LSAHttpType httpType;
//请求方式
@property (nonatomic, assign) LSAHttpRequestMethod requestMethod;
//请求存储器类型
@property (nonatomic, assign) LSAHTTPRequestSerializerType requestSerializerType;
//请求baseURL
@property (nonatomic, strong) NSString *requestBaseURL;
//请求路径
@property (nonatomic, strong) NSString *requestAbsoluteURL;
//请求超时时间
@property (nonatomic, assign) NSTimeInterval timeoutInterval;
//请求参数
@property (nonatomic, strong) id param;
//请求头的数据
@property (nonatomic, strong, readonly) NSMutableDictionary *allHTTPHeaderFields;
//设置请求的证书
@property (nonatomic, strong) AFSecurityPolicy *securityPolicy;



@end
