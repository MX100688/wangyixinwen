//
//  CycleModel.m
//  01-网易新闻架构搭建
//
//  Created by 马旭 on 16/7/21.
//  Copyright © 2016年 马旭. All rights reserved.
//

#import "CycleModel.h"
#import "NetworlTool.h"
@implementation CycleModel
+(instancetype)CycleModelWithDict:(NSDictionary *)dict{
    CycleModel *model=[[CycleModel alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

}
+(void)loadCycleDataWithUrlstr:(NSString *)urlstr successBlock:(void(^)(NSArray *listArr))successBlock failBlock:(void (^)(NSError *error))failBlock
{
    [[NetworlTool sharedNetworlTool]GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        //NSLog(@"%@",responseObject);
        NSString *key=responseObject.keyEnumerator.nextObject;
        NSArray *arr=[responseObject objectForKey:key];
        NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:arr.count];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CycleModel *model=[self CycleModelWithDict:obj];
            [arrM addObject:model];
        }];
        if (successBlock) {
            successBlock(arrM.copy);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failBlock) {
            failBlock(error);
        }
    }];
}
@end
