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
@property(nonatomic,strong)NSMutableArray *dataMutArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textField.alpha = 1;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    [self.textField closeList];
}
//删除的话：系统先走textField:shouldChangeCharactersInRange:replacementString: 再走cjTextFieldDeleteBackward:
#pragma mark —— CJTextFieldDeleteDelegate
- (void)cjTextFieldDeleteBackward:(CJTextField *)textField{

}
#pragma mark —— UITextFieldDelegate
//询问委托人是否应该在指定的文本字段中开始编辑
- (BOOL)textFieldShouldBeginEditing:(ZYTextField *)textField{
    //取数据
    NSArray *dataArr = GetUserDefaultObjForKey(@"dataArr");
    if (dataArr.count) {
        //有历史值存在再弹
        textField.dataArr = dataArr;
    }return textField.isEditting = YES;
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
    if (![NSString isNullString:textField.text]) {
        //存数据
        [self.dataMutArr addObject:textField.text];
        SetUserDefaultKeyWithObject(@"dataArr", self.dataMutArr);
        UserDefaultSynchronize;
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
    [self.view endEditing:YES];
    textField.isEditting = NO;
    return YES;
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
        [self.view addSubview:_textField];
        _textField.isShowHistoryDataList = YES;//一句代码实现下拉历史列表：这句一定要写在addSubview之后，否则找不到父控件会崩溃
        _textField.frame = CGRectMake(100, 100, 200, 50);
    }return _textField;
}

-(NSMutableArray *)dataMutArr{
    if (!_dataMutArr) {
        _dataMutArr = NSMutableArray.array;
    }return _dataMutArr;
}

@end
