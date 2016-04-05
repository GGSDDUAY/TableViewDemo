//
//  StudentCell.m
//  DriverCoach
//
//  Created by jkt on 16/4/1.
//  Copyright © 2016年 czc. All rights reserved.
//

#import "StudentCell.h"

@interface StudentCell ()
@property (nonatomic, strong) UIImageView *headerImageView;//头像
@property (nonatomic, strong) UIImageView *stateImageView;//状态
@property (nonatomic, strong) UILabel *nameLabel;//姓名
@property (nonatomic, strong) UILabel *trainTimeLabel;//学时
@property (nonatomic, strong) UIImageView *classTypeImageView;//班级
@property (nonatomic, strong) UIImageView *subjectTypeImageView;//科目
@property (nonatomic, strong) UIImageView *sourceTypeImageView;//来源
@property (nonatomic, strong) UIButton *phoneButton;//手机

@end
@implementation StudentCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    _headerImageView = [[UIImageView alloc]init];
    _nameLabel = [[UILabel alloc]init];
    _classTypeImageView = [[UIImageView alloc]init];
    _subjectTypeImageView = [[UIImageView alloc]init];
    _sourceTypeImageView = [[UIImageView alloc]init];
    _trainTimeLabel = [[UILabel alloc]init];
    _phoneButton = [[UIButton alloc]init];

    
    

    [self.contentView addSubview:_headerImageView];
    [self.contentView addSubview:_nameLabel];
    [self.contentView addSubview:_classTypeImageView];
    [self.contentView addSubview:_subjectTypeImageView];
    [self.contentView addSubview:_sourceTypeImageView];
    [self.contentView addSubview:_trainTimeLabel];
    [self.contentView addSubview:_phoneButton];
    
    UIFont *nameTextFont = [UIFont systemFontOfSize:12];
    UIColor *nameTextColor = [UIColor blackColor];
    UIFont *trainTimeTextFont = [UIFont systemFontOfSize:10];
    UIColor *trainTimeTextColor = [UIColor grayColor];
    
    _nameLabel.font = nameTextFont;
    _nameLabel.textColor = nameTextColor;
    
    _trainTimeLabel.font = trainTimeTextFont;
    _trainTimeLabel.textColor = trainTimeTextColor;
    
    [_phoneButton addTarget:self action:@selector(phoneButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_phoneButton setImage:[UIImage imageNamed:@"Student_phone"] forState:UIControlStateNormal];

    
    //头像
    CGFloat padding = 10;
    //    60 * 61
    [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(padding);
        make.size.mas_equalTo(CGSizeMake(30, 30.5f));
        make.centerY.equalTo(self.contentView);
    }];
    
    //状态
    //16 * 16
    CGSize size = CGSizeMake(8.0f, 8.0f);
    _stateImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:_stateImageView];
    [_stateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(size);
        make.top.and.right.equalTo(_headerImageView);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(padding);
        make.left.equalTo(_headerImageView.mas_right).offset(padding);
        make.height.mas_equalTo(nameTextFont.lineHeight);
        make.width.mas_equalTo(0);
    }];
    
    CGFloat imagePadding = 5.0f;
    //    66 * 28
    [_classTypeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_right).offset(imagePadding);
        make.centerY.equalTo(_nameLabel);
        make.size.mas_equalTo(CGSizeMake(33, 14));
    }];
    
    //    55 * 27
    [_subjectTypeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_classTypeImageView.mas_right).offset(imagePadding);
        make.centerY.equalTo(_nameLabel);
        make.size.mas_equalTo(CGSizeMake(27.5f, 13.5f));
    }];
    
    //    55 * 27
    [_sourceTypeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_subjectTypeImageView.mas_right).offset(imagePadding);
        make.centerY.equalTo(_nameLabel);
        make.size.mas_equalTo(CGSizeMake(27.5f, 13.5f));
    }];
    
    [_trainTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.height.mas_equalTo(trainTimeTextFont.lineHeight);
        make.bottom.equalTo(self.contentView).offset(-padding);
        
    }];
    //    50 * 41
    [_phoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 20.5));
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-padding);
    }];
