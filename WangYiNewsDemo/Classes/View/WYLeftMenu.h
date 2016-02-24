//
//  WYLeftMenu.h
//  WangYiNewsDemo
//
//  Created by 鄂鸿桢 on 16/2/18.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WYLeftMenu;
@protocol WYLeftMenuDelegate <NSObject>
@optional
- (void)leftMenu:(WYLeftMenu *)menu didSelectedButtonFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;
@end

@interface WYLeftMenu : UIView
@property (nonatomic, weak) id<WYLeftMenuDelegate> delegate;

@end
