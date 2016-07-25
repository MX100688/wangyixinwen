//
//  CycleModel.h
//  01-网易新闻架构搭建
//
//  Created by 马旭 on 16/7/21.
//  Copyright © 2016年 马旭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CycleModel : NSObject
///轮播图标题
@property (nonatomic, copy) NSString *title;
///轮播图片
@property (nonatomic, copy) NSString *imgsrc;

+(void)loadCycleDataWithUrlstr:(NSString *)urlstr successBlock:(void(^)(NSArray *arr))successBlock failBlock:(void(^)(NSError *error))failBlock;
@end
