//
//  ViewController.m
//  TableViewDemo
//
//  Created by jkt on 16/4/1.
//  Copyright © 2016年 czc. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "SWTableViewCell.h"
#import "StudentCell.h"
#import "StudentCellModel.h"
#import "StudentHeaderView.h"
#import "StudentHeaderViewModel.h"


static NSString *StudentCellId = @"StudentCellId";
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,SWTableViewCellDelegate>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *tableHeaderViewModelArray;
@property (nonatomic, strong) NSMutableArray *tableSeactionModelArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initTableView];
}

#pragma mark -view

- (void)initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    [_tableView registerClass:[StudentCell class] forCellReuseIdentifier:StudentCellId];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark -data
- (void)initData{
   
    self.tableHeaderViewModelArray = [[NSMutableArray alloc]init];
    self.tableSeactionModelArray = [[NSMutableArray alloc]init];
    [self reloadData];
    
}

- (void)reloadData{
    
    [self.tableHeaderViewModelArray removeAllObjects];
    [self.tableSeactionModelArray removeAllObjects];
    //headerViewModel
    NSArray *headerViewTitleArray = @[@"新增学员",@"科目一学员",@"科目二学员",@"科目三学员",@"科目四学员",@"已结业学员"];
    for (int i = 0; i < headerViewTitleArray.count; i++) {
        NSString *titleString = [headerViewTitleArray objectAtIndex:i];
        StudentHeaderViewModel *model = [[StudentHeaderViewModel alloc]init];
        model.titleString = titleString;
        model.totalStudentString = [NSString stringWithFormat:@"%d",3 + i];
        model.totalNewRequestStudentString = [NSString stringWithFormat:@"%d",i + 1];
        model.isExpand = NO;
        model.hasNewRequest = YES;
        model.headerViewHeight = 50.0f;
        [self.tableHeaderViewModelArray addObject:model];
    }
    
    //cellModel
    NSString *nameFormat = @"张文静";
    NSString *phone = @"110";
    for (int i = 0; i < headerViewTitleArray.count; i++) {
        StudentHeaderViewModel *model = [self.tableHeaderViewModelArray objectAtIndex:i];
        NSMutableArray *modelArray = [[NSMutableArray alloc]init];
        for (int j = 0; j < [model.totalStudentString intValue]; j++) {
            StudentCellModel *cellModel = [[StudentCellModel alloc]init];
            cellModel.headerImageUrl = @"";
            cellModel.nameString = [NSString stringWithFormat:@"%@%d,%d",nameFormat,i,j];
            cellModel.classType = @"";
            cellModel.sourceType = @"";
            cellModel.subjectType = [SubjectTypeArray objectAtIndex:i];
            cellModel.trainTimeString = [NSString stringWithFormat:@"已学%d次，累计%d次",i,j];
            cellModel.phone = phone;
            cellModel.cellHeight = 62.0f;
            if (j < i + 1) {
                cellModel.hasNewRequest = YES;
            }else{
                cellModel.hasNewRequest  = NO;
            }
            
            [modelArray addObject:cellModel];
        }
        [self.tableSeactionModelArray addObject:modelArray];
    }
    [self.tableView reloadData];
}

