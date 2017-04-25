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

# 修复完善
## 20170424
* SYTypeButton修改bug
  * 导航动画线初始化时显示bug

## 20170421
* SYTypeButton添加属性及修改默认选项逻辑
  * 默认选项逻辑：只处理选项状态，不响应事件交互。
~~~ javascript
/// 选中后字体大小（默认12。设置标题后设置）
@property (nonatomic, strong) UIFont *titleFontSelected;
~~~