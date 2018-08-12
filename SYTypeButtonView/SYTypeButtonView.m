//
//  SYTypeButtonView.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/11/16.
//  Copyright © 2015年 zhangshaoyu. All rights reserved.
//

#import "SYTypeButtonView.h"
#import "SYButton.h"

static NSInteger const tagButton = 1000;

@interface SYTypeButtonView ()

@property (nonatomic, strong) NSMutableArray *buttonArray; // 按钮数组
@property (nonatomic, strong) NSMutableDictionary *lineWidthDict; // 滚动条自适应标题长度缓存

@property (nonatomic, assign) NSInteger previousTag;
@property (nonatomic, strong) NSString *previousTitle;
@property (nonatomic, assign) BOOL isDescending; // 默认升序，即NO

@property (nonatomic, strong) UIView *lineView;  // 滚动条

@end

@implementation SYTypeButtonView

- (instancetype)initWithFrame:(CGRect)frame view:(UIView *)view
{
    self = [super init];
    if (self) {
        CGRect rect = frame;
        rect.size.height = heightTypeButtonView;
        self.frame = rect;
        
        _titleFont = [UIFont systemFontOfSize:12.0];
        _titleFontSelected = [UIFont systemFontOfSize:12.0];
        _titleColorNormal = [UIColor blackColor];
        _titleColorSelected = [UIColor orangeColor];
        _scrollLineColor = [UIColor redColor];
        _adjustScrollLineWidth = NO;
        
        if (view) {
            [view addSubview:self];
        }
    }
    
    return self;
}

#pragma mark - 视图

- (void)setUIWithTitles:(NSArray *)array
{
    NSInteger count = array.count;
    CGFloat width = CGRectGetWidth(self.bounds) / count;
    
    for (int i = 0; i < count; i++) {
        NSString *title = array[i];
        CGRect rect = CGRectMake(i * width, 0.0, width, CGRectGetHeight(self.bounds));
        
        SYButton *button = [SYButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor clearColor];
        [button setTitleColor:_titleColorNormal forState:UIControlStateNormal];
        [button setTitleColor:_titleColorSelected forState:UIControlStateSelected];
        [button setTitle:title forState:UIControlStateNormal];
        button.frame = rect;
        
        button.userInteractionEnabled = YES;
        button.selected = NO;
        
        button.tag = i + tagButton;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
        [self.buttonArray addObject:button];
    }
    
    // 实始化选中第一个
    self.previousTag = tagButton + 0;
    SYButton *button = self.buttonArray.firstObject;
    button.userInteractionEnabled = NO;
    button.selected = YES;
    
    // 滚动条
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0.0, (CGRectGetHeight(self.bounds) - 1.0), width, 2.0)];
    [self addSubview:self.lineView];
    self.lineView.backgroundColor = _scrollLineColor;

    self.lineView.hidden = !self.showScrollLine;
}

- (void)setButtonColor
{
    if (_titleColorSelected) {
        for (SYButton *button in self.buttonArray) {
            [button setTitleColor:_titleColorSelected forState:UIControlStateHighlighted];
            [button setTitleColor:_titleColorSelected forState:UIControlStateSelected];
        }
    }
    
    if (_titleColorNormal) {
        for (SYButton *button in self.buttonArray) {
            [button setTitleColor:_titleColorNormal forState:UIControlStateNormal];
        }
    }
}

#pragma mark - 响应

- (void)buttonAction:(UIButton *)button
{
    [self buttonActionLine:button];
    [self buttonActionStatus:button];
    
    if (self.buttonClick) {
        NSInteger index = button.tag - tagButton;
        self.buttonClick(index, self.isDescending);
    }
}

- (void)buttonActionLine:(UIButton *)button
{
    if (self.showScrollLine)
    {
        self.lineView.hidden = NO;
        
        // 无动画效果
//        CGRect rect = self.lineView.frame;
//        rect.origin.x = button.frame.origin.x;
//        self.lineView.frame = rect;
        // 或动画效果
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = self.lineView.frame;
            if (self.adjustScrollLineWidth) {
                NSString *key = [NSString stringWithFormat:@"%@", @(button.tag)];
                NSNumber *value = self.lineWidthDict[key];
                CGFloat width = value.doubleValue;
                if (width <= 0) {
                    width = [button.titleLabel.text boundingRectWithSize:button.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:button.titleLabel.font} context:nil].size.width;
                    [self.lineWidthDict setObject:@(width) forKey:key];
                }
                rect.size.width = width;
                rect.origin.x = (button.frame.origin.x + (button.frame.size.width - width) / 2);
            } else {
                rect.size.width = button.frame.size.width;
                rect.origin.x = button.frame.origin.x;
            }
            self.lineView.frame = rect;
        }];
    }
}