#pragma mark -UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.tableHeaderViewModelArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    StudentHeaderViewModel *headerViewModel = [self.tableHeaderViewModelArray objectAtIndex:section];
    if (headerViewModel.isExpand) {
        return [[self.tableSeactionModelArray objectAtIndex:section] count];
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    StudentCellModel *cellModel = [[self.tableSeactionModelArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    return cellModel.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    StudentHeaderViewModel *headerViewModel = [self.tableHeaderViewModelArray objectAtIndex:section];
    return headerViewModel.headerViewHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StudentCell *cell = [self.tableView dequeueReusableCellWithIdentifier:StudentCellId];
    StudentCellModel *cellModel = [[self.tableSeactionModelArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    [cell initWithModel:cellModel];
    
    [cell setLeftUtilityButtons:[self leftButtonsWithIndex:indexPath.section] WithButtonWidth:52.0f];
    [cell setRightUtilityButtons:[self rightButtonsWithCellModel:cellModel] WithButtonWidth:100.0f];
    cell.delegate = self;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    StudentHeaderView *headerView  = [[StudentHeaderView alloc]initWithFrame:CGRectZero];
    StudentHeaderViewModel *headerViewModel = [self.tableHeaderViewModelArray objectAtIndex:section];
    [headerView initWithModel:headerViewModel];
    // 如果处于展开状态，则图标进行90度的旋转
    if (headerView.model.isExpand) {
        headerView.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI / 2);
    }else{
        headerView.arrowImageView.transform = CGAffineTransformMakeRotation(0);
    }
    //添加手势
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureRecognizerAction:)];
    [headerView addGestureRecognizer:tapGestureRecognizer];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark -action
- (void)tapGestureRecognizerAction:(UITapGestureRecognizer *)tap{
    StudentHeaderView *headerView = (StudentHeaderView *)[tap view];
    headerView.model.isExpand = !headerView.model.isExpand;
    
    //重载当前section
    NSInteger index = [self.tableHeaderViewModelArray indexOfObject:headerView.model];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark -other

- (NSArray *)leftButtonsWithIndex:(NSInteger)index{
    
    UIFont *font = [UIFont systemFontOfSize:12];
    NSMutableArray *leftUtilityButtons = [NSMutableArray new];
    NSArray *titleArray = @[@"科一",@"科二",@"科三",@"科四",@"结业"];
    for (NSInteger i = 0 ; i < titleArray.count; i++) {
        UIColor *color = [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0];
        // 例如：现在的状态是科目一，那么按理下一个状态该是科目二 ，所以把科目二的按钮颜色和其他的颜色做区分
        if (i == index) {
            color = [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f];
        }
        if (index != 0) {
            if (i == index - 1) {
                //当前状态的颜色
                color = [UIColor orangeColor];
            }
        }
        [leftUtilityButtons sw_addUtilityButtonWithColor:color title:[titleArray objectAtIndex:i] font:font];
    }
    return leftUtilityButtons;
}

- (NSArray *)rightButtonsWithCellModel:(StudentCellModel *)model{
    NSString *string = @"特别关心";
    UIColor *color = [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f];
    //如果状态是"已经关心",那么显示的就是"取消关心"
    if (model.hasRegard) {
        string = @"取消关心";
        color = [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0];
    }
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:color title:string font:[UIFont systemFontOfSize:12]];
    return rightUtilityButtons;
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index{
    StudentCell *studentCell = (StudentCell *)cell;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:studentCell];
    
    //选择的是当前所处的状态，弹出提示框并返回
    if (index + 1 == indexPath.section) {
        NSArray *titleArray = @[@"科一",@"科二",@"科三",@"科四",@"结业"];
        NSString *state = [titleArray objectAtIndex:index];
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"错误" message:[NSString stringWithFormat:@"当前状态已经是%@了!",state] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        return;
    }
    
    StudentCellModel *cellModel = [[self.tableSeactionModelArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    //将model的科目类型设置为对应的科目
    cellModel.subjectType = [SubjectTypeArray objectAtIndex:index + 1];
    //修改状态之后就将将hasNewRequest置为NO
    if (cellModel.hasNewRequest) {
        cellModel.hasNewRequest = NO;
        StudentHeaderViewModel *headerViewModel = [self.tableHeaderViewModelArray objectAtIndex:indexPath.section];
        headerViewModel.totalNewRequestStudentString = [NSString stringWithFormat:@"%d",([headerViewModel.totalNewRequestStudentString intValue] - 1)];
    }
    
    //将cellModle从原来的一组中移除
    NSMutableArray *sectionCellModelArray = [self.tableSeactionModelArray objectAtIndex:index + 1];
    [sectionCellModelArray addObject:cellModel];
    
    //把cellModel加入到新的一组中
    NSMutableArray *sectionCellModelArray2 = [self.tableSeactionModelArray objectAtIndex:indexPath.section];
    [sectionCellModelArray2 removeObject:cellModel];
    
    //重新计算每一组的学员数量
    for (int i = 0; i < self.tableHeaderViewModelArray.count; i++) {
        //只对要重载的2组重新计算学员数量
        if (i == index + 1 || i == indexPath.section) {
            StudentHeaderViewModel *headerViewModel = [self.tableHeaderViewModelArray objectAtIndex:i];
            NSString *string = [NSString stringWithFormat:@"%ld",[[self.tableSeactionModelArray objectAtIndex:i] count]];
            headerViewModel.totalStudentString = string;
            //如果该组的总人数为0，那么将该组收起来
            if ([string intValue] <= 0) {
                headerViewModel.isExpand = NO;
            }
        }
    }

    //重载当前cell所在的组，以及cell将要进入的新的一组的数据
    NSMutableIndexSet *mutableIndexSet = [[NSMutableIndexSet alloc]init];
    [mutableIndexSet addIndex:indexPath.section];
    [mutableIndexSet addIndex:index + 1];
    [self.tableView reloadSections:[mutableIndexSet copy] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index{
    if (index == 0) {
        //将选中的cell的关注状态取反，然后重载该cell
        StudentCell *studentCell = (StudentCell *)cell;
        studentCell.model.hasRegard = !studentCell.model.hasRegard;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:studentCell];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
