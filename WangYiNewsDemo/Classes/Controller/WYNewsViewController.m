//
//  WYNewsViewController.m
//  WangYiNewsDemo
//
//  Created by 鄂鸿桢 on 16/2/20.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "WYNewsViewController.h"
#import "WYNavigationController.h"
#import "WYTitleView.h"

#define WYNavShowAnimDuration 0.25


@interface WYNewsViewController ()
/**
 *  正在显示的导航控制器
 */
@property (nonatomic, weak) WYNavigationController *showingNavigationController;
@end

@implementation WYNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //标题
    WYTitleView *titleView = [[WYTitleView alloc] init];
    titleView.title = @"新闻";
    self.navigationItem.titleView = titleView;
    
    //左侧按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"top_navigation_menuicon" target:self action:@selector(leftMenu)];
    //右侧按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"top_navigation_infoicon" target:self action:@selector(rightMenu)];
}

- (void)leftMenu
{
    NSLog(@"leftMenu---");
    
    [UIView animateWithDuration:2.0 animations:^{
//        // 取出正在显示的导航控制器的view
//        UIView *showingView = self.navigationController.view;
        
        // 缩放比例
        CGFloat navH = [UIScreen mainScreen].bounds.size.height - 2 * 60;
        CGFloat scale = navH / [UIScreen mainScreen].bounds.size.height;
        
        // 菜单左边的间距
        CGFloat leftMenuMargin = [UIScreen mainScreen].bounds.size.width * (1 - scale) * 0.5;
        CGFloat translateX = 200 - leftMenuMargin;
        
        CGFloat topMargin = [UIScreen mainScreen].bounds.size.height * (1 - scale) * 0.5;
        CGFloat translateY = topMargin - 60;
        
        // 缩放
        CGAffineTransform scaleForm = CGAffineTransformMakeScale(scale, scale);
        // 平移
        CGAffineTransform translateForm = CGAffineTransformTranslate(scaleForm, translateX / scale, -translateY / scale);
        
//        showingView.transform = translateForm;
        self.navigationController.view.transform = translateForm;
        // 添加一个遮盖
        UIButton *cover = [[UIButton alloc] init];
//        cover.backgroundColor = [UIColor blueColor];
        [cover addTarget:self action:@selector(coverClick:) forControlEvents:UIControlEventTouchUpInside];
        cover.frame = self.navigationController.view.bounds;
        [self.navigationController.view addSubview:cover];
        
    }];
}

- (void)rightMenu
{
    NSLog(@"rightMenu---");
}

- (void)coverClick:(UIButton *)cover
{
    [UIView animateWithDuration:WYNavShowAnimDuration animations:^{
        self.navigationController.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [cover removeFromSuperview];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


@end
