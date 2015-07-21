//
//  ZXRCollectionViewCell.h
//  02-无限滚动 7.21
//
//  Created by zuo on 15/7/21.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXRNews.h"

@interface ZXRCollectionViewCell : UICollectionViewCell
/** 模型 */
@property (nonatomic, strong)ZXRNews *news;
@end
