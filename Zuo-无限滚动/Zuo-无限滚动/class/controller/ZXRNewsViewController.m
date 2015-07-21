//
//  ZXRNewsViewController.m
//  无限滚动
//
//  Created by zuo on 15/7/21.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "ZXRNewsViewController.h"
#import "ZXRNews.h"
#import "MJExtension.h"
#import "ZXRCollectionViewCell.h"
#import "UIView+ZXRExtension.h"

#define ZXRMaxSections 3

@interface ZXRNewsViewController ()
/** news */
@property (nonatomic, strong)NSArray *news;
/** timer */
@property (nonatomic, strong)NSTimer *timer;
@end

@implementation ZXRNewsViewController
- (NSArray *)news
{
    if (_news == nil) {
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"newses" ofType:@"plist"]];
        _news = [ZXRNews objectArrayWithKeyValuesArray:array];
    }
    return _news;
}


- (instancetype)init
{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.minimumLineSpacing = 0;
    flow.itemSize = CGSizeMake(300, 130);
    flow.minimumInteritemSpacing = 0;
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self = [super initWithCollectionViewLayout:flow];
    if (self) {
    }
    return self;
}

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.frame = CGRectMake(0, 100, 300, 130);
    self.view.centerX = [UIScreen mainScreen].bounds.size.width * 0.5;
    
    [self.collectionView registerClass:[ZXRCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    
    NSIndexPath *resetPath = [NSIndexPath indexPathForRow:0 inSection:ZXRMaxSections / 2];
    [self.collectionView selectItemAtIndexPath:resetPath animated:NO scrollPosition:UICollectionViewScrollPositionLeft];
    
    [self addTimer];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return ZXRMaxSections;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return self.news.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZXRCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor redColor];
    cell.news = self.news[indexPath.item];
    
    return cell;
}

#pragma mark 无限滚动
- (void)reset
{
    NSIndexPath *currPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    NSIndexPath *resetPath = [NSIndexPath indexPathForRow:currPath.item inSection:ZXRMaxSections / 2];
    NSLog(@"%@", resetPath);
    [self.collectionView selectItemAtIndexPath:resetPath animated:NO scrollPosition:UICollectionViewScrollPositionLeft];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self reset];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"%s", __func__);
    [self removeTimer];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"%s", __func__);
    [self addTimer];
}

- (void)addTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}


- (void)nextImage
{
    NSIndexPath *currPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    NSIndexPath *resetPath = [NSIndexPath indexPathForRow:currPath.item inSection:ZXRMaxSections / 2];
    NSLog(@"%@", resetPath);
    [self.collectionView selectItemAtIndexPath:resetPath animated:NO scrollPosition:UICollectionViewScrollPositionLeft];
    
    NSInteger nextrow = resetPath.item + 1 == self.news.count ? 0 : resetPath.item + 1;
    NSInteger nextsection = resetPath.item + 1 == self.news.count ? resetPath.section + 1 : resetPath.section;

    NSIndexPath *nextPath = [NSIndexPath indexPathForRow:nextrow inSection:nextsection];
    [self.collectionView selectItemAtIndexPath:nextPath animated:YES scrollPosition:UICollectionViewScrollPositionLeft];
    
}

@end
