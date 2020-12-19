//
//  DoorView.m
//  TFRememberHistoryInputContentWithDropList
//
//  Created by Jobs on 2020/9/18.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "DoorView.h"

#import "ZYTextField.h"
#import "ZYTextField+HistoryDataList.h"

@interface DoorView ()
<
UITextFieldDelegate
>

@property(nonatomic,strong)ZYTextField *userTF;
@property(nonatomic,strong)ZYTextField *passwordTF;

@end

@implementation DoorView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(instancetype)init{
    if (self = [super init]) {
        self.userTF.alpha = 1;
        self.passwordTF.alpha = 1;
    }return self;
}
#pragma mark —— UITextFieldDelegate
//询问委托人是否应该在指定的文本字段中开始编辑
- (BOOL)textFieldShouldBeginEditing:(ZYTextField *)textField{
    //取数据
    NSArray *dataArr = (NSArray *)[UserDefaultManager fetchDataWithKey:@"dataMutArr"];
    if (dataArr.count) {
        //有历史值存在再弹
        textField.dataMutArr = [NSMutableArray arrayWithArray:dataArr];
    }return YES;
}
//告诉委托人在指定的文本字段中开始编辑
//- (void)textFieldDidBeginEditing:(UITextField *)textField{}
//询问委托人是否应在指定的文本字段中停止编辑
- (BOOL)textFieldShouldEndEditing:(ZYTextField *)textField{
    return YES;
}
//告诉委托人对指定的文本字段停止编辑
- (void)textFieldDidEndEditing:(ZYTextField *)textField{
    [textField isEmptyText];
    if (![NSString isNullString:textField.text]) {
        //存数据:相同的值不会进行存储，会进行过滤掉
        if (![textField.dataMutArr containsObject:textField.text]) {
            [textField.dataMutArr addObject:textField.text];
        }
        
        UserDefaultModel *userDefaultModel = UserDefaultModel.new;
        userDefaultModel.key = @"dataMutArr";
        userDefaultModel.obj = textField.dataMutArr;
        [UserDefaultManager storedData:userDefaultModel];
    }
}
//告诉委托人对指定的文本字段停止编辑
//- (void)textFieldDidEndEditing:(UITextField *)textField
//reason:(UITextFieldDidEndEditingReason)reason{}
//询问委托人是否应该更改指定的文本
- (BOOL)textField:(ZYTextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string{
    return YES;
}
//询问委托人是否应删除文本字段的当前内容
//- (BOOL)textFieldShouldClear:(UITextField *)textField
//询问委托人文本字段是否应处理按下返回按钮
- (BOOL)textFieldShouldReturn:(ZYTextField *)textField{
    [self endEditing:YES];
    return YES;
}
#pragma mark —— lazyLoad
-(ZYTextField *)userTF{
    if (!_userTF) {
        _userTF = ZYTextField.new;
        _userTF.placeholder = @"请填写用户名";
        _userTF.delegate = self;
        _userTF.backgroundColor = kBlackColor;
        _userTF.returnKeyType = UIReturnKeyDone;
        _userTF.keyboardAppearance = UIKeyboardAppearanceAlert;
        _userTF.alpha = 0.7;
        [self addSubview:_userTF];
        _userTF.isShowHistoryDataList = YES;//一句代码实现下拉历史列表：这句一定要写在addSubview之后，否则找不到父控件会崩溃
        [_userTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(200, 50));
            make.top.equalTo(self).offset(50);
        }];
    }return _userTF;
}

-(ZYTextField *)passwordTF{
    if (!_passwordTF) {
        _passwordTF = ZYTextField.new;
        _passwordTF.placeholder = @"请填写密码";
        _passwordTF.delegate = self;
        _passwordTF.backgroundColor = kBlackColor;
        _passwordTF.returnKeyType = UIReturnKeyDone;
        _passwordTF.keyboardAppearance = UIKeyboardAppearanceAlert;
        _passwordTF.alpha = 0.7;
        [self addSubview:_passwordTF];
//        _passwordTF.isShowHistoryDataList = YES;//一句代码实现下拉历史列表：这句一定要写在addSubview之后，否则找不到父控件会崩溃
        [_passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(200, 50));
            make.bottom.equalTo(self).offset(-30);
        }];
    }return _userTF;
}




@end
