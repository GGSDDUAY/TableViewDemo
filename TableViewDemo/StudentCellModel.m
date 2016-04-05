//
//  StudentCellModel.m
//  TableViewDemo
//
//  Created by jkt on 16/4/1.
//  Copyright © 2016年 czc. All rights reserved.
//

#import "StudentCellModel.h"

@implementation StudentCellModel
@synthesize cellHeight = _cellHeight;

- (instancetype)init{
    self = [super init];
    if (self) {
      
    }
    return self;
}
- (CGFloat)cellHeight{
    return 62.0f;
}
- (void)setCellHeight:(CGFloat)cellHeight{
    if (cellHeight > 0.0f) {
        _cellHeight = cellHeight;
    }else{
        _cellHeight = 62.0f;
    }
}


@end
