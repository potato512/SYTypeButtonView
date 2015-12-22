# SYTypeButtonView
多样式类型按钮视图

##使用说明

![gif](SYTypeButtonView.gif)

~~~ javaacript

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

~~~
