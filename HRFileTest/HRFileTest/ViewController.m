//
//  ViewController.m
//  HRFileTest
//
//  Created by ZhangHeng on 15/7/25.
//  Copyright (c) 2015年 ZhangHeng. All rights reserved.
//

#import "ViewController.h"
#import "HRFileListVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)jumpView:(id)sender{
    HRFileListVC *list = [[HRFileListVC alloc] initWithFilePath:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:list];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
