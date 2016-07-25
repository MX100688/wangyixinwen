//
//  NewsTableViewController.h
//  01-网易新闻架构搭建
//
//  Created by 马旭 on 16/7/21.
//  Copyright © 2016年 马旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewController : UITableViewController
//接收HomeCollectionViewCell传递过的数据
@property (copy,nonatomic) NSString *urlstr;
@end
