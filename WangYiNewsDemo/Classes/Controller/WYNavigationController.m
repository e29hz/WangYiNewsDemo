//
//  WYNavigationController.m
//  WangYiNewsDemo
//
//  Created by 鄂鸿桢 on 16/2/19.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "WYNavigationController.h"
#import "WYNavigationBar.h"

@interface WYNavigationController ()

@end

@implementation WYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 替换为自定义的导航栏
    [self setValue:[[WYNavigationBar alloc] init] forKeyPath:@"navigationBar"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (void)initialize
{
    UINavigationBar *appearance = [UINavigationBar appearance];
    
    // 设置导航栏背景
    [appearance setBackgroundImage:[UIImage imageNamed:@"top_navigation_background"] forBarMetrics:UIBarMetricsDefault];
}


@end
