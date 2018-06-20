//
//  ViewController.m
//  NoLineSegmentView
//
//  Created by paperclouds on 2018/6/19.
//  Copyright © 2018年 hechang. All rights reserved.
//

#import "ViewController.h"
#import "MLMSegmentManager.h"

#define UIColorFromRGBA(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(rgbValue & 0x0000FF))/255.0 alpha:alphaValue]

@interface ViewController ()

@property (nonatomic, strong) NSArray *titleArray; //标题
@property (nonatomic, strong) MLMSegmentHead *segHead;
@property (nonatomic, strong) MLMSegmentScroll *segScroll;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"分段选择";
    [self createUI];
}

#pragma mark - 数据源
- (NSArray *)vcArr:(NSInteger)count {
    NSMutableArray *arr = [NSMutableArray array];
    UIViewController *oneViewC = [UIViewController new];
    [arr addObject:oneViewC];
    
    UIViewController *twoViewC = [UIViewController new];
    [arr addObject:twoViewC];
    
    UIViewController *threeViewC = [UIViewController new];
    [arr addObject:threeViewC];
    [arr addObject:threeViewC];
    [arr addObject:threeViewC];
    [arr addObject:threeViewC];
    return arr;
}

- (void)createUI{
    self.titleArray = @[@"全部",@"已预订",@"出租中",@"结算中",@"已完成"];
    UIView *segmentView = [[UIView alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-30, 60)];
    _segHead = [[MLMSegmentHead alloc]initWithFrame:CGRectMake(20, 64, SCREEN_WIDTH-30, 60) titles:self.titleArray headStyle:SegmentHeadStyleSlide layoutStyle:MLMSegmentLayoutDefault];
    _segHead.fontSize = 14;
    _segHead.headColor = [UIColor whiteColor]; //分段控件背景颜色
    _segHead.slideColor =  UIColorFromRGBA(0x333333, 1); //选中分段背景颜色
    _segHead.selectColor = [UIColor whiteColor]; //选中分段文字颜色
    _segHead.deSelectColor = UIColorFromRGBA(0x333333, 1); //未选中分段文字颜色
    _segHead.deSelectBackColor = UIColorFromRGBA(0xcccdd2, 1); //未选中分段背景颜色
    _segHead.slideCorner = 4;
    _segHead.slideHeight = 32;
    _segHead.lineHeight = 0;
    _segHead.bottomLineColor = [UIColor whiteColor];
    
    
    _segScroll = [[MLMSegmentScroll alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(segmentView.frame), SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(segmentView.frame)) vcOrViews:[self vcArr:self.titleArray.count]];
    _segScroll.loadAll = NO;
    _segScroll.showIndex = 0;
    
    [MLMSegmentManager associateHead:_segHead withScroll:_segScroll completion:^{
        [self.view addSubview:segmentView];
        [self.view addSubview:self.segScroll];
        [self.view addSubview:self.segHead];
    }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
