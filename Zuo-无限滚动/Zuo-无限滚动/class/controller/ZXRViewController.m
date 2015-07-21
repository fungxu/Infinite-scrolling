//
//  ZXRViewController.m
//  02-无限滚动 7.21
//
//  Created by zuo on 15/7/21.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "ZXRViewController.h"
#import "ZXRNewsViewController.h"
#import "UIView+ZXRExtension.h"

@interface ZXRViewController ()
/** NewsVc */
@property (nonatomic, strong)ZXRNewsViewController *NewsVc;
@end

@implementation ZXRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZXRNewsViewController *NewsVc = [[ZXRNewsViewController alloc] init];
    [self addChildViewController:NewsVc];
    self.NewsVc = NewsVc;
    [self.view addSubview:NewsVc.view];
}



@end
