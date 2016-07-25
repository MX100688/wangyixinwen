//
//  NewsModel.m
//  01-网易新闻架构搭建
//
//  Created by 马旭 on 16/7/21.
//  Copyright © 2016年 马旭. All rights reserved.
//

#import "NewsModel.h"
#import "NetworlTool.h"
@implementation NewsModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

}
+(instancetype)NewsModelWithDict:(NSDictionary *)dict{
    NewsModel *model=[[NewsModel alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
+(void)downloadWithUrlstr:(NSString *)urlstr successBlock:(void(^)(NSArray *arr))successBlock failureBlock:(void(^)(NSError *error))failureBlock{
    NSLog(@"NewsModel  %@",urlstr);
    [[NetworlTool sharedNetworlTool]GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"responseObject%@",responseObject);
        NSDictionary *dict=responseObject;
        NSString *key=dict.keyEnumerator.nextObject;
        NSArray *arr=[dict objectForKey:key];
        NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:arr.count];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NewsModel *model=[self NewsModelWithDict:obj];
            [arrM addObject:model];
        }];
        if (successBlock) {
            successBlock(arrM.copy);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //NSLog(@"error%@",error);
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}
@end
