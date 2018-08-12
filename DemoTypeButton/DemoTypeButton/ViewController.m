//
//  ViewController.m
//  DemoTypeButton
//
//  Created by zhangshaoyu on 15/12/22.
//  Copyright © 2015年 zhangshaoyu. All rights reserved.
//

#import "ViewController.h"
#import "SYTypeButtonView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"多样式按钮";
    
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setUI
{
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    
    // 1
    SYTypeButtonView *buttonView = [[SYTypeButtonView alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.bounds), heightTypeButtonView) view:self.view];
    buttonView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    buttonView.buttonClick = ^(NSInteger index, BOOL isDescending){
        NSLog(@"click index %ld, isDescending %d", index, isDescending);
    };
    buttonView.titleColorNormal = [UIColor blackColor];
    buttonView.titleColorSelected = [UIColor greenColor];
    buttonView.titles = @[@"综合", @"销量", @"价格"];
    buttonView.enableTitles = @[@"价格"];
    NSDictionary *dict01 = [NSDictionary dictionary];
    NSDictionary *dict02 = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"accessoryArrow_down"], keyImageNormal, [UIImage imageNamed:@"accessoryArrow_downSelected"], keyImageSelected, nil];
    NSDictionary *dict03 = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"priceImage_normal"], keyImageNormal, [UIImage imageNamed:@"priceImage_down"], keyImageSelected, [UIImage imageNamed:@"priceImage_up"], keyImageSelectedDouble, nil];
    buttonView.imageTypeArray = @[dict01, dict02, dict03];
    buttonView.selectedIndex = -1;
    
    UIView *currentView = buttonView;
    
    // 2
    SYTypeButtonView *buttonView2 = [[SYTypeButtonView alloc] initWithFrame:CGRectMake(0.0, (currentView.frame.size.height + currentView.frame.origin.y + 20.0), CGRectGetWidth(self.view.bounds), heightTypeButtonView) view:self.view];
    buttonView2.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    buttonView2.buttonClick = ^(NSInteger index, BOOL isDescending){
        NSLog(@"click index %ld, isDescending %d", index, isDescending);
    };
    buttonView2.showScrollLine = YES;
    buttonView2.titleColorNormal = [UIColor blackColor];
    buttonView2.titleColorSelected = [UIColor blueColor];
    buttonView2.titles = @[@"综合", @"销量", @"价格"];
    buttonView2.enableTitles = @[@"综合", @"销量", @"价格"];
    NSDictionary *dict023 = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"priceImage_normal"], keyImageNormal, [UIImage imageNamed:@"priceImage_down"], keyImageSelected, [UIImage imageNamed:@"priceImage_up"], keyImageSelectedDouble, nil];
    buttonView2.imageTypeArray = @[dict023, dict023, dict023];
    [buttonView2 setTypeButton:NO index:2];
    
    currentView = buttonView2;
    
    // 3
    SYTypeButtonView *buttonView3 = [[SYTypeButtonView alloc] initWithFrame:CGRectMake(0.0, (currentView.frame.size.height + currentView.frame.origin.y + 20.0), CGRectGetWidth(self.view.bounds), heightTypeButtonView) view:self.view];
    buttonView3.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    buttonView3.buttonClick = ^(NSInteger index, BOOL isDescending){
        NSLog(@"click index %ld, isDescending %d", index, isDescending);
    };
    buttonView3.titleColorNormal = [UIColor blackColor];
    buttonView3.titleColorSelected = [UIColor greenColor];
    buttonView3.showScrollLine = YES;
    buttonView3.scrollLineColor = [UIColor greenColor];
    buttonView3.adjustScrollLineWidth = YES;    
    buttonView3.titles = @[@"综合排序", @"销量", @"价格", @"区域", @"品牌", @"高评价"];
    buttonView3.selectedIndex = 4;
}

@end
