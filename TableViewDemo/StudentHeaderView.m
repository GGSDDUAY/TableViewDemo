//
//  StudentHeaderView.m
//  TableViewDemo
//
//  Created by jkt on 16/4/1.
//  Copyright © 2016年 czc. All rights reserved.
//

#import "StudentHeaderView.h"
CGFloat headerViewPadding = 10.0f;
@interface StudentHeaderView ()

@property (nonatomic, strong) UILabel *titleLabel;//标题
@property (nonatomic, strong) UIImageView *haveNewImageView;//是否有新学员
/**
 *  学员总人数
 */
@property (nonatomic, strong) UILabel *totalStudentsLabel;

@end
@implementation StudentHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupView];
    }
    return self;
}

- (void)setupView{
    UIView *lineView = [[UIView alloc]init];
    [self addSubview:lineView];
    lineView.backgroundColor = THEME_COLOR;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo(self);
        make.height.mas_equalTo(0.5f);
    }];
    
    _arrowImageView = [UIImageView new];
    [self addSubview:_arrowImageView];
    
    _titleLabel = [UILabel new];
    [self addSubview:_titleLabel];
    
    _haveNewImageView = [UIImageView new];
    [self addSubview:_haveNewImageView];
    

    _totalStudentsLabel = [UILabel new];
    [self addSubview:_totalStudentsLabel];
    
//    10 * 10
    [_arrowImageView setImage:[UIImage imageNamed:@"Student_table_header_arrow"]];
    [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(10.0f, 10.0f));
        make.left.mas_equalTo(headerViewPadding);
        make.centerY.equalTo(self);
    }];
    
    UIFont *font = [UIFont systemFontOfSize:10];
    UIColor *color = [UIColor blackColor];
    _titleLabel.font = font;
    _titleLabel.textColor = color;
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_arrowImageView.mas_right).offset(headerViewPadding);
        make.height.mas_equalTo(font.lineHeight);
        make.centerY.equalTo(self);
    }];
    
//    16 * 16
    [_haveNewImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(8.0f, 8.0f));
        make.left.equalTo(_titleLabel.mas_right);
        make.bottom.equalTo(_titleLabel.mas_top);
    }];
    
    UIFont *totalFont = [UIFont systemFontOfSize:8];
    UIColor *totalColor = [UIColor grayColor];
    _totalStudentsLabel.font = totalFont;
    _totalStudentsLabel.textColor = totalColor;
    _totalStudentsLabel.textAlignment = NSTextAlignmentRight;
    [_totalStudentsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-headerViewPadding);
        make.height.mas_equalTo(totalFont.lineHeight);
        make.centerY.equalTo(self);
    }];
    
}

- (void)initWithModel:(StudentHeaderViewModel *)model{
    _model = model;
    _titleLabel.text = model.titleString;
    if (model.hasNewRequest) {
        _haveNewImageView.image = [UIImage imageNamed:@"CourseTrainRecordStateHasJoin"];
    }else{
        _haveNewImageView.image =  nil;
    }
    _totalStudentsLabel.text = [NSString stringWithFormat:@"%@/%@",model.totalNewRequestStudentString,model.totalStudentString];
}


@end
