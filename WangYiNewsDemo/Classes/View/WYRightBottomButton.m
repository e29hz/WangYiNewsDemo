//
//  WYRightBottomButton.m
//  WangYiNewsDemo
//
//  Created by 鄂鸿桢 on 16/2/24.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "WYRightBottomButton.h"

@implementation WYRightBottomButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.height = 70;
        self.width = 70;
        
//        self.backgroundColor = WYRandomColor;
//        self.titleLabel.backgroundColor = [UIColor redColor];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(35, 0, 0, 0)];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}

- (void)setIcon:(NSString *)icon
{
    _icon = [icon copy];
    
    [self setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
}

- (void)setText:(NSString *)text
{
    _text = [text copy];
    
    [self setTitle:text forState:UIControlStateNormal];
}

@end
