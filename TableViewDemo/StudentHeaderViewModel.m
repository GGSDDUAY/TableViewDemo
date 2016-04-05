//
//  StudentHeaderViewModel.m
//  TableViewDemo
//
//  Created by jkt on 16/4/1.
//  Copyright © 2016年 czc. All rights reserved.
//

#import "StudentHeaderViewModel.h"

@implementation StudentHeaderViewModel

//当新的请求学员的数量等于0的时候，hasNewRequest就该为NO了
- (void)setTotalNewRequestStudentString:(NSString *)totalNewRequestStudentString{
    _totalNewRequestStudentString = totalNewRequestStudentString;
    if ([totalNewRequestStudentString intValue] <= 0) {
        _hasNewRequest = NO;
    }else{
        _hasNewRequest = YES;
    }
}

@end
