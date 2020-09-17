//
//  ZYTextField+HistoryDataList.m
//  TFRememberHistoryInputContentWithDropList
//
//  Created by Jobs on 2020/9/17.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "ZYTextField+HistoryDataList.h"

@implementation ZYTextField (HistoryDataList)

static char *ZYTextField_HistoryDataList_tableview = "ZYTextField_HistoryDataList_tableview";

@dynamic tableview;

#pragma mark —— @property(nonatomic,strong)AFNetworkReachabilityManager *afNetworkReachabilityManager;
-(AFNetworkReachabilityManager *)afNetworkReachabilityManager{
    AFNetworkReachabilityManager *aFNetworkReachabilityManager = objc_getAssociatedObject(self, BaseVC_AFNReachability_afNetworkReachabilityManager);
    if (!aFNetworkReachabilityManager) {
        aFNetworkReachabilityManager = [AFNetworkReachabilityManager sharedManager];
        objc_setAssociatedObject(self,
                                 BaseVC_AFNReachability_afNetworkReachabilityManager,
                                 aFNetworkReachabilityManager,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return aFNetworkReachabilityManager;
}

//-(void)setAfNetworkReachabilityManager:(AFNetworkReachabilityManager *)afNetworkReachabilityManager{
//    objc_setAssociatedObject(self,
//                             BaseVC_AFNReachability_afNetworkReachabilityManager,
//                             afNetworkReachabilityManager,
//                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}

#pragma mark —— @property(nonatomic,strong)UITableView *tableview;
-(UITableView *)tableview{
    UITableView *Tableview
}



@end
