//
//  ViewController.m
//  TFRememberHistoryInputContentWithDropList
//
//  Created by Jobs on 2020/9/17.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "ViewController.h"
#import "ZYTextField+HistoryDataList.h"

@interface ViewController ()
<
UITextFieldDelegate
,CJTextFieldDeleteDelegate
>

@property(nonatomic,strong)ZYTextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textField.alpha = 1;
}
//删除的话：系统先走textField:shouldChangeCharactersInRange:replacementString: 再走cjTextFieldDeleteBackward:
#pragma mark —— CJTextFieldDeleteDelegate
- (void)cjTextFieldDeleteBackward:(CJTextField *)textField{

}
#pragma mark —— UITextFieldDelegate
//询问委托人是否应该在指定的文本字段中开始编辑
- (BOOL)textFieldShouldBeginEditing:(ZYTextField *)textField{
    return textField.isEditting = YES;
}
//告诉委托人在指定的文本字段中开始编辑
//- (void)textFieldDidBeginEditing:(UITextField *)textField{}
//询问委托人是否应在指定的文本字段中停止编辑
- (BOOL)textFieldShouldEndEditing:(ZYTextField *)textField{
    textField.isEditting = NO;
    return YES;
}
//告诉委托人对指定的文本字段停止编辑
- (void)textFieldDidEndEditing:(ZYTextField *)textField{
    [self.textField isEmptyText];

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
    [self.view endEditing:YES];
    textField.isEditting = NO;
    return YES;
}

-(void)dd{
    SetUserDefaultKeyWithValue(@"data", @"");
    UserDefaultSynchronize;
    
    if (GetUserDefaultValueForKey(@"data")) {
        //有历史值存在再弹
    }
}

-(void)ss{
    
}

#pragma mark —— lazyLoad
-(ZYTextField *)textField{
    if (!_textField) {
        _textField = ZYTextField.new;
        _textField.placeholder = @"你们好哇";
        _textField.delegate = self;
        _textField.cj_delegate = self;
        _textField.backgroundColor = kBlackColor;
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.keyboardAppearance = UIKeyboardAppearanceAlert;
        _textField.alpha = 0.7;
        _textField.cj_delegate = self;
        [self.view addSubview:_textField];
        _textField.isShowHistoryDataList = YES;//这句一定要写在addSubview之后，否则找不到父控件会崩溃
        _textField.frame = CGRectMake(100, 100, 200, 50);
//        [UIView cornerCutToCircleWithView:_textField AndCornerRadius:5];
    }return _textField;
}

@end
