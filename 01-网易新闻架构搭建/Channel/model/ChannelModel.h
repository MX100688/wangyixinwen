//
//  ChannelModel.h
//  01-网易新闻架构搭建
//
//  Created by 马旭 on 16/7/19.
//  Copyright © 2016年 马旭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChannelModel : NSObject
@property (copy,nonatomic) NSString *tname;
@property (copy,nonatomic) NSString *tid;
+(NSArray *)channels;
@end
