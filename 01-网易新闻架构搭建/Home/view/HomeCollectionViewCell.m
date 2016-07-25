//
//  HomeCollectionViewCell.m
//  01-网易新闻架构搭建
//
//  Created by 马旭 on 16/7/19.
//  Copyright © 2016年 马旭. All rights reserved.
//

#import "HomeCollectionViewCell.h"
#import "NewsTableViewController.h"
@interface HomeCollectionViewCell()
@property (nonatomic, strong)NewsTableViewController *newsVC;
@end
@implementation HomeCollectionViewCell

-(void)awakeFromNib{
//self.backgroundColor=[UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"News" bundle:nil];
    self.newsVC=[storyboard instantiateInitialViewController];
    self.newsVC.tableView.frame=self.contentView.bounds;
    self.newsVC.tableView.backgroundColor=[UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
    [self addSubview:self.newsVC.tableView];
    
    
}
-(void)setUrlstr:(NSString *)urlstr{
    _urlstr=urlstr;
    self.newsVC.urlstr=urlstr;
}
@end
