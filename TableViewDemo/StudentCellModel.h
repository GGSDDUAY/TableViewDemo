//
//  StudentCellModel.h
//  TableViewDemo
//
//  Created by jkt on 16/4/1.
//  Copyright © 2016年 czc. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface StudentCellModel : NSObject
@property (nonatomic, strong) NSString *headerImageUrl;
@property (nonatomic, strong) NSString *nameString;

/**
 *  学员班级类型（...）
 */
@property (nonatomic, strong) NSString *classType;
/**
 *  学员科目状态
 */
@property (nonatomic, strong) NSString *subjectType;
/**
 *  学员来源
 */
@property (nonatomic, strong) NSString *sourceType;
/**
 *  学员训练学时
 */
@property (nonatomic, strong) NSString *trainTimeString;
/**
 *  学员手机号码
 */
@property (nonatomic, strong) NSString *phone;
/**
 *  是否已经关心
 */
@property (nonatomic, assign) BOOL hasRegard;//是否已经关心
/**
 *  是否有请求更新
 */
@property (nonatomic, assign) BOOL hasNewRequest;//是否有请求更新

/**
 *  cell高度（默认是62.0f）
 */
@property (nonatomic, assign) CGFloat cellHeight;




@end