- (void)buttonActionStatus:(UIButton *)button
{
    button.userInteractionEnabled = !button.userInteractionEnabled;
    button.selected = !button.selected;
    button.titleLabel.font = (button.selected ? _titleFontSelected : _titleFont);
    
    SYButton *previousButton = self.buttonArray[self.previousTag - tagButton];
    previousButton.userInteractionEnabled = YES;
    previousButton.selected = ([previousButton isEqual:button] ? button.selected : NO);
    previousButton.titleLabel.font = (previousButton.selected ? _titleFontSelected : _titleFont);
    self.previousTag = button.tag;
    
    NSString *title = button.titleLabel.text;
    NSInteger index = self.previousTag - tagButton;
    if ([self.enableTitles containsObject:title]) {
        button.userInteractionEnabled = YES;
        button.selected = YES;
        self.isDescending = ([title isEqualToString:self.previousTitle] ? (self.isDescending ? NO : YES) : YES);
        
        NSDictionary *dict = _imageTypeArray[index];
        UIImage *imageSelected = dict[keyImageSelected];
        UIImage *imageSelectedDouble = dict[keyImageSelectedDouble];
        [button setImage:(self.isDescending ? imageSelected : imageSelectedDouble) forState:UIControlStateSelected];
    }
    self.previousTitle = title;
}

#pragma mark - getter

- (NSMutableArray *)buttonArray
{
    if (_buttonArray == nil) {
        _buttonArray = [[NSMutableArray alloc] init];
    }
    return _buttonArray;
}

- (NSMutableDictionary *)lineWidthDict
{
    if (_lineWidthDict == nil) {
        _lineWidthDict = [[NSMutableDictionary alloc] init];
    }
    return _lineWidthDict;
}

#pragma mark - setter

- (void)setShowScrollLine:(BOOL)showScrollLine
{
    _showScrollLine = showScrollLine;
    self.lineView.hidden = !_showScrollLine;
}

- (void)setScrollLineColor:(UIColor *)scrollLineColor
{
    _scrollLineColor = scrollLineColor;
    self.lineView.backgroundColor = _scrollLineColor;
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    if (_titleFont) {
        for (SYButton *button in self.buttonArray) {
            button.titleLabel.font = (button.selected ? _titleFontSelected : _titleFont);
        }
    }
}

- (void)setTitleFontSelected:(UIFont *)titleFontSelected
{
    _titleFontSelected = titleFontSelected;
    if (_titleFontSelected) {
        for (SYButton *button in self.buttonArray) {
            button.titleLabel.font = (button.selected ? _titleFontSelected : _titleFont);
        }
    }
}

- (void)setTitleColorNormal:(UIColor *)titleColorNormal
{
    _titleColorNormal = titleColorNormal;
    [self setButtonColor];
}

- (void)setTitleColorSelected:(UIColor *)titleColorSelected
{
    _titleColorSelected = titleColorSelected;
    [self setButtonColor];
}

- (void)setTitles:(NSArray *)titles
{
    _titles = titles;
    if (_titles && 0 < titles.count) {
        [self.buttonArray removeAllObjects];
        [self.lineWidthDict removeAllObjects];
        
        [self setUIWithTitles:_titles];
        
        [self setButtonColor];
    }
}

- (void)setImageTypeArray:(NSArray *)imageTypeArray
{
    _imageTypeArray = imageTypeArray;
    if (_imageTypeArray) {
        for (int i = 0; i < _imageTypeArray.count; i++) {
            NSDictionary *dict = _imageTypeArray[i];
            UIImage *imageNormal = dict[keyImageNormal];
            UIImage *imageSelected = dict[keyImageSelected];
            
            SYButton *button = self.buttonArray[i];
            [button setImage:imageNormal forState:UIControlStateNormal];
            [button setImage:imageSelected forState:UIControlStateSelected];
        }
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    
    // 小于0时取消选中
    if (_selectedIndex < 0) {
        for (SYButton *button in self.buttonArray) {
            if (button.isSelected) {
                button.selected = NO;
                button.userInteractionEnabled = YES;
            }
        }
        return;
    }
    
    SYButton *button = self.buttonArray[_selectedIndex];
    if (button && [button isKindOfClass:[SYButton class]]) {
        // 改变按钮状态，不响应交互事件
        [self buttonActionStatus:button];
        [self buttonActionLine:button];
    }
}

/// 重置按钮标题
- (void)setTitleButton:(NSString *)title index:(NSInteger)index
{
    if ((!title || 0 >= title.length) || (0 > index || (self.subviews.count - 1) <= index)) {
        return;
    }
    
    SYButton *button = self.buttonArray[index];
    if (button && [button isKindOfClass:[SYButton class]]) {
        [button setTitle:title forState:UIControlStateNormal];
    }
}

/// 设置某个按钮升序或降序状态
- (void)setTypeButton:(BOOL)isDescending index:(NSInteger)index
{
    if (0 > index || (self.subviews.count - 1) <= index) {
        return;
    }
    
    // 取消已选
    for (SYButton *button in self.buttonArray) {
        if (button.isSelected) {
            button.selected = NO;
            button.userInteractionEnabled = YES;
        }
    }
    
    //
    SYButton *button = self.buttonArray[index];
    if (button && [button isKindOfClass:[SYButton class]]) {
        NSString *title = button.titleLabel.text;
        if ([self.enableTitles containsObject:title]) {
            button.userInteractionEnabled = YES;
            button.selected = YES;
            self.isDescending = isDescending;
            
            NSDictionary *dict = _imageTypeArray[index];
            UIImage *imageSelected = dict[keyImageSelected];
            UIImage *imageSelectedDouble = dict[keyImageSelectedDouble];
            [button setImage:(self.isDescending ? imageSelected : imageSelectedDouble) forState:UIControlStateSelected];
            self.previousTitle = title;
        }
    }
    //
    [self buttonActionLine:button];
}

@end
