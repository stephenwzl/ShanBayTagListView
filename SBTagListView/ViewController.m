//
//  ViewController.m
//  SBTagListView
//
//  Created by 王志龙 on 15/9/16.
//  Copyright © 2015年 王志龙. All rights reserved.
//

#import "ViewController.h"
#import "SBTagListView.h"
@interface ViewController ()<SBTagListViewDelegate>
@property (strong, nonatomic) SBTagListView *list;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@"ehllo",@"asdc",@"asdhakdaskd",@"gsdfvfsdf",@"asdcjdf",@"asdclkja"]];
    self.list = [[SBTagListView alloc] initWithWidth:300 contentArray:array];
    self.list.center = self.view.center;
    [self.view addSubview:self.list];
    self.list.delegate = self;
    self.list.layer.borderColor = [UIColor blackColor].CGColor;
    self.list.layer.borderWidth = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didSelectTagAtIndex:(NSUInteger)index {
//    [self.list removeTagAtIndex:index];
    SBTag *tag = [self.list desequeseTagAtIndex:index];
    [tag setTagType:SBTagTypeError];
}
- (IBAction)resizeAction:(id)sender {
    [self.list resizeToWidth:180];
}

@end
