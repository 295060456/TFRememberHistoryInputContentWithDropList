//
//  SceneDelegate.h
//  TFRememberHistoryInputContentWithDropList
//
//  Created by Jobs on 2020/9/17.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability-new"

@interface SceneDelegate : UIResponder <UIWindowSceneDelegate>

@property(strong,nonatomic)UIWindow * window;

+(instancetype)sharedInstance;

@end

#pragma clang diagnostic pop
