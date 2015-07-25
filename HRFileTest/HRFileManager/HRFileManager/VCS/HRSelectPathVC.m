//
//  HRSelectPathVC.m
//  HRFileManager
//
//  Created by ZhangHeng on 15/7/25.
//  Copyright (c) 2015年 ZhangHeng. All rights reserved.
//

#import "HRSelectPathVC.h"
#import "HRFileItemCell.h"
#import "HRFileManager.h"

@interface HRSelectPathVC ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *fileListView;
    NSMutableArray *files;
}
@property(nonatomic,assign)HRSelectFileType selectType;
@end

@implementation HRSelectPathVC

-(id)initWithSelectType:(HRSelectFileType)selectType andPath:(NSString *)path{
    self = [super init];
    if(self){
        self.selectType = selectType;
        self.path = path;
        if(!self.path || self.path.length == 0){
            self.path = DOCUMENT_PATH;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    files = [NSMutableArray new];
    if(!_path){
        self.title = @"我的文档";
    }else{
        self.title = [_path lastPathComponent];
    }
    
    //只有为选择路径时才需要完成，选择文件不需要
    if(_selectType == HRSelectFilePathOnly){
        UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(canceledSelect)];
        UIBarButtonItem *finish = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(getTheDealingPath)];
        
        self.navigationItem.rightBarButtonItems = @[cancel,finish];
    }else{
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(canceledSelect)];
    }
    
    fileListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    [self.view addSubview:fileListView];
    fileListView.delegate = self;
    fileListView.dataSource = self;
    [fileListView registerClass:[HRFileItemCell class] forCellReuseIdentifier:@"selectItemCell"];
    
    [self loadAllData];
}

-(void)loadAllData{
    if(!_path || _path.length == 0){
        _path = DOCUMENT_PATH;
    }
    [files removeAllObjects];
    if(_selectType == HRSelectFilePathOnly){
        [files addObjectsFromArray:[HRFileManager getFolderListUnderPath:_path]];
    }else{
        [files addObjectsFromArray:[HRFileManager getAllItemsListUnderPath:_path]];
    }
    
    for(HRFileItem *item in files){
        if([item.filePath isEqualToString:_excludePath]){
            [files removeObject:item];
            break;
        }
    }
    
    [fileListView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- tableView function
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HRFileItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectItemCell"];
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
    if(item.fileType == HRFileTypeFolder){
        Class clazz = NSClassFromString(NSStringFromClass([self class]));
        HRSelectPathVC *nextVC = [[clazz alloc] initWithSelectType:_selectType andPath:item.filePath];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else{
        if(_delegate && [_delegate respondsToSelector:@selector(didSelectFilePath:)]){
            [_delegate didSelectFilePath:item.filePath];
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

-(void)getTheDealingPath{
    if(_delegate && [_delegate respondsToSelector:@selector(didSelectFilePath:)])
        [_delegate didSelectFilePath:self.path];
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)canceledSelect{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