//     [self setupAutoHeightWithBottomView:_trainTimeLabel bottomMargin: padding];
}

- (void)initWithModel:(StudentCellModel *)model{
    _model = model;

    
    CGFloat padding = 10.0f;

    [_headerImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(padding);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(30, 30.5f));
    }];

    
    //设置姓名文字颜色
    if (model.hasRegard) {
        _nameLabel.textColor = [UIColor orangeColor];
    }else{
        _nameLabel.textColor = [UIColor blackColor];
    }
    
    //设置头像图片
    _headerImageView.image = [UIImage imageNamed:@"CourseDefaultHeaderImage"];
    
    //设置班级图片
    _classTypeImageView.image = [UIImage imageNamed:@"CourseGroupClass"];
    
    //设置科目图片
    [self setSubjectTypeImageViewWithModel:model];
    
    //设置来源图片
    _sourceTypeImageView.image = [UIImage imageNamed:@"CourseSourceFromAPP"];
    
    //设置学时内容
    _trainTimeLabel.text = model.trainTimeString;
    
    //设置姓名
    _nameLabel.text = model.nameString;
    
    //设置更新图片
    if (model.hasNewRequest) {//请求更新
        [_stateImageView setImage:[UIImage imageNamed:@"CourseTrainRecordStateHasJoin"]];
    }else{
        [_stateImageView setImage:nil];
    }

 
    //调整nameLabe后面控件的位置
    NSString *nameString = model.nameString;
    CGSize size = [nameString sizeWithFont:self.nameLabel.font inScopeOfSize:CGSizeMake(CGFLOAT_MAX, self.nameLabel.font.lineHeight) lineBreakMode:NSLineBreakByCharWrapping];
    _nameLabel.text = nameString;
    [_nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(size.width);
    }];
    //如果科目图片为空,调整来源图片的位置
    CGFloat imagePadding = 5.0f;
    if (_subjectTypeImageView.image == nil) {
        [_sourceTypeImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_classTypeImageView.mas_right).offset(imagePadding);
            make.centerY.equalTo(_nameLabel);
            make.size.mas_equalTo(CGSizeMake(27.5f, 13.5f));
        }];
    }else{
        [_sourceTypeImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_subjectTypeImageView.mas_right).offset(imagePadding);
            make.centerY.equalTo(_nameLabel);
            make.size.mas_equalTo(CGSizeMake(27.5f, 13.5f));
        }];
    }
    [self.contentView layoutIfNeeded];
}

- (void)setSubjectTypeImageViewWithModel:(StudentCellModel *)model{
    NSString *subjectTypeImageName = nil;
    
    if ([model.subjectType isEqualToString:STUDENT_STATE_SUBJECT_ONE]) {
        
        subjectTypeImageName = @"RecruitStudentsSubjectOne";
    }else if ([model.subjectType isEqualToString:STUDENT_STATE_SUBJECT_TWO]){
        
        subjectTypeImageName = @"RecruitStudentsSubjectTwo";
    }else if ([model.subjectType isEqualToString:STUDENT_STATE_SUBJECT_THREE]){
        
        subjectTypeImageName = @"RecruitStudentsSubjectThree";
    }else if ([model.subjectType isEqualToString:STUDENT_STATE_SUBJECT_FOUR]){
        
        subjectTypeImageName = @"RecruitStudentsSubjectFour";
    }else if ([model.subjectType isEqualToString:STUDENT_STATE_GRADUATE]){
        
        subjectTypeImageName = @"RecruitStudentsGraduate";
    }
    if (subjectTypeImageName != nil) {
        
        _subjectTypeImageView.image = [UIImage imageNamed:subjectTypeImageName];
    }else{
        
        _subjectTypeImageView.image = nil;
    }
}

- (void)phoneButtonAction:(id)sender{
    if (_model.phone.length > 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"是否拨打该学员电话？" message:_model.phone delegate:self cancelButtonTitle:@"拨打" otherButtonTitles:@"取消", nil];
        [alert show];
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",alertView.message];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
    
}
@end
