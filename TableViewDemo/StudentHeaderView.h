//
//  StudentHeaderView.h
//  TableViewDemo
//
//  Created by jkt on 16/4/1.
//  Copyright © 2016年 czc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudentHeaderViewModel.h"

@interface StudentHeaderView : UIView
@property (nonatomic, strong) UIImageView *arrowImageView;//箭头
@property (nonatomic, strong) StudentHeaderViewModel *model;
- (void)initWithModel:(StudentHeaderViewModel *)model;

@end
