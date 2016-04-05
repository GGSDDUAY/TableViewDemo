//
//  StudentHeaderViewModel.h
//  TableViewDemo
//
//  Created by jkt on 16/4/1.
//  Copyright © 2016年 czc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StudentHeaderViewModel : NSObject
@property (nonatomic, strong) NSString *titleString;//标题
/**
 *  学员总数
 */
@property (nonatomic, strong) NSString *totalStudentString;
/**
 *  新请求学员数量
 */
@property (nonatomic, strong) NSString *totalNewRequestStudentString;
/**
 *  是否展开
 */
@property (nonatomic, assign) BOOL isExpand;
/**
 *  是否有新请求
 */
@property (nonatomic, assign) BOOL hasNewRequest;
/**
 *  headerView高度
 */
@property (nonatomic, assign) CGFloat headerViewHeight;



@end
