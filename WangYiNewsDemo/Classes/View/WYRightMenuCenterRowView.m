//
//  WYRightMenuCenterRowView.m
//  WangYiNewsDemo
//
//  Created by 鄂鸿桢 on 16/2/24.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "WYRightMenuCenterRowView.h"

@interface WYRightMenuCenterRowView ()

@property (weak, nonatomic) IBOutlet UIButton *titleButton;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;


@end

@implementation WYRightMenuCenterRowView

+ (instancetype)centerViewRow
{
    return [[[NSBundle mainBundle] loadNibNamed:@"WYRightMenuCenterRowView" owner:nil options:nil] lastObject];
}

- (void)setIcon:(NSString *)icon
{
    _icon = [icon copy];
    
    self.iconView.image = [UIImage imageNamed:icon];
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    
    [self.titleButton setTitle:title forState:UIControlStateNormal];
}
@end
