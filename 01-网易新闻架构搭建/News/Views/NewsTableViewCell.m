//
//  NewsTableViewCell.m
//  01-网易新闻架构搭建
//
//  Created by 马旭 on 16/7/21.
//  Copyright © 2016年 马旭. All rights reserved.
//

#import "NewsTableViewCell.h"
#import <UIImageView+WebCache.h>
@interface NewsTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *picture;

@property (weak, nonatomic) IBOutlet UILabel *TitleLab;
@property (weak, nonatomic) IBOutlet UILabel *sourceLab;
@property (weak, nonatomic) IBOutlet UILabel *replyLab;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *pictures;
@end
@implementation NewsTableViewCell
-(void)setModel:(NewsModel *)model{
    _model=model;
    [self.picture sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
    self.TitleLab.text = model.title;
    self.sourceLab.text = model.source;
    self.replyLab.text = [NSString stringWithFormat:@"%@",model.replyCount] ;
    for (int i=0; i<model.imgextra.count; i++) {
        UIImageView *img=self.pictures[i];
        NSDictionary *dict=model.imgextra[i];
        NSString *str=[dict objectForKey:@"imgsrc"];
        [img sd_setImageWithURL:[NSURL URLWithString:str]];
        
    }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
