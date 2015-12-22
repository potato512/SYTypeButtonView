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
    
    SYTypeButtonView *buttonView = [[SYTypeButtonView alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.bounds), heightTypeButtonView) view:self.view];
    buttonView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    buttonView.buttonClick = ^(NSInteger index, BOOL isDescending){
        NSLog(@"click index %ld, isDescending %d", index, isDescending);
    };
    buttonView.titles = @[@"综合", @"销量", @"价格"];
    buttonView.enableTitles = @[@"价格"];
    buttonView.colorNormal = [UIColor blackColor];
    buttonView.colorSelected = [UIColor redColor];
    buttonView.imageTypeArray = @[[NSDictionary dictionary],
                                  [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"accessoryArrow_down"], keyImageNormal, [UIImage imageNamed:@"accessoryArrow_downSelected"], keyImageSelected, nil],
                                  [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"priceImage_normal"], keyImageNormal, [UIImage imageNamed:@"priceImage_down"], keyImageSelected, [UIImage imageNamed:@"priceImage_up"], keyImageSelectedDouble, nil]];
}

@end
