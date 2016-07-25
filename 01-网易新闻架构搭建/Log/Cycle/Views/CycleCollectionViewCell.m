//
//  CycleCollectionViewCell.m
//  01-网易新闻架构搭建
//
//  Created by 马旭 on 16/7/22.
//  Copyright © 2016年 马旭. All rights reserved.
//

#import "CycleCollectionViewCell.h"
#import <UIImageView+WebCache.h>
@interface CycleCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end
@implementation CycleCollectionViewCell
-(void)setModel:(CycleModel *)model{
    _model=model;
    [self.picture sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
    self.titleLab.text=model.title;
    
}
@end
