//
//  ZXRCollectionViewCell.m
//  02-无限滚动 7.21
//
//  Created by zuo on 15/7/21.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "ZXRCollectionViewCell.h"
#import "UIView+ZXRExtension.h"
@interface ZXRCollectionViewCell ()
/** iconView */
@property (nonatomic, weak)UIImageView *iconView;
/** titleLabel */
@property (nonatomic, weak)UILabel *titleLabel;
@end

@implementation ZXRCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化子控件
        UIImageView *iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconView];
        iconView.backgroundColor = [UIColor blueColor];
        self.iconView = iconView;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.iconView.frame = self.bounds;
    
    self.titleLabel.width = self.width;
    self.titleLabel.height = 40;
    self.titleLabel.x = 0;
    self.titleLabel.y = 0;
    
}


- (void)setNews:(ZXRNews *)news
{
    _news = news;
    
    self.iconView.image = [UIImage imageNamed:news.icon];
    self.titleLabel.text = news.title;
}

@end
