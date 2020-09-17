//
//  ZYTextField+HistoryDataList.m
//  TFRememberHistoryInputContentWithDropList
//
//  Created by Jobs on 2020/9/17.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "ZYTextField+HistoryDataList.h"
#import "TableViewAnimationKitHeaders.h"

@interface HistoryDataListTBVCell : UITableViewCell

@property(nonatomic,strong)UILabel *contentLabel;

@end

@implementation HistoryDataListTBVCell

+(instancetype)cellWith:(UITableView *)tableView{
    HistoryDataListTBVCell *cell = (HistoryDataListTBVCell *)[tableView dequeueReusableCellWithIdentifier:@"InfoTBVCell"];
    if (!cell) {
        cell = [[HistoryDataListTBVCell alloc]initWithStyle:UITableViewCellStyleSubtitle
                                            reuseIdentifier:ReuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = HEXCOLOR(0x242A37);
    }return cell;
}

-(void)richElementsInCellWithModel:(id _Nullable)model{
    self.contentLabel.alpha = 1;
}

#pragma mark —— lazyLoad
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = UILabel.new;
        _contentLabel.backgroundColor = kClearColor;
        [self addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }return _contentLabel;
}

@end

@implementation ZYTextField (HistoryDataList)

static char *ZYTextField_HistoryDataList_tableview = "ZYTextField_HistoryDataList_tableview";
static char *ZYTextField_HistoryDataList_isSelected = "ZYTextField_HistoryDataList_isSelected";
static char *ZYTextField_HistoryDataList_tableviewCellHeight = "ZYTextField_HistoryDataList_tableviewCellHeight";
static char *ZYTextField_HistoryDataList_isShowHistoryDataList = "ZYTextField_HistoryDataList_isShowHistoryDataList";
static char *ZYTextField_HistoryDataList_ZYTextFieldTapGR = "ZYTextField_HistoryDataList_ZYTextFieldTapGR";
static char *ZYTextField_HistoryDataList_dataArr = "ZYTextField_HistoryDataList_dataArr";

@dynamic tableview;
@dynamic isSelected;
@dynamic tableviewCellHeight;
@dynamic isShowHistoryDataList;
@dynamic ZYTextFieldTapGR;
@dynamic dataArr;

-(void)closeList{
    [self endEditing:YES];
    self.isSelected = NO;
}

-(void)ZYTextFieldTap:(UITapGestureRecognizer *)tapGR{
    self.isSelected = !self.isSelected;
    self.isShowHistoryDataList = self.isSelected;
    self.tableview.alpha = self.isShowHistoryDataList;
    [TableViewAnimationKit showWithAnimationType:2
                                       tableView:self.tableview];
}
#pragma mark —— UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return true;//不遵守此协议，输入框无法输入
}
#pragma mark —————————— UITableViewDelegate,UITableViewDataSource ——————————
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.tableviewCellHeight;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@" 你点击了我");
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;//
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoryDataListTBVCell *cell = [HistoryDataListTBVCell cellWith:tableView];
    cell.contentView.backgroundColor = RandomColor;
    [cell richElementsInCellWithModel:nil];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
#pragma mark —— @property(nonatomic,strong)NSArray *dataArr;
-(NSArray *)dataArr{
    NSArray *DataArr = objc_getAssociatedObject(self, ZYTextField_HistoryDataList_dataArr);
    return DataArr;
}

-(void)setDataArr:(NSArray *)dataArr{
    objc_setAssociatedObject(self,
                             ZYTextField_HistoryDataList_dataArr,
                             dataArr,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)UITapGestureRecognizer *ZYTextFieldTapGR;
-(UITapGestureRecognizer *)ZYTextFieldTapGR{
    UITapGestureRecognizer *textFieldTapGR = objc_getAssociatedObject(self, ZYTextField_HistoryDataList_ZYTextFieldTapGR);
    if (!textFieldTapGR) {
        textFieldTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                 action:@selector(ZYTextFieldTap:)];
        textFieldTapGR.delegate = self;
        textFieldTapGR.numberOfTapsRequired = 1;//tap次数
        textFieldTapGR.numberOfTouchesRequired = 1;//手指数
        [self addGestureRecognizer:textFieldTapGR];
        objc_setAssociatedObject(self,
                                 ZYTextField_HistoryDataList_ZYTextFieldTapGR,
                                 textFieldTapGR,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return textFieldTapGR;
}

-(void)setZYTextFieldTapGR:(UITapGestureRecognizer *)ZYTextFieldTapGR{
    objc_setAssociatedObject(self,
                             ZYTextField_HistoryDataList_ZYTextFieldTapGR,
                             ZYTextFieldTapGR,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark —— @property(nonatomic,strong)UITableView *tableview;
-(UITableView *)tableview{
    UITableView *Tableview = objc_getAssociatedObject(self, ZYTextField_HistoryDataList_tableview);
    if (!Tableview) {
        Tableview = UITableView.new;
        Tableview.backgroundColor = kClearColor;
        Tableview.delegate = self;
        Tableview.dataSource = self;
        [self.superview addSubview:Tableview];
        [Tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_bottom);
            make.left.right.equalTo(self);
            make.height.mas_equalTo(4 * 50);
        }];
        objc_setAssociatedObject(self,
                                 ZYTextField_HistoryDataList_tableview,
                                 Tableview,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return Tableview;
}

-(void)setTableview:(UITableView *)tableview{
    objc_setAssociatedObject(self,
                             ZYTextField_HistoryDataList_tableview,
                             tableview,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)BOOL isSelected;
-(void)setIsSelected:(BOOL)isSelected{
    self.isShowHistoryDataList = !isSelected;
    objc_setAssociatedObject(self,
                             ZYTextField_HistoryDataList_isSelected,
                             [NSNumber numberWithBool:isSelected],
                             OBJC_ASSOCIATION_ASSIGN);
}

-(BOOL)isSelected{
    return [objc_getAssociatedObject(self, ZYTextField_HistoryDataList_isSelected) boolValue];
}
#pragma mark —— @property(nonatomic,assign)CGFloat tableviewCellHeight;
-(CGFloat)tableviewCellHeight{
    CGFloat TableviewCellHeight = [objc_getAssociatedObject(self, ZYTextField_HistoryDataList_tableviewCellHeight) floatValue];
    if (TableviewCellHeight == 0) {
        TableviewCellHeight = 50;
        objc_setAssociatedObject(self,
                                 ZYTextField_HistoryDataList_tableviewCellHeight,
                                 [NSNumber numberWithFloat:TableviewCellHeight],
                                 OBJC_ASSOCIATION_ASSIGN);
    }return TableviewCellHeight;
}

-(void)setTableviewCellHeight:(CGFloat)tableviewCellHeight{
    objc_setAssociatedObject(self,
                             ZYTextField_HistoryDataList_tableviewCellHeight,
                             [NSNumber numberWithFloat:tableviewCellHeight],
                             OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark —— @property(nonatomic,assign)BOOL isShowHistoryDataList;//是否显示下拉历史数据列表
-(BOOL)isShowHistoryDataList{
    return [objc_getAssociatedObject(self, ZYTextField_HistoryDataList_isShowHistoryDataList) boolValue];
}

-(void)setIsShowHistoryDataList:(BOOL)isShowHistoryDataList{
    self.tableview.alpha = !isShowHistoryDataList;
    objc_setAssociatedObject(self,
                             ZYTextField_HistoryDataList_isShowHistoryDataList,
                             [NSNumber numberWithBool:isShowHistoryDataList],
                             OBJC_ASSOCIATION_ASSIGN);
}

@end
