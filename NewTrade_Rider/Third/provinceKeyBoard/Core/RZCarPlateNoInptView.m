//
//  RZCarPlateNoInputAlertView.m
//  RZCarPlateNoTextField
//
//  Created by Admin on 2018/12/11.
//  Copyright © 2018 Rztime. All rights reserved.
//

#import "RZCarPlateNoInputView.h"
#import "RZCarPlateNoTextField.h"
#import "RZCarPlateNoKeyBoardViewModel.h"

@interface RZCarPlateNoInputView ()

/** 默认 8 */
@property (nonatomic, assign) NSUInteger carPlateNoLength;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIView                         *textFieldContentView;
@property (nonatomic, strong) NSMutableArray <RZCarPlateNoTextField *> *textFields;

@property (nonatomic, strong) NSMutableArray <NSString *> *plateInputs;

@property (nonatomic, copy) NSString *plateNo;

@end

@implementation RZCarPlateNoInputView
- (instancetype)init {
    if (self = [super init]) {
        self.carPlateNoLength = 8;
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame plateNo:(NSString *)plateNo plateLength:(NSUInteger)length
{
    self = [super initWithFrame:frame];
    if (self) {
        self.carPlateNoLength = length;
        self.plateNo = plateNo;
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    // Do any additional setup after loading the view.


    

  
    CGFloat contentWidth = [UIScreen mainScreen].bounds.size.width - 28 - 32;
    _textFields = [NSMutableArray new];
    _plateInputs = [NSMutableArray new];
    __weak typeof(self) weakSelf = self;
    CGFloat textFieldWidth = (contentWidth - (5 * (self.carPlateNoLength + 1))) / self.carPlateNoLength;
    for (NSInteger i = 0; i < self.carPlateNoLength; i ++) {
        [_plateInputs addObject:@""];
        
        RZCarPlateNoTextField *textField = [[RZCarPlateNoTextField alloc] initWithFrame:CGRectMake(5 + (i * (textFieldWidth + 5)), 8, textFieldWidth, 44)];
        if (i == 0) {
            _firstView = textField;
        }
        textField.layer.borderWidth = 1;
        textField.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:1].CGColor;
        textField.layer.masksToBounds = YES;
        textField.layer.cornerRadius = 3;
        textField.rz_showCarPlateNoKeyBoard = YES;
        textField.rz_checkCarPlateNoValue = NO;
        textField.textAlignment = NSTextAlignmentCenter;
        textField.rz_maxLength = i == self.carPlateNoLength - 1? 1 : 2;
        [self addSubview:textField];
        textField.tag = i;
        
        if (i != 0) {
            [textField rz_changeKeyBoard:NO];
        }
        
        [_textFields addObject:textField];
        
        textField.rz_textFieldEditingValueChanged = ^(RZCarPlateNoTextField * _Nonnull textField) {
            [weakSelf textFieldValueChanged:textField];
        };
    }
    

//    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardLoacation:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    if (self.plateNo.length > 0) {
        [self initTextFields];
    }
}

- (void)keyboardLoacation:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    CGRect endKeyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat centerY = endKeyboardRect.origin.y / 2.f;
    NSTimeInterval timer = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:timer animations:^{
        self.contentView.center = ({
            CGPoint center = self.contentView.center;
            center.y = centerY;
            center;
        });
    } completion:^(BOOL finished) {
        
    }];
}

- (void)initTextFields {
    NSInteger len = [self.plateNo length];
    for (int i=0; i<len; i++) {
        NSString *s= [self.plateNo substringWithRange:NSMakeRange(i, 1)];
        if (i >= self.carPlateNoLength) {
            return ;
        }
        [self.plateInputs replaceObjectAtIndex:i withObject:s];
        self.textFields[i].text = s;
    }
}

- (void)textFieldValueChanged:(RZCarPlateNoTextField *)textFiled {
    NSString *originText = self.plateInputs[textFiled.tag];
    NSString *newText = textFiled.text;
    
    RZCarPlateNoTextField *leftTextField = [self safeArrayAtIndex:textFiled.tag - 1];
    RZCarPlateNoTextField *rightTextField = [self safeArrayAtIndex:textFiled.tag + 1];
    
    RZCarPlateNoTextField *flagTextField;
    
    // 0 ..1
    if (originText.length == 0 && newText.length == 1) {
        [self.plateInputs replaceObjectAtIndex:textFiled.tag withObject:newText];
        flagTextField = rightTextField;
    } else if (originText.length == 1 && newText.length == 2) { // 1..2
        NSString *left = [newText substringToIndex:1];
        NSString *right = [newText substringFromIndex:1];
        textFiled.text = left;
        rightTextField.text = right;
        [self.plateInputs replaceObjectAtIndex:textFiled.tag withObject:left];
        if (rightTextField) {
            [self.plateInputs replaceObjectAtIndex:rightTextField.tag withObject:right];
            flagTextField = rightTextField;
        }
    } else if (originText.length == 1 && newText.length == 0){ // 1.。0
        [self.plateInputs replaceObjectAtIndex:textFiled.tag withObject:@""];
    } else if (originText.length == 0 && newText.length == 0){ // 0.。0
        [self.plateInputs replaceObjectAtIndex:textFiled.tag withObject:@""];
        flagTextField = leftTextField;
    }
    if([self regexPlateNo]) {
        flagTextField = textFiled;
    }
    if (flagTextField) {
        [flagTextField becomeFirstResponder];
    }
    
    
}

- (BOOL)regexPlateNo {
    NSString *province = self.plateInputs[0];
    NSString *provinceCode = self.plateInputs[1];
    
    NSString *last;
    NSInteger index = 2;
    for (NSInteger i = self.plateInputs.count - 1; i > 1; i--) {
        last = self.plateInputs[i];
        if (last.length > 0) {
            index = i;
            break;
        }
    }
    BOOL flag = NO;
    if (![RZCarPlateNoKeyBoardViewModel rz_regexText:province regex:rz_province_Regex]) {
        [self.plateInputs replaceObjectAtIndex:0 withObject:@""];
        flag = YES;
    }
    if (![RZCarPlateNoKeyBoardViewModel rz_regexText:provinceCode regex:rz_province_code_Regex]) {
        [self.plateInputs replaceObjectAtIndex:1 withObject:@""];
        flag = YES;
    }
    for (NSInteger i = 2; i < index; i++) {
        NSString *charText = self.plateInputs[i];
        if (![RZCarPlateNoKeyBoardViewModel rz_regexText:charText regex:rz_plateNo_code_Regex]) {
            [self.plateInputs replaceObjectAtIndex:i withObject:@""];
            flag = YES;
        }
    }
    if (![RZCarPlateNoKeyBoardViewModel rz_regexText:last regex:rz_plateNo_code_end_Regx]) {
        [self.plateInputs replaceObjectAtIndex:index withObject:@""];
        flag = YES;
    }
    if (flag) {
        __weak typeof(self) weakSelf = self;
        [self.plateInputs enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            weakSelf.textFields[idx].text = obj;
        }];
    }
    return flag;
}


- (RZCarPlateNoTextField *)safeArrayAtIndex:(NSInteger)index {
    if (index <= self.textFields.count - 1) {
        return self.textFields[index];
    }
    return nil;
}


//- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}




/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */




@end
