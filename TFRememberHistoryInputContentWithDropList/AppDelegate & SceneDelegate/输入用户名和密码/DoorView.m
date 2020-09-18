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
,CJTextFieldDeleteDelegate
,CAAnimationDelegate
>

@property(nonatomic,strong)ZYTextField *userTF;
@property(nonatomic,strong)ZYTextField *passwordTF;

@property (strong, nonatomic) UILabel *placeholderCacheLabel;
@property (strong, nonatomic) UIView *lineView;
@property (strong, nonatomic) UIView *grayLineView;
@property (strong, nonatomic) NSAttributedString *cachedPlaceholder;

@end

@implementation DoorView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(instancetype)init{
    if (self = [super init]) {
        self.userTF.alpha = 1;
        self.passwordTF.alpha = 1;

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kd_textFieldDidBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kd_textFieldDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:self];
        
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    self.grayLineView = [[UIView alloc] initWithFrame:CGRectMake(self.userTF.mj_x, self.userTF.mj_h + self.userTF.mj_y - 1, self.userTF.mj_w, 1)];
    _grayLineView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
    [self addSubview:_grayLineView];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(self.userTF.mj_x, self.userTF.mj_h - 1, 0, 1)];
    _lineView.backgroundColor = [UIColor greenColor];
    _lineView.layer.anchorPoint = CGPointMake(0, 0.5);
    [self addSubview:_lineView];
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
    [textField isEmptyText];
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
    [self endEditing:YES];
    textField.isEditting = NO;
    return YES;
}

