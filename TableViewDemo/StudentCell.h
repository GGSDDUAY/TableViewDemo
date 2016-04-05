//
//  StudentCell.h
//  TableViewDemo
//
//  Created by jkt on 16/4/1.
//  Copyright © 2016年 czc. All rights reserved.
//

#import "SWTableViewCell.h"
#import "StudentCellModel.h"

typedef void(^StudentCellBlock)(StudentCellModel *model);
@interface StudentCell : SWTableViewCell

@property (nonatomic, strong) StudentCellModel *model;
@property (nonatomic, copy) StudentCellBlock block;
- (void)initWithModel:(StudentCellModel *)model;

@end
