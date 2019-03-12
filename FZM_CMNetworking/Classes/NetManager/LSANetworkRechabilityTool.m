//
//  LSANetworkRechabilityTool.m
//  FZMNetTool_Example
//
//  Created by 杜Arlen on 2018/8/7.
//  Copyright © 2018年 杜Arlen. All rights reserved.
//

#import "LSANetworkRechabilityTool.h"
#import <AFNetworking/AFNetworkReachabilityManager.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@interface LSANetworkRechabilityTool ()
@property (nonatomic, strong) CTTelephonyNetworkInfo *telephonyInfo;
@end


@implementation LSANetworkRechabilityTool

+ (instancetype)shareInstance
{
    static LSANetworkRechabilityTool *__tool = nil;
    if (__tool == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            __tool = [[LSANetworkRechabilityTool alloc] init];
            __tool.status = 100;
            __tool.detailStatus = 100;
        });
    }
    return __tool;
}

//开始检测
+ (void)startMonitoring
{
    [[LSANetworkRechabilityTool shareInstance] startMonitoring];
}

//停止检测
+ (void)stoptMonitoring
{
    [[LSANetworkRechabilityTool shareInstance] stoptMonitoring];
}


- (void)startMonitoring
{
    AFNetworkReachabilityManager *mannager = [AFNetworkReachabilityManager sharedManager];
    [mannager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        NSLog(@"网络变化结果");
        
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable: {
                self.detailStatus = FZMNetDetailStatusNotRechable;
                self.status = FZMNetStatusNotRechable;
            }
                break;
            case AFNetworkReachabilityStatusUnknown: {
                self.detailStatus = FZMNetDetailStatusUnknown;
                self.status = FZMNetStatusUnknown;
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: {
                self.detailStatus = FZMNetDetailStatusViaWifi;
                self.status = FZMNetStatusViaWifi;
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: {
                self.status = FZMNetStatusViaWWAN;
                
                self.telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
                NSString *currentStatus = self.telephonyInfo.currentRadioAccessTechnology;
                if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyGPRS"]){
                    //GPRS网络
                    self.detailStatus = FZMNetDetailStatusViaWWAN2G;
                    
                } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyEdge"]) {
                    //2.75G的EDGE网络
                    self.detailStatus = FZMNetDetailStatusViaWWAN2G;
                    
                } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyWCDMA"]){
                    //3G WCDMA网络
                    self.detailStatus = FZMNetDetailStatusViaWWAN3G;
                    
                } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSDPA"]){
                    //3.5G网络
                    self.detailStatus = FZMNetDetailStatusViaWWAN3G;
                    
                } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSUPA"]){
                    //3.5G网络
                    self.detailStatus = FZMNetDetailStatusViaWWAN3G;
                    
                } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMA1x"]){
                    //CDMA2G网络
                    self.detailStatus = FZMNetDetailStatusViaWWAN2G;

                }
                else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORev0"]){
                    //CDMA的EVDORev0(应该算3G吧?)
                    self.detailStatus = FZMNetDetailStatusViaWWAN3G;
                } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevA"]){
                    //CDMA的EVDORevA(应该也算3G吧?)
                    self.detailStatus = FZMNetDetailStatusViaWWAN3G;
                    
                } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevB"]){
                    //CDMA的EVDORev0(应该是算3G吧?)
                    self.detailStatus = FZMNetDetailStatusViaWWAN3G;
                    
                }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyLTE"]){
                    //LTE4G网络
                    self.detailStatus = FZMNetDetailStatusViaWWAN4G;

                }
                else {
                    //HRPD网络
                    self.detailStatus = FZMNetDetailStatusViaWWAN3G;
                }
            }
                break;
            default:
                break;
        }
    }];
    [mannager startMonitoring];
}

- (void)stoptMonitoring
{
    AFNetworkReachabilityManager *mannager = [AFNetworkReachabilityManager sharedManager];
    [mannager stopMonitoring];
}

@end




















