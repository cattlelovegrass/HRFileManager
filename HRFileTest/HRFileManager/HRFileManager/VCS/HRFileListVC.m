//
//  HRFileListVC.m
//  HRFileManager
//
//  Created by ZhangHeng on 15/7/25.
//  Copyright (c) 2015年 ZhangHeng. All rights reserved.
//

#import "HRFileListVC.h"
#import "HRFileItemCell.h"
#import "HRFileManager.h"

@interface HRFileListVC ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *files;
}
@property(nonatomic,strong)UITableView *fileList;
@end

@implementation HRFileListVC

-(id)initWithFilePath:(NSString *)filePath{
    self = [super init];
    if(self){
        self.currentPath = filePath;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    files = [NSMutableArray new];
    NSString *documentPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    if(!self.currentPath || self.currentPath.length == 0 || [self.currentPath isEqualToString:documentPath])
        self.title = @"我的文档";
    else{
        self.title = [self.currentPath lastPathComponent];
    }
    
    _fileList = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    [self.view addSubview:_fileList];
    _fileList.delegate = self;
    _fileList.dataSource = self;
    [_fileList registerClass:[HRFileItemCell class] forCellReuseIdentifier:@"fileItem"];
    
    [self getFileListAndShow];
}

-(void)getFileListAndShow{
    files = [HRFileManager getAllItemsListUnderPath:_currentPath].mutableCopy;
    [_fileList reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)setCurrentPath:(NSString *)currentPath{
    _currentPath = currentPath;
    
    NSString *documentPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    if(!self.currentPath || self.currentPath.length == 0 || [self.currentPath isEqualToString:documentPath])
        self.title = @"我的文档";
    else{
        self.title = [self.currentPath lastPathComponent];
    }
}

#pragma mark -tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HRFileItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fileItem"];
    cell.fileItem = [files objectAtIndex:indexPath.row];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return files.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HRFileItem *item = [files objectAtIndex:indexPath.row];
    
    if(item.fileType == HRFileTypeFile){
        if(_delegate && [_delegate respondsToSelector:@selector(didselectFilePath:)])
            [_delegate didselectFilePath:item.filePath];
    }else{
        Class clazz = NSClassFromString(NSStringFromClass([self class]));
        HRFileListVC *newVC = [[clazz alloc] initWithFilePath:item.filePath];
        [self.navigationController pushViewController:newVC animated:YES];
    }
}

@end
