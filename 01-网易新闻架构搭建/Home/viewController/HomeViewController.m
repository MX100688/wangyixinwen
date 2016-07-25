//
//  HomeViewController.m
//  01-网易新闻架构搭建
//
//  Created by 马旭 on 16/7/19.
//  Copyright © 2016年 马旭. All rights reserved.
//

#import "HomeViewController.h"
#import "ChannelModel.h"

#import "channelLab.h"
#import "HomeCollectionViewCell.h"
@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *ChannelScrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *NewsCollectionView;

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *FlowLayout;
@property (strong,nonatomic) NSArray *dataArr;
//标签数组
@property (strong,nonatomic) NSMutableArray *labM;
@end

@implementation HomeViewController
-(NSArray *)dataArr{
    if (_dataArr==nil) {
        _dataArr=[ChannelModel channels];
    }
    return _dataArr;
}
-(NSMutableArray *)labM{
    if (_labM==nil) {
        _labM=[NSMutableArray array];
    }
    return _labM;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.FlowLayout.itemSize=self.NewsCollectionView.bounds.size;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //NSLog(@"%@",[ChannelModel channels]);
    //sv跟nav同时使用的话,sv会往下偏移一定的距离,如果不想偏移的话,设置automaticallyAdjustsScrollViewInsets为no 也可以通过sb设置
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self creatChannelLab];
}

-(void)creatChannelLab{
    int LabW=80;
    int LabH=self.ChannelScrollView.bounds.size.height;
    for (int i=0; i<self.dataArr.count; i++) {
        channelLab *lab=[[channelLab alloc]init];
        lab.frame=CGRectMake(LabW * i, 0, LabW, LabH);
        ChannelModel *model=self.dataArr[i];
        lab.text=model.tname;
        lab.backgroundColor=[UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
        lab.tag=i;
        [self.ChannelScrollView addSubview:lab];
        self.ChannelScrollView.contentSize=CGSizeMake(LabW*self.dataArr.count, 0);
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        [lab addGestureRecognizer:tap];
        lab.userInteractionEnabled=YES;
        [self.labM addObject:lab];
    }
}
-(void)tapClick:(UITapGestureRecognizer *)tap{
//获取选中的lab
    channelLab *lab=(channelLab *)tap.view;
    // 计算选中的label剧中时,要滚动的偏移量
    CGFloat labelX=lab.center.x-self.view.bounds.size.width/2;
    // 限制最大和最小的偏移量
    CGFloat minOffsetX = 0;
    CGFloat maxOffsetX=self.ChannelScrollView.contentSize.width-self.view.bounds.size.width;
    if (labelX<minOffsetX) {
        labelX=0;
    }else if (labelX>maxOffsetX){
        labelX=maxOffsetX;
    }
    // 设置频道滚动视图的滚动
    [self.ChannelScrollView setContentOffset:CGPointMake(labelX, 0) animated:YES];
    #pragma mark - 点击频道标签居中时,collectionView也跟着联动
    NSIndexPath *indexPath=[NSIndexPath indexPathForItem:lab.tag inSection:0];
    [self.NewsCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:YES];
    
}

#pragma mark - 监听底部conllectionView的滚动 : 滚动结束的代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index=scrollView.contentOffset.x/scrollView.bounds.size.width;
    channelLab *lab=self.labM[index];
    CGFloat labelX1=lab.center.x-self.view.bounds.size.width/2;
    // 限制最大和最小的偏移量
    CGFloat minOffsetX = 0;
    CGFloat maxOffsetX=self.ChannelScrollView.contentSize.width-self.view.bounds.size.width;
    if (labelX1<minOffsetX) {
        labelX1=0;
    }else if (labelX1>maxOffsetX){
        labelX1=maxOffsetX;
    }
    // 设置频道滚动视图的滚动
    [self.ChannelScrollView setContentOffset:CGPointMake(labelX1, 0) animated:YES];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    ChannelModel *model=self.dataArr[indexPath.item];
    //NSLog(@"model.tid%@",model.tid);
    NSString *str=[NSString stringWithFormat:@"article/list/%@/0-20.html",model.tid];
    cell.urlstr=str;
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
