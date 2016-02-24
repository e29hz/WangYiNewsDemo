//
//  WYRightMenuController.m
//  WangYiNewsDemo
//
//  Created by 鄂鸿桢 on 16/2/23.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "WYRightMenuController.h"
#import "WYRightMenuCenterRowView.h"
#import "WYRightBottomButton.h"

@interface WYRightMenuController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation WYRightMenuController

- (void)viewDidLoad {
    [super viewDidLoad];

    //填充中间内容
    [self setupCenterView];
    
    //填充底部内容
    [self setupBottomView];
    
}

- (void)setupCenterView
{
    
    [self setupCenterViewRow:@"商城 能赚能花，土豪当家" icon:@"promoboard_icon_mall"];
    [self setupCenterViewRow:@"活动 4.0发布会粉丝招募" icon:@"promoboard_icon_activities"];
    [self setupCenterViewRow:@"应用 金币从来都是这送的" icon:@"promoboard_icon_apps"];
}

- (void)setupCenterViewRow:(NSString *)title icon:(NSString *)icon
{
    WYRightMenuCenterRowView *row = [WYRightMenuCenterRowView centerViewRow];
    
    row.icon = icon;
    row.title = title;
    row.y = row.height * self.centerView.subviews.count;
    
    [self.centerView addSubview:row];
    
}

- (void)setupBottomView
{
    [self setupBottomImage:@"pluginboard_icon_comment" text:@"跟帖"];
    [self setupBottomImage:@"pluginboard_icon_favor" text:@"收藏"];
    [self setupBottomImage:@"pluginboard_icon_offline" text:@"离线"];
    [self setupBottomImage:@"pluginboard_icon_night" text:@"夜间"];
    [self setupBottomImage:@"pluginboard_icon_weather" text:@"天气"];
    [self setupBottomImage:@"pluginboard_icon_search" text:@"搜索"];
    [self setupBottomImage:@"pluginboard_icon_message" text:@"消息"];
    [self setupBottomImage:@"pluginboard_icon_mailbox" text:@"邮箱"];
    [self setupBottomImage:@"pluginboard_icon_add" text:nil];
    
}

- (void)setupBottomImage:(NSString *)icon text:(NSString *)text
{
    WYRightBottomButton *button = [[WYRightBottomButton alloc] init];
    button.icon = icon;
    button.text = text;
    NSInteger iconCount = self.bottomView.subviews.count % 3;
        button.x = button.width * iconCount + iconCount * 20;
    
    button.y = button.height * (self.bottomView.subviews.count / 3);;
    [self.bottomView addSubview:button];
}
- (void)didShow
{
    //让头像旋转(转场动画)
//    [UIView animateWithDuration:2.0 animations:^{
//        self.iconView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
//        self.iconView.image = [UIImage imageNamed:@"user_defaultgift"];
//    }];

    [UIView transitionWithView:self.iconView duration:1.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                self.iconView.image = [UIImage imageNamed:@"user_defaultgift"];

    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView transitionWithView:self.iconView duration:1.5 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                self.iconView.image = [UIImage imageNamed:@"default_avatar"];
                
            } completion:nil];
        });
        
    }];

}

@end
