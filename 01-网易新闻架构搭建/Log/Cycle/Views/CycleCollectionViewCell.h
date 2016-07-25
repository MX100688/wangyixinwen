//
//  CycleCollectionViewCell.h
//  01-网易新闻架构搭建
//
//  Created by 马旭 on 16/7/22.
//  Copyright © 2016年 马旭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CycleModel.h"
@interface CycleCollectionViewCell : UICollectionViewCell
@property (strong,nonatomic) CycleModel *model;
@end
