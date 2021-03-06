//
//  HRFileItemCell.m
//  HRFileManager
//
//  Created by ZhangHeng on 15/7/25.
//  Copyright (c) 2015年 ZhangHeng. All rights reserved.
//

#import "HRFileItemCell.h"
#import "HRFileManager.h"

@interface HRFileItemCell()

@property(nonatomic,strong)UIImageView  *fileTypeImage;
@property(nonatomic,strong)UILabel      *fileNameLabel;
@property(nonatomic,strong)UILabel      *fileSizeLabel;
@end

@implementation HRFileItemCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self configCell];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

-(void)configCell{
    self.accessoryType = UITableViewCellAccessoryDetailButton;
    _fileTypeImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 60, 60)];
    [self.contentView addSubview:_fileTypeImage];
    
    _fileNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 10, SCREEN_WIDTH - 120, 20)];
    _fileSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 40, SCREEN_WIDTH - 120, 20)];
    
    [self.contentView addSubview:_fileNameLabel];
    [self.contentView addSubview:_fileSizeLabel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setFileItem:(HRFileItem *)fileItem{
    _fileItem = fileItem;
    if(fileItem.fileType == HRFileTypeFile){
        _fileTypeImage.image = [HRFileManager getMyBundleImageWithName:@"File"];
    }else{
        _fileTypeImage.image = [HRFileManager getMyBundleImageWithName:@"Folder"];
    }
    _fileNameLabel.text = fileItem.fileName;
    _fileSizeLabel.text = fileItem.fileSize;
}

@end
