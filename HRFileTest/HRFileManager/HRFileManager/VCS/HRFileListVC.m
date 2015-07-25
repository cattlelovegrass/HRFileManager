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
#import "HRSelectPathVC.h"

@interface HRFileListVC ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate,HRSelectPathDelegate>{
    NSMutableArray *files;
    HRFileItem  *currentItem;
    BOOL copyOrCut;
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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getFileListAndShow];
}

-(void)getFileListAndShow{
    [files removeAllObjects];
    [files addObjectsFromArray:[HRFileManager getAllItemsListUnderPath:_currentPath]];

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
    return 80;
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

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    currentItem = [files objectAtIndex:indexPath.row];
    UIActionSheet *menuSheet = [[UIActionSheet alloc] initWithTitle:currentItem.fileName delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"复制",@"移动",@"删除",@"重命名", nil];
    [menuSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:{
            DLog(@"复制");
            copyOrCut = YES;
            HRSelectPathVC  *pathVC = [[HRSelectPathVC alloc] initWithSelectType:HRSelectFilePathOnly andPath:nil];
            pathVC.delegate = self;
            if(currentItem.fileType == HRFileTypeFolder){
                pathVC.excludePath = currentItem.filePath;
            }
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:pathVC];
            [self.navigationController presentViewController:nav animated:YES completion:nil];
        }
            break;
        case 1:{
            DLog(@"移动");
            copyOrCut = NO;
            HRSelectPathVC  *pathVC = [[HRSelectPathVC alloc] initWithSelectType:HRSelectFilePathOnly andPath:nil];
            pathVC.delegate = self;
            if(currentItem.fileType == HRFileTypeFolder){
                pathVC.excludePath = currentItem.filePath;
            }
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:pathVC];
            [self.navigationController presentViewController:nav animated:YES completion:nil];
        }
            break;
        case 2:{
            DLog(@"删除");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定删除" message:@"文件删除后无法恢复，是否确认删除" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        }
            break;
        case 3:{
            DLog(@"重命名");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"重命名" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.alertViewStyle = UIAlertViewStylePlainTextInput;
            [[alert textFieldAtIndex:0] setText:[currentItem.fileName stringByDeletingPathExtension]];
            [alert show];
        }
            break;
        default:{
            DLog(@"取消");
            currentItem = nil;
        }
            break;
    }
}

//删除和重命名的功能
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(alertView.alertViewStyle == UIAlertViewStylePlainTextInput){
        switch (buttonIndex) {
            case 0:{
                DLog(@"modify canceled");
            }
                break;
            case 1:{
                NSString *name = [alertView textFieldAtIndex:0].text;
                if([name isEqualToString:currentItem.fileName]){
                    DLog(@"Name not modified");
                }else{
                    [HRFileManager renameFileWithName:[name stringByAppendingString:[self getFileFormatWithName:currentItem.fileName]] atPath:currentItem.filePath];
                    [self getFileListAndShow];
                }
            }
                break;
                
            default:
                break;
        }
    }else{
        switch (buttonIndex) {
            case 0:{
                currentItem = nil;
            }
                break;
            case 1:{
                [HRFileManager deleteFileAtPath:currentItem.filePath];
                currentItem = nil;
                [self getFileListAndShow];
            }
                break;
                
            default:
                break;
        }
    }
}

-(void)didSelectFilePath:(NSString *)path{
    NSString *destinationPath = [path stringByAppendingPathComponent:[currentItem.filePath lastPathComponent]];
    if(copyOrCut){
        [HRFileManager copyItemFromPath:currentItem.filePath toDestinatonPath:destinationPath];
    }else{
        [HRFileManager moveFileFromPath:currentItem.filePath ToDestinationPath:destinationPath];
    }
    
    currentItem = nil;
    [self getFileListAndShow];
}

//获取后缀名
-(NSString *)getFileFormatWithName:(NSString *)fileName{
    NSArray *tmpArray = [fileName componentsSeparatedByString:@"."];
    
    return [tmpArray lastObject];
}

@end
