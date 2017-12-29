//
//  SYTypeButtonView.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/11/16.
//  Copyright © 2015年 zhangshaoyu. All rights reserved.
//  排序按钮视图 https://github.com/potato512/SYTypeButtonView

#import <UIKit/UIKit.h>

/// 默认行高
#define heightTypeButtonView (40.0)

static NSString *const keyImageNormal         = @"keyImageNormal";
static NSString *const keyImageSelected       = @"keyImageSelected";
static NSString *const keyImageSelectedDouble = @"keyImageSelectedDouble";

@interface SYTypeButtonView : UIView

/// 实例化
- (instancetype)initWithFrame:(CGRect)frame view:(UIView *)view;

/// 是否显示切换滚动条（默认不显示。设置标题前设置）
@property (nonatomic, assign) BOOL showScrollLine;

/// 字体大小（默认12。设置标题后设置）
@property (nonatomic, strong) UIFont *titleFont;
/// 选中后字体大小（默认12。设置标题后设置）
@property (nonatomic, strong) UIFont *titleFontSelected;

/// 按钮标题数组
@property (nonatomic, strong) NSArray *titles;

/// 选择状态颜色
@property (nonatomic, strong) UIColor *colorSelected;

/// 未选择状态颜色
@property (nonatomic, strong) UIColor *colorNormal;

/// 可重复操作的按钮标题（默认不能重复操作）
@property (nonatomic, strong) NSArray *enableTitles;

/// 按钮图标类型（array - dict - normal+selected+selectedDouble）
@property (nonatomic, strong) NSArray *imageTypeArray;

/// 回调响应（默认升序）
@property (nonatomic, copy) void (^buttonClick)(NSInteger index, BOOL isDescending);

/// 默认选中按钮（默认第一个按钮被选中，如果是多状态选择时，必须设置，否则无法进行二项选择；-1时表示取消选中状态）
@property (nonatomic, assign) NSInteger selectedIndex;


/// 重置按钮标题
- (void)setTitleButton:(NSString *)title index:(NSInteger)index;
/// 设置某个按钮升序或降序状态
- (void)setTypeButton:(BOOL)isDescending index:(NSInteger)index;

@end
