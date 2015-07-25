//
//  ViewController.m
//  FileTest
//
//  Created by ZhangHeng on 15/7/25.
//  Copyright (c) 2015年 ZhangHeng. All rights reserved.
//

#import "ViewController.h"
#import "HRFileManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *items = [HRFileManager getAllItemsListUnderPath:nil];
    NSLog(@"%@",items);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
