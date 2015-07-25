//
//  HRFileListVC.h
//  HRFileManager
//
//  Created by ZhangHeng on 15/7/25.
//  Copyright (c) 2015年 ZhangHeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HRSelectFileDelegate <NSObject>

-(void)didselectFilePath:(NSString *)filePath;

@end

@interface HRFileListVC : UIViewController

@property(nonatomic,strong)NSString *currentPath;

//推荐使用初始化方法
-(id)initWithFilePath:(NSString *)filePath;

@end
