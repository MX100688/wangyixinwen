//
//  NetworlTool.h
//  01-网易新闻架构搭建
//
//  Created by 马旭 on 16/7/21.
//  Copyright © 2016年 马旭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
@interface NetworlTool : AFHTTPSessionManager
+(instancetype)sharedNetworlTool;
@end