#pragma mark —— lazyLoad
-(ZYTextField *)userTF{
    if (!_userTF) {
        _userTF = ZYTextField.new;
        _userTF.placeholder = @"请填写用户名";
        _userTF.delegate = self;
        _userTF.cj_delegate = self;
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
        _passwordTF.cj_delegate = self;
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


#pragma mark - UITextFieldTextDidBeginEditingNotification
- (void)kd_textFieldDidBeginEditing:(NSNotification *)notification {
    CAKeyframeAnimation *kfAnimation11 = [CAKeyframeAnimation animationWithKeyPath:@"bounds.size.width"];
    kfAnimation11.fillMode = kCAFillModeForwards;
    kfAnimation11.removedOnCompletion = NO;
    kfAnimation11.values = @[@0,@(self.bounds.size.width)];
    kfAnimation11.duration = 0.25f;
    kfAnimation11.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_lineView.layer addAnimation:kfAnimation11 forKey:@"kKDLienViewWidth"];
    
    if (![self.userTF.text isEqualToString:@""]) {
        return;
    }
    if (!_placeholderCacheLabel) {
        [self addSubview:self.placeholderCacheLabel];
        _placeholderCacheLabel.attributedText = self.userTF.attributedPlaceholder;
        self.cachedPlaceholder = self.userTF.attributedPlaceholder;
    }
    self.userTF.placeholder = nil;
    _placeholderCacheLabel.hidden = NO;


    CAKeyframeAnimation *kfAnimation1 = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    kfAnimation1.fillMode = kCAFillModeForwards;
    kfAnimation1.removedOnCompletion = NO;
    CATransform3D scale1 = CATransform3DMakeScale(1.0, 1.0, 1);
    CATransform3D scale2 = CATransform3DMakeScale(1.1, 1.1, 1);
    CATransform3D scale3 = CATransform3DMakeScale(0.9, 0.9, 1);
    kfAnimation1.values = @[[NSValue valueWithCATransform3D:scale1],
                            [NSValue valueWithCATransform3D:scale2],
                            [NSValue valueWithCATransform3D:scale3]];
    
    CAKeyframeAnimation *kfAnimation2 = [CAKeyframeAnimation animationWithKeyPath:@"bounds.origin"];
    kfAnimation2.fillMode = kCAFillModeForwards;
    kfAnimation2.removedOnCompletion = NO;
    kfAnimation2.values = @[[NSValue valueWithCGPoint:CGPointMake(0, 0)],[NSValue valueWithCGPoint:CGPointMake(0, 22)]];
    
    CAAnimationGroup *grouoAnimation = [CAAnimationGroup animation];
    grouoAnimation.animations = @[kfAnimation1,kfAnimation2];
    grouoAnimation.fillMode = kCAFillModeForwards;
    grouoAnimation.removedOnCompletion = NO;
    grouoAnimation.duration = 0.25;
    grouoAnimation.delegate = self;
    [_placeholderCacheLabel.layer addAnimation:grouoAnimation forKey:@"kKDOutAnimation"];
    
}

#pragma mark - UITextFieldTextDidEndEditingNotification
- (void)kd_textFieldDidEndEditing:(NSNotification *)notification {
    CAKeyframeAnimation *kfAnimation11 = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    kfAnimation11.fillMode = kCAFillModeForwards;
    kfAnimation11.removedOnCompletion = NO;
    kfAnimation11.values = @[@1,@0];
    kfAnimation11.duration = 0.25f;
    kfAnimation11.delegate = self;
    [_lineView.layer addAnimation:kfAnimation11 forKey:@"kKDLienViewOpactity"];
    
    CAKeyframeAnimation *kfAnimation12 = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    kfAnimation12.fillMode = kCAFillModeForwards;
    kfAnimation12.removedOnCompletion = NO;
    kfAnimation12.values = @[@0,@1];
    kfAnimation12.duration = 0.25f;
    kfAnimation12.delegate = self;
    [_grayLineView.layer addAnimation:kfAnimation12 forKey:@"kKDGrayLienViewOpactity"];

    if (![self.userTF.text isEqualToString:@""]) {
        return;
    }
    
    CAKeyframeAnimation *kfAnimation1 = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    kfAnimation1.fillMode = kCAFillModeForwards;
    kfAnimation1.removedOnCompletion = NO;
    CATransform3D scale1 = CATransform3DMakeScale(0.9, 0.9, 1);
    CATransform3D scale2 = CATransform3DMakeScale(1.1, 1.1, 1);
    CATransform3D scale3 = CATransform3DMakeScale(1.0, 1.0, 1);
    kfAnimation1.values = @[[NSValue valueWithCATransform3D:scale1],
                            [NSValue valueWithCATransform3D:scale2],
                            [NSValue valueWithCATransform3D:scale3]];
    
    CAKeyframeAnimation *kfAnimation2 = [CAKeyframeAnimation animationWithKeyPath:@"bounds.origin"];
    kfAnimation2.fillMode = kCAFillModeForwards;
    kfAnimation2.removedOnCompletion = NO;
    kfAnimation2.values = @[[NSValue valueWithCGPoint:CGPointMake(0, 22)],[NSValue valueWithCGPoint:CGPointMake(0, 0)]];
    
    CAAnimationGroup *grouoAnimation = [CAAnimationGroup animation];
    grouoAnimation.animations = @[kfAnimation1,kfAnimation2];
    grouoAnimation.fillMode = kCAFillModeForwards;
    grouoAnimation.removedOnCompletion = NO;
    grouoAnimation.duration = 0.25;
    grouoAnimation.delegate = self;
    [_placeholderCacheLabel.layer addAnimation:grouoAnimation forKey:@"kZYYInAnimation"];
    
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        if (anim == [_placeholderCacheLabel.layer animationForKey:@"kZYYInAnimation"] ) {
            _placeholderCacheLabel.hidden = YES;
            self.userTF.attributedPlaceholder = self.cachedPlaceholder;
        } else if (anim == [_lineView.layer animationForKey:@"kZYYLienViewOpactity"]) {
            CGRect frame = _lineView.frame;
            frame.size.width = 0;
            _lineView.frame = frame;
            _lineView.alpha = 1;
            _grayLineView.alpha = 0;
            [_lineView.layer removeAllAnimations];
        }
    }
}


#pragma mark - Setter & Getter
- (UILabel *)placeholderCacheLabel {
    if (!_placeholderCacheLabel) {
        _placeholderCacheLabel = [[UILabel alloc] init];
        _placeholderCacheLabel.layer.anchorPoint = CGPointZero;
        _placeholderCacheLabel.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    }
    return _placeholderCacheLabel;
}



@end
