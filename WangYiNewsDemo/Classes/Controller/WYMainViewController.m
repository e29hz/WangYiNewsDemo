//
//  WYMainViewController.m
//  WangYiNewsDemo
//
//  Created by 鄂鸿桢 on 16/2/18.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "WYMainViewController.h"
#import "WYNavigationController.h"
#import "WYLeftMenu.h"
#import "WYNewsViewController.h"
#import "WYReadingViewController.h"
#import "WYTitleView.h"
#import "WYRightMenuController.h"

#define WYNavShowAnimDuration 0.3
#define WYCoverTag 100
#define WYLeftMenuW 180
#define WYLeftMenuH 360
#define WYLeftMenuY 60


@interface WYMainViewController ()<WYLeftMenuDelegate>

/**
 *  正在显示的导航控制器
 */
@property (nonatomic, weak) WYNavigationController *showingNavigationController;

@property (nonatomic, strong) WYRightMenuController *rightMenuVc;
//@property (nonatomic, weak) UIView *rightMenu;

@property (nonatomic, weak) WYLeftMenu *leftMenu;

@end

@implementation WYMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 创建子控制器
    [self setupAllChildVc];
    
    // 创建左菜单
    [self setupLeftMenu];
    
    // 创建右菜单
    [self setupRightMenu];
    
    
}

- (void)setupAllChildVc
{
    // 1.新闻控制器
    WYNewsViewController *news = [[WYNewsViewController alloc] init];
    [self setupVc:news title:@"新闻"];
    
    // 2.订阅控制器
    WYReadingViewController *reading = [[WYReadingViewController alloc] init];
    [self setupVc:reading title:@"订阅"];
    
    // 3.图片控制器
    UIViewController *photo = [[UIViewController alloc] init];
    [self setupVc:photo title:@"图片"];
    
    // 4.视频控制器
    UIViewController *video = [[UIViewController alloc] init];
    [self setupVc:video title:@"视频"];
    
    // 5.跟帖控制器
    UIViewController *comment = [[UIViewController alloc] init];
    [self setupVc:comment title:@"跟帖"];
    
    // 6.电台控制器
    UIViewController *radio = [[UIViewController alloc] init];
    [self setupVc:radio title:@"电台"];
}

- (void)setupLeftMenu
{
    // 添加左菜单
    WYLeftMenu *leftMenu = [[WYLeftMenu alloc] init];
    leftMenu.delegate = self;
    leftMenu.height = 300;
    leftMenu.width = 200;
    leftMenu.y = 60;
    [self.view insertSubview:leftMenu atIndex:1];
    self.leftMenu = leftMenu;
}

- (void)setupRightMenu
{
    WYRightMenuController *rightMenuVc = [[WYRightMenuController alloc] init];
    rightMenuVc.view.x = self.view.width - rightMenuVc.view.width;
    [self.view insertSubview:rightMenuVc.view atIndex:1];
//    [self addChildViewController:rightMenuVc];
//    self.rightMenu = rightMenuVc.view;
    self.rightMenuVc = rightMenuVc;
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

/**
 *  初始化一个控制器
 *
 *  @param vc      需要初始化的控制器
 *  @param title   控制器的标题
 */
- (void)setupVc:(UIViewController *)vc title:(NSString *)title
{
    // 1.设置背景色
    vc.view.backgroundColor = WYRandomColor;
    
    // 2.设置标题
    WYTitleView *titleView = [[WYTitleView alloc] init];
    titleView.title = title;
    vc.navigationItem.titleView = titleView;
    
    // 3.设置左右按钮
    vc.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"top_navigation_menuicon" target:self action:@selector(leftMenuClick)];
    vc.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"top_navigation_infoicon" target:self action:@selector(rightMenuClick)];
    
    // 4.包装一个导航控制器
    WYNavigationController *nav = [[WYNavigationController alloc] initWithRootViewController:vc];
    // 让newsNav成为self（HMMainViewController）的子控制器，能保证：self在，newsNav就在
    // 如果两个控制器互为父子关系，那么它们的view也应该互为父子关系
    [self addChildViewController:nav];
}

#pragma mark - 监听导航栏按钮点击

