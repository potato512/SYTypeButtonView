//
//  SYTypeButtonView.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/11/16.
//  Copyright © 2015年 zhangshaoyu. All rights reserved.
//  https://github.com/potato512/SYTypeButtonView

#import <UIKit/UIKit.h>

/// 默认行高
static CGFloat const heightTypeButtonView = 40.0f;

/// 常规按钮key
static NSString *const keyImageNormal         = @"keyImageNormal";
/// 第一图标 高亮及选中按钮key
static NSString *const keyImageSelected       = @"keyImageSelected";
/// 第二图标 高亮及选中按钮key
static NSString *const keyImageSelectedDouble = @"keyImageSelectedDouble";

@interface SYTypeButtonView : UIView

/// 实例化
- (instancetype)initWithFrame:(CGRect)frame view:(UIView *)view;

/// 是否显示切换滚动条（默认不显示。设置标题数组前设置）
@property (nonatomic, assign) BOOL showScrollLine;
/// 滚动条颜色（默认红色）
@property (nonatomic, strong) UIColor *scrollLineColor;
/// 滚动条适应标题宽度（默认NO）
@property (nonatomic, assign) BOOL adjustScrollLineWidth;

/// 字体大小（默认12。设置标题后设置）
@property (nonatomic, strong) UIFont *titleFont;
/// 选中后字体大小（默认12。设置标题后设置）
@property (nonatomic, strong) UIFont *titleFontSelected;

/// 字体颜色 未选择状态（默认黑色）
@property (nonatomic, strong) UIColor *titleColorNormal;
/// 字体颜色 选择状态（默认橙色）
@property (nonatomic, strong) UIColor *titleColorSelected;

/// 按钮标题数组
@property (nonatomic, strong) NSArray <NSString *> *titles;

/// 可重复操作的按钮标题（默认不能重复操作）
@property (nonatomic, strong) NSArray <NSString *> *enableTitles;

/// 按钮图标类型（array - dict - normal+selected+selectedDouble => @[@{keyImageNormal:[UIImage imageNamed:@"xxx"], keyImageSelected:[UIImage imageNamed:@"xxx"], keyImageSelectedDouble:[UIImage imageNamed:@"xxx"]}, ..., @{keyImageNormal:[UIImage imageNamed:@"xxx"], keyImageSelected:[UIImage imageNamed:@"xxx"], keyImageSelectedDouble:[UIImage imageNamed:@"xxx"]}]）
@property (nonatomic, strong) NSArray <NSDictionary *> *imageTypeArray;

/// 回调响应（默认升序）
@property (nonatomic, copy) void (^buttonClick)(NSInteger index, BOOL isDescending);

/// 默认选中按钮（默认第一个按钮被选中，如果是多状态选择时，必须设置，否则无法进行二项选择；-1时表示取消选中状态；设置在属性titles之后）
@property (nonatomic, assign) NSInteger selectedIndex;

/// 重置按钮标题
- (void)setTitleButton:(NSString *)title index:(NSInteger)index;
/// 设置某个按钮升序或降序状态
- (void)setTypeButton:(BOOL)isDescending index:(NSInteger)index;

@end
