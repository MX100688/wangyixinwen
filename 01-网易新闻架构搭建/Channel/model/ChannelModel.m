//
//  ChannelModel.m
//  01-网易新闻架构搭建
//
//  Created by 马旭 on 16/7/19.
//  Copyright © 2016年 马旭. All rights reserved.
//

#import "ChannelModel.h"

@implementation ChannelModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

}
-(NSString *)description{
    return [NSString stringWithFormat:@"%@ %@",_tname,_tid];
}
+(instancetype)channelWithDict:(NSDictionary *)dict{
    ChannelModel *model=[[ChannelModel alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
+(NSArray *)channels{
    NSString *path=[[NSBundle mainBundle]pathForResource:@"topic_news.json" ofType:nil];
    NSData *data=[NSData dataWithContentsOfFile:path];
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSArray *arr=[dict objectForKey:@"tList"];
    NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:arr.count];
    [arr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ChannelModel *model=[self channelWithDict:obj];
        [arrM addObject:model];
    }];
    //排序
    [arrM sortUsingComparator:^NSComparisonResult(ChannelModel *obj1,ChannelModel *obj2) {
        return [obj1.tid compare:obj2.tid];
    }];
    return arrM.copy;
}
@end
