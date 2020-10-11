//
//  ViewController.m
//  TFRememberHistoryInputContentWithDropList
//
//  Created by Jobs on 2020/9/17.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "ViewController.h"
#import "ZYTextField+HistoryDataList.h"

#import "DoorView.h"

#import "GifLoopPlayView.h"

@interface ViewController ()
<
UITextFieldDelegate
,CJTextFieldDeleteDelegate
>

@property(nonatomic,strong)ZYTextField *textField;
@property(nonatomic,strong)DoorView *doorView;

@property(nonatomic,strong)GifLoopPlayView *gifLoopPlayView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.textField.alpha = 1;
//    self.doorView.alpha = 1;
    
    // 开始播动画
    self.gifLoopPlayView.stopped = NO;//YES - 停止；NO - 播放
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    [self.textField closeList];
    [self.doorView endEditing:YES];
}
//删除的话：系统先走textField:shouldChangeCharactersInRange:replacementString: 再走cjTextFieldDeleteBackward:
#pragma mark —— CJTextFieldDeleteDelegate
- (void)cjTextFieldDeleteBackward:(CJTextField *)textField{

}
#pragma mark —— UITextFieldDelegate
//询问委托人是否应该在指定的文本字段中开始编辑
- (BOOL)textFieldShouldBeginEditing:(ZYTextField *)textField{
    //取数据
    NSArray *dataArr = GetUserDefaultObjForKey(@"dataMutArr");
    if (dataArr.count) {
        //有历史值存在再弹
        textField.dataMutArr = [NSMutableArray arrayWithArray:dataArr];
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
        //存数据:相同的值不会进行存储，会进行过滤掉
        if (![textField.dataMutArr containsObject:textField.text]) {
            [textField.dataMutArr addObject:textField.text];
        }
        SetUserDefaultKeyWithObject(@"dataMutArr", textField.dataMutArr);
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

-(DoorView *)doorView{
    if (!_doorView) {
        _doorView = DoorView.new;
        _doorView.backgroundColor = KLightGrayColor;
        [self.view addSubview:_doorView];
        [_doorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 50, 250));
            make.centerX.equalTo(self.view);
            make.centerY.equalTo(self.view).offset(-100);
        }];
        [self.view layoutIfNeeded];
        [UIView cornerCutToCircleWithView:_doorView AndCornerRadius:5];
    }return _doorView;
}

-(GifLoopPlayView *)gifLoopPlayView{
    if (!_gifLoopPlayView) {
        _gifLoopPlayView = GifLoopPlayView.new;
        _gifLoopPlayView.frame = CGRectMake(100, 200, 104, 11);
        [self.view addSubview:_gifLoopPlayView];
        for (int t = 1; t <= 10; t++) {
            [_gifLoopPlayView.gifMutArr addObject:KBuddleIMG(nil,@"音律跳动", nil, [NSString stringWithFormat:@"%d",t])];
        }
        // 设置动画时长
        _gifLoopPlayView.duration = 0.85;
    }return _gifLoopPlayView;
}

@end
