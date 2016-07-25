//
//  NetworlTool.m
//  01-网易新闻架构搭建
//
//  Created by 马旭 on 16/7/21.
//  Copyright © 2016年 马旭. All rights reserved.
//

#import "NetworlTool.h"
#import <AFNetworking.h>
@implementation NetworlTool
static id _instancetype;
+(instancetype)sharedNetworlTool{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *url=[NSURL URLWithString:@"http://c.m.163.com/nc/"];
        _instancetype=[[self alloc]initWithBaseURL:url];
    });
    return _instancetype;
    
}
@end
