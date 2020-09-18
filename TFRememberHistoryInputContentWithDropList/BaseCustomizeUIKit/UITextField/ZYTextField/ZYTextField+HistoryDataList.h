//
//  ZYTextField+HistoryDataList.h
//  TFRememberHistoryInputContentWithDropList
//
//  Created by Jobs on 2020/9/17.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "ZYTextField.h"

NS_ASSUME_NONNULL_BEGIN

//BaseTableViewer @interface UIView (Chain)

/// 点击出现下拉列表，以显示已记录的历史数据
@interface ZYTextField (HistoryDataList)
<
UITableViewDelegate,
UITableViewDataSource,
UIGestureRecognizerDelegate
>

@property(nonatomic,strong,nullable)UITableView *tableview;
@property(nonatomic,assign)BOOL isShowHistoryDataList;//是否显示下拉历史数据列表
@property(nonatomic,assign)BOOL isSelected;
@property(nonatomic,assign)CGFloat tableviewCellHeight;
@property(nonatomic,strong)UITapGestureRecognizer *ZYTextFieldTapGR;
@property(nonatomic,strong)NSMutableArray *__block dataMutArr;

-(void)actionBlockHistoryDataListTBVCell:(MKDataBlock)historyDataListTBVCellBlock;
-(void)closeList;//关闭下拉列表

@end

NS_ASSUME_NONNULL_END