- (void)leftMenuClick
{
    self.leftMenu.hidden = NO;
    self.rightMenuVc.view.hidden = YES;
    NSLog(@"leftMenu---");
    [UIView animateWithDuration:WYNavShowAnimDuration animations:^{
        // 取出正在显示的导航控制器的view
        UIView *showingView = self.showingNavigationController.view;
        
        // 缩放比例
        CGFloat navH = [UIScreen mainScreen].bounds.size.height - 2 * WYLeftMenuY;
        CGFloat scale = navH / [UIScreen mainScreen].bounds.size.height;
        
        // 菜单左边的间距
        CGFloat leftMenuMargin = [UIScreen mainScreen].bounds.size.width * (1 - scale) * 0.5;
        CGFloat translateX = WYLeftMenuW - leftMenuMargin;
        
        CGFloat topMargin = [UIScreen mainScreen].bounds.size.height * (1 - scale) * 0.5;
        CGFloat translateY = WYLeftMenuY - topMargin;
        
        // 缩放
        CGAffineTransform scaleForm = CGAffineTransformMakeScale(scale, scale);
        // 平移
        CGAffineTransform translateForm = CGAffineTransformTranslate(scaleForm, translateX / scale, translateY / scale);
        
        showingView.transform = translateForm;
        
        // 添加一个遮盖
        UIButton *cover = [[UIButton alloc] init];
        cover.tag = WYCoverTag;
        [cover addTarget:self action:@selector(coverClick:) forControlEvents:UIControlEventTouchUpInside];
        cover.frame = showingView.bounds;
        [showingView addSubview:cover];
    }];
}

- (void)coverClick:(UIView *)cover
{
    [UIView animateWithDuration:WYNavShowAnimDuration animations:^{
        self.showingNavigationController.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [cover removeFromSuperview];
    }];
}

- (void)rightMenuClick
{
    self.leftMenu.hidden = YES;
    self.rightMenuVc.view.hidden = NO;
    NSLog(@"rightMenu");
    [UIView animateWithDuration:WYNavShowAnimDuration animations:^{
        // 取出正在显示的导航控制器的view
        UIView *showingView = self.showingNavigationController.view;
        
        // 缩放比例
        CGFloat navH = [UIScreen mainScreen].bounds.size.height - 2 * WYLeftMenuY;
        CGFloat scale = navH / [UIScreen mainScreen].bounds.size.height;
        
        // 菜单左边的间距
        CGFloat leftMenuMargin = [UIScreen mainScreen].bounds.size.width * (1 - scale) * 0.5;
        CGFloat translateX = leftMenuMargin - self.rightMenuVc.view.width;
        
        CGFloat topMargin = [UIScreen mainScreen].bounds.size.height * (1 - scale) * 0.5;
        CGFloat translateY = WYLeftMenuY - topMargin;
        
        // 缩放
        CGAffineTransform scaleForm = CGAffineTransformMakeScale(scale, scale);
        // 平移
        CGAffineTransform translateForm = CGAffineTransformTranslate(scaleForm, translateX / scale, translateY / scale);
        
        showingView.transform = translateForm;
        
        // 添加一个遮盖
        UIButton *cover = [[UIButton alloc] init];
        cover.tag = WYCoverTag;
        [cover addTarget:self action:@selector(coverClick:) forControlEvents:UIControlEventTouchUpInside];
        cover.frame = showingView.bounds;
        [showingView addSubview:cover];
    } completion:^(BOOL finished) {
        [self.rightMenuVc didShow];
    }];
}

#pragma mark - WYLeftMenuDelegate
- (void)leftMenu:(WYLeftMenu *)menu didSelectedButtonFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex
{
    // 0.移除旧控制器的view
    WYNavigationController *oldNav = self.childViewControllers[fromIndex];
    [oldNav.view removeFromSuperview];
    
    // 1.显示新控制器的view
    WYNavigationController *newNav = self.childViewControllers[toIndex];
    [self.view addSubview:newNav.view];
    
    // 设置新控制的transform跟旧控制器一样
    newNav.view.transform = oldNav.view.transform;
    // 设置阴影
    newNav.view.layer.shadowColor = [UIColor blackColor].CGColor;
    newNav.view.layer.shadowOffset = CGSizeMake(-3, 0);
    newNav.view.layer.shadowOpacity = 0.2;
    
    // 一个导航控制器的view第一次显示到它的父控件上时，如果transform的缩放值被改了，上面的20高度当时是不会出来
    
    // 2.设置当前正在显示的控制器
    self.showingNavigationController = newNav;
    
    // 3.清空transform(点击遮盖)
    
    [self coverClick:[newNav.view viewWithTag:WYCoverTag]];
//    [UIView animateWithDuration:WYNavShowAnimDuration animations:^{
//        newNav.view.transform = CGAffineTransformIdentity;
//    }];
//    
//    // 4.清除当前显示的控制器上的遮盖
//    [[newNav.view viewWithTag:WYCoverTag] removeFromSuperview];
    
}

@end
