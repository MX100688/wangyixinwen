//
//  CycleCollectionViewController.m
//  01-网易新闻架构搭建
//
//  Created by 马旭 on 16/7/21.
//  Copyright © 2016年 马旭. All rights reserved.
//

#import "CycleCollectionViewController.h"
#import "CycleModel.h"
#import "CycleCollectionViewCell.h"
@interface CycleCollectionViewController ()
@property (strong,nonatomic) NSArray *dataArr;

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *FlowLayout;
@property (strong,nonatomic) UIPageControl *pageControl;
@end

@implementation CycleCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    [self loadCycleModelData];
    [self createPageControl];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.FlowLayout.itemSize=self.collectionView.bounds.size;
}
-(void)createPageControl{
    self.pageControl=[[UIPageControl alloc]init];
    self.pageControl.currentPageIndicatorTintColor=[UIColor redColor];
    self.pageControl.pageIndicatorTintColor=[UIColor whiteColor];
    [self.view addSubview:self.pageControl];
}
//下载数据
-(void)loadCycleModelData{
    [CycleModel loadCycleDataWithUrlstr:@"ad/headline/0-4.html" successBlock:^(NSArray *arr) {
        self.dataArr=arr;
        [self.collectionView reloadData];
        self.pageControl.numberOfPages=self.dataArr.count;
        //获取pageControl的size
        CGSize pageControlSize=[self.pageControl sizeForNumberOfPages:self.dataArr.count];
        //pageControl 的frame
        CGFloat pageControlX=self.view.bounds.size.width-pageControlSize.width-10;
        CGFloat pageControlY=self.view.bounds.size.height-pageControlSize.height;
        self.pageControl.frame=CGRectMake(pageControlX, pageControlY, pageControlSize.width, pageControlSize.height);
        
        
        NSIndexPath *indexPath=[NSIndexPath indexPathForItem:self.dataArr.count inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:NO];
        
        
    } failBlock:^(NSError *error) {
        NSLog(@"error%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index=scrollView.contentOffset.x/scrollView.bounds.size.width;
    self.pageControl.currentPage=index%self.dataArr.count;
    NSIndexPath *indexPath;
    NSInteger num=[self.collectionView numberOfItemsInSection:0];
    
    if (index==0) {
        indexPath=[NSIndexPath indexPathForItem:self.dataArr.count inSection:0];
    }else if (index==num-1){
        indexPath=[NSIndexPath indexPathForItem:self.dataArr.count-1 inSection:0];
    }
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:NO];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dataArr.count*2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CycleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    CycleModel *model=self.dataArr[indexPath.item%self.dataArr.count];
    cell.model=model;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
