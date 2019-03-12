//
//  LSANetworkRechabilityTool.h
//  FZMNetTool_Example
//
//  Created by 杜Arlen on 2018/8/7.
//  Copyright © 2018年 杜Arlen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    FZMNetStatusNotRechable,    //没有网络
    FZMNetStatusUnknown,        //未知网络
    FZMNetStatusViaWifi,        //wifi网络
    FZMNetStatusViaWWAN,        //手机自带网络
} FZMNetStatus;

typedef enum : NSUInteger {
    FZMNetDetailStatusNotRechable,  //没有网络
    FZMNetDetailStatusUnknown,      //未知网络
    FZMNetDetailStatusViaWifi,      //wifi网络
    FZMNetDetailStatusViaWWAN2G,    //手机2G网络
    FZMNetDetailStatusViaWWAN3G,    //手机3G网络
    FZMNetDetailStatusViaWWAN4G,    //手机4G网络
} FZMNetDetailStatus;


@interface LSANetworkRechabilityTool : NSObject

//创建单例类，进行监听网络变化
+ (instancetype)shareInstance;

//开始检测
+ (void)startMonitoring;

//停止检测
+ (void)stoptMonitoring;

//网络状态
@property (nonatomic, assign) FZMNetStatus status;

//网络详细状态
@property (nonatomic, assign) FZMNetDetailStatus detailStatus;

//开始检测
- (void)startMonitoring;

//停止检测
- (void)stoptMonitoring;

@end
