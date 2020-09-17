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

@interface ZYTextField (HistoryDataList)
<
UITableViewDelegate,
UITableViewDataSource
>

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,assign)BOOL isSelected;
@property(nonatomic,assign)CGFloat tableviewCellHeight;

@end

NS_ASSUME_NONNULL_END
