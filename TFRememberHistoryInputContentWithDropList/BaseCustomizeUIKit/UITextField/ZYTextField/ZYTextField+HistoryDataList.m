//
//  ZYTextField+HistoryDataList.m
//  TFRememberHistoryInputContentWithDropList
//
//  Created by Jobs on 2020/9/17.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "ZYTextField+HistoryDataList.h"

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

@dynamic tableview;
@dynamic isSelected;
@dynamic tableviewCellHeight;

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
    return 10;//
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


@end
