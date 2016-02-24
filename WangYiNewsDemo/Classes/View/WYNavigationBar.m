//
//  WYNavigationBar.m
//  WangYiNewsDemo
//
//  Created by 鄂鸿桢 on 16/2/23.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "WYNavigationBar.h"

@implementation WYNavigationBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (UIButton *button in self.subviews) {
        if (![button isKindOfClass:[UIButton class]]) continue;
        
        if (button.centerX < self.width * 0.5) { // 左边的按钮
            button.x = 0;
        } else if (button.centerX > self.width * 0.5) { // 右边的按钮
            button.x = self.width - button.width;
        }
    }
}

@end
