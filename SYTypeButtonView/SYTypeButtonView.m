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

@property (nonatomic, assign) NSInteger previousTag;
@property (nonatomic, strong) NSString *previousTitle;
@property (nonatomic, assign) BOOL isDescending; // 默认升序，即NO

@property (nonatomic, strong) UIView *lineView;  // 滚动条

@end

@implementation SYTypeButtonView

- (instancetype)initWithFrame:(CGRect)frame view:(UIView *)view
{
    self = [super init];
    if (self)
    {
        CGRect rect = frame;
        rect.size.height = heightTypeButtonView;
        self.frame = rect;
        
        _titleFont = [UIFont systemFontOfSize:12.0];
        _titleFontSelected = [UIFont systemFontOfSize:12.0];
        
        if (view)
        {
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
    
    for (int i = 0; i < count; i++)
    {
        NSString *title = array[i];
        CGRect rect = CGRectMake(i * width, 0.0, width, CGRectGetHeight(self.bounds));
        
        SYButton *button = [SYButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor clearColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [button setTitle:title forState:UIControlStateNormal];
        button.frame = rect;
//        [button setImage:kImageWithName(@"accessoryArrow_down") forState:UIControlStateNormal];
//        [button setImage:kImageWithName(@"accessoryArrow_up") forState:UIControlStateSelected];
        
        button.userInteractionEnabled = YES;
        button.selected = NO;
        
        button.tag = i + tagButton;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
    }
    
    self.previousTag = tagButton + 0;
    SYButton *button = (SYButton *)[self viewWithTag:self.previousTag];
    button.userInteractionEnabled = NO;
    button.selected = YES;
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0.0, (CGRectGetHeight(self.bounds) - 1.0), width, 2.0)];
    [self addSubview:self.lineView];
    self.lineView.backgroundColor = [UIColor redColor];

    self.lineView.hidden = !self.showScrollLine;
}

- (void)setButtonColor
{
    if (_colorSelected)
    {
        for (int i = 0; i < _titles.count; i++)
        {
            SYButton *button = (SYButton *)[self viewWithTag:i + tagButton];
            [button setTitleColor:_colorSelected forState:UIControlStateHighlighted];
            [button setTitleColor:_colorSelected forState:UIControlStateSelected];
        }
    }
    
    if (_colorNormal)
    {
        for (int i = 0; i < _titles.count; i++)
        {
            SYButton *button = (SYButton *)[self viewWithTag:i + tagButton];
            [button setTitleColor:_colorNormal forState:UIControlStateNormal];
        }
    }
}

#pragma mark - 响应

- (void)buttonAction:(UIButton *)button
{
    [self buttonActionLine:button];
    [self buttonActionStatus:button];
    
    if (self.buttonClick)
    {
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
            rect.origin.x = button.frame.origin.x;
            self.lineView.frame = rect;
        }];
    }
}

- (void)buttonActionStatus:(UIButton *)button
{
    button.userInteractionEnabled = !button.userInteractionEnabled;
    button.selected = !button.selected;
    button.titleLabel.font = (button.selected ? _titleFontSelected : _titleFont);
    
    SYButton *previousButton = (SYButton *)[self viewWithTag:self.previousTag];
    previousButton.userInteractionEnabled = YES;
    previousButton.selected = ([previousButton isEqual:button] ? button.selected : NO);
    previousButton.titleLabel.font = (previousButton.selected ? _titleFontSelected : _titleFont);
    self.previousTag = button.tag;
    
    NSString *title = button.titleLabel.text;
    NSInteger index = self.previousTag - tagButton;
    if ([self.enableTitles containsObject:title])
    {
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

#pragma mark - setter

- (void)setShowScrollLine:(BOOL)showScrollLine
{
    _showScrollLine = showScrollLine;
    self.lineView.hidden = !_showScrollLine;
}

- (void)setTitles:(NSArray *)titles
{
    _titles = titles;
    if (_titles && 0 < titles.count)
    {
        [self setUIWithTitles:_titles];
        
        [self setButtonColor];
    }
}

- (void)setColorSelected:(UIColor *)colorSelected
{
    _colorSelected = colorSelected;
    
    [self setButtonColor];
}

- (void)setColorNormal:(UIColor *)colorNormal
{
    _colorNormal = colorNormal;
    
    [self setButtonColor];
}

- (void)setImageTypeArray:(NSArray *)imageTypeArray
{
    _imageTypeArray = imageTypeArray;
    if (_imageTypeArray)
    {
        for (int i = 0; i < _imageTypeArray.count; i++)
        {
            NSDictionary *dict = _imageTypeArray[i];
            UIImage *imageNormal = dict[keyImageNormal];
            UIImage *imageSelected = dict[keyImageSelected];
            
            SYButton *button = (SYButton *)[self viewWithTag:i + tagButton];
            [button setImage:imageNormal forState:UIControlStateNormal];
            [button setImage:imageSelected forState:UIControlStateSelected];
        }
    }
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    if (_titleFont)
    {
        for (int i = 0; i < _titles.count; i++)
        {
            SYButton *button = (SYButton *)[self viewWithTag:i + tagButton];
            button.titleLabel.font = (button.selected ? _titleFontSelected : _titleFont);
        }
    }
}

- (void)setTitleFontSelected:(UIFont *)titleFontSelected
{
    _titleFontSelected = titleFontSelected;
    if (_titleFontSelected)
    {
        for (int i = 0; i < _titles.count; i++)
        {
            SYButton *button = (SYButton *)[self viewWithTag:i + tagButton];
            button.titleLabel.font = (button.selected ? _titleFontSelected : _titleFont);
        }
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    
    SYButton *button = (SYButton *)[self viewWithTag:_selectedIndex + tagButton];
    if (button)
    {
        // 改变按钮状态，不响应交互事件
        [self buttonActionStatus:button];
        [self buttonActionLine:button];
    }
}

/// 重置按钮标题
- (void)setTitleButton:(NSString *)title index:(NSInteger)index
{
    if ((!title || 0 >= title.length) || (0 > index || (self.subviews.count - 1) <= index))
    {
        return;
    }
    
    SYButton *button = (SYButton *)[self viewWithTag:index + tagButton];
    [button setTitle:title forState:UIControlStateNormal];
}

@end
