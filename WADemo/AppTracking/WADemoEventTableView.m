//
//  GHWEventTableView.m
//  GHWSDKUI
//
//  Created by wuyx on 16/1/27.
//  Copyright © 2016年 GHW-T-01. All rights reserved.
//

#import "WADemoEventTableView.h"
#import "WADemoPostEventTextView.h"
#import "WADemoUtil.h"
typedef enum GHWEventParamTextView{
    GHWEventParamTextViewEventName = 1,
    GHWEventParamTextViewValue,
    GHWEventParamTextViewLevel,
    GHWEventParamTextViewScore,
    GHWEventParamTextViewFighting,
    GHWEventParamTextViewLevelInfo,
    GHWEventParamTextViewLevelType,
    GHWEventParamTextViewDesc,
    GHWEventParamTextViewOn
}GHWEventParamTextView;

typedef enum GHWEventSwitch{
    GHWEventSwitchOnOff = 1,
    GHWEventSwitchEventName,
    GHWEventSwitchParamDict
}GHWEventSwitch;
@interface WADemoEventTableView()
@property(nonatomic)float cellH;
@property(nonatomic,strong)UISwitch* onOff;
@property(nonatomic,strong)WADemoPostEventTextView* defEventNameTxv;
@property(nonatomic,strong)WADemoPostEventTextView* defValueTxv;
@property(nonatomic,strong)WADemoPostEventTextView* levelTxv;
@property(nonatomic,strong)WADemoPostEventTextView* scoreTxv;
@property(nonatomic,strong)WADemoPostEventTextView* fightingTxv;
@property(nonatomic,strong)WADemoPostEventTextView* levelInfoTxv;
@property(nonatomic,strong)WADemoPostEventTextView* levelTypeTxv;
@property(nonatomic,strong)WADemoPostEventTextView* descriptionTxv;
@property(nonatomic,weak)UITableViewCell* onOffCell;
@property(nonatomic,weak)UITableViewCell* eventNameSwitchCell;
@property(nonatomic,strong)UISwitch* eventNameSwitch;
@property(nonatomic,strong)UISwitch* paramDictSwitch;
@property(nonatomic,strong)UITableViewCell* paramDictSwitchCell;
@property(nonatomic)GHWEventTableViewChannel channel;
@end
@implementation WADemoEventTableView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        //[self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"GHWEventTableView"];
//        self.dataSource = self;
//        self.cellH = 50;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame channel:(GHWEventTableViewChannel)channel param:(WADemoEventData*)param{
    self = [super initWithFrame:frame];
    if (self) {
        //添加界面旋转通知
        [WADemoUtil addOrientationNotification:self selector:@selector(handleDeviceOrientationDidChange:) object:nil];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.channel = channel;
        self.param = param;
        self.dataSource = self;
        self.cellH = 50;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    return self;
}

-(void)handleDeviceOrientationDidChange:(NSNotification*)noti{
//    [self setNeedsLayout];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7 + self.param.params.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell* cell = [[UITableViewCell alloc]init];
    float cellW = self.bounds.size.width;
    if (indexPath.row == 0) {
        if (_channel == GHWEventTableViewChannelAF) {
            cell.textLabel.text = @"Appsflyer";
        }else if(_channel == GHWEventTableViewChannelFB){
            cell.textLabel.text = @"Facebook";
        }else if(_channel == GHWEventTableViewChannelCB){
            cell.textLabel.text = @"Chartboost";
        }else if(_channel == GHWEventTableViewChannelGHW){
            cell.textLabel.text = @"Game Hollywood";
        }else if(_channel == GHWEventTableViewChannelDEF){
            cell.textLabel.text = @"Default";
        }else if(_channel == GHWEventTableViewChannelFIREBASE){
			cell.textLabel.text = @"Firebase";
}
        
        [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
        [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:25]];
    }else if (indexPath.row == 1) {
        if (_channel != GHWEventTableViewChannelDEF) {
            if (self.param.on) {
                cell.textLabel.text = @"On";
            }else{
                cell.textLabel.text = @"Off";
            }
            
            float w = 50;
            float h = 40;
            float l = 10;
            float x = cellW - l - w;
            float y = (_cellH - h)/2;
            _onOff = [[UISwitch alloc]initWithFrame:CGRectMake(x, y, w, h)];
            [_onOff setOn:self.param.on];
            _onOffCell = cell;
            [_onOff addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
            _onOff.tag = GHWEventSwitchOnOff;
            [cell.contentView addSubview:_onOff];
        }
        
    }else if (indexPath.row == 2) {
            if (self.param.on) {
                cell.textLabel.text = @"EventName On";
            }else{
                cell.textLabel.text = @"EventName Off";
            }
            
            float w = 50;
            float h = 40;
            float l = 10;
            float x = cellW - l - w;
            float y = (_cellH - h)/2;
            _eventNameSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(x, y, w, h)];
        _eventNameSwitch.tag = GHWEventSwitchEventName;
            [_eventNameSwitch setOn:self.param.eventNameOn];
            _eventNameSwitchCell = cell;
            [_eventNameSwitch addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
            [cell.contentView addSubview:_eventNameSwitch];
        
    }else if (indexPath.row == 3) {
        if (self.param.on) {
            cell.textLabel.text = @"Param On";
        }else{
            cell.textLabel.text = @"Param Off";
        }
        
        float w = 50;
        float h = 40;
        float l = 10;
        float x = cellW - l - w;
        float y = (_cellH - h)/2;
        _paramDictSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(x, y, w, h)];
        [_paramDictSwitch setOn:self.param.eventNameOn];
        _paramDictSwitchCell = cell;
        _paramDictSwitch.tag = GHWEventSwitchParamDict;
        [_paramDictSwitch addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
        [cell.contentView addSubview:_paramDictSwitch];
        
    }else if(indexPath.row == 4){
        cell.textLabel.text = @"EventName";
        _defEventNameTxv = [[WADemoPostEventTextView alloc]initWithCellWidth:cellW cellHeight:_cellH];
		_defEventNameTxv.delegate=self;
		
        _defEventNameTxv.text = self.param.eventName;
        _defEventNameTxv.delegate = self;
        _defEventNameTxv.tag = GHWEventParamTextViewEventName;
        [cell.contentView addSubview:_defEventNameTxv];
    }else if(indexPath.row == 5){
        cell.textLabel.text = @"Value";
        _defValueTxv = [[WADemoPostEventTextView alloc]initWithCellWidth:cellW cellHeight:_cellH];
        _defValueTxv.text = self.param.value;
        _defValueTxv.delegate = self;
        _defValueTxv.tag = GHWEventParamTextViewValue;
        [cell.contentView addSubview:_defValueTxv];
    }else if(indexPath.row == 6){
        cell.textLabel.text = @"param";
    }else{
        int index = (int)indexPath.row - 7;
        WADemoEventParam* param_ = self.param.params[index];
        cell.textLabel.text = [NSString stringWithFormat:@"%@[%@]",param_.paramName,param_.paramDesc];
        UITextView* txv = [[WADemoPostEventTextView alloc]initWithCellWidth:cellW cellHeight:_cellH];
        txv.text = param_.paramDefValue;
        txv.tag = index + GHWEventParamTextViewValue + 1;
        txv.delegate = self;
        [cell.contentView addSubview:txv];
    }
    return cell;
}
-(void)change:(UISwitch*)switchBtn{
    
    NSString* textOn;
    NSString* textOff;
    UITableViewCell* cell;
    if (switchBtn.tag == GHWEventSwitchOnOff) {
       textOn = @"On";
        textOff = @"Off";
        cell = _onOffCell;
    }else if (switchBtn.tag == GHWEventSwitchEventName){
        textOn = @"EventName On";
        textOff = @"EventName Off";
        cell = _eventNameSwitchCell;
    }else if (switchBtn.tag == GHWEventSwitchParamDict){
        textOn = @"Param On";
        textOff = @"Param Off";
        cell = _paramDictSwitchCell;
    }
    
    if (switchBtn.on) {
        cell.textLabel.text = textOn;
    }else{
        cell.textLabel.text = textOff;
    }
    [self modifyDataOnOff:switchBtn.on eventSwitch:(GHWEventSwitch)switchBtn.tag];
}





-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _cellH;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){
        [self modifyDataWithTxv:textView];
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

-(void)modifyDataOnOff:(BOOL)on eventSwitch:(GHWEventSwitch)eventSwitch{
    if (eventSwitch == GHWEventSwitchOnOff) {
        _param.on = on;
    }else if (eventSwitch == GHWEventSwitchEventName){
        _param.eventNameOn = on;
    }else if (eventSwitch == GHWEventSwitchParamDict){
        _param.paramDictOn = on;
    }
    
    
    if (self.channel == GHWEventTableViewChannelAF) {
        self.eventView.afParam = _param;
    }else if (self.channel == GHWEventTableViewChannelFB) {
        self.eventView.fbParam = _param;
    }else if (self.channel == GHWEventTableViewChannelCB) {
        self.eventView.cbParam = _param;
    }else if (self.channel == GHWEventTableViewChannelGHW) {
        self.eventView.ghwParam = _param;
    }else if (self.channel == GHWEventTableViewChannelDEF) {
        self.eventView.defParam = _param;
    }else if (self.channel == GHWEventTableViewChannelFIREBASE) {
		self.eventView.firebaseParam = _param;
}
}


-(void)modifyDataWithTxv:(UITextView*)textView{
    
    int index = (int)textView.tag;
    
//    if (textView.tag == GHWEventParamTextViewEventName) {
//        _param.eventName = textView.text;
//    }else if(textView.tag == GHWEventParamTextViewValue){
//        _param.value = textView.text;
//    }else if(textView.tag == GHWEventParamTextViewLevel){
//        _param.level = textView.text;
//    }else if(textView.tag == GHWEventParamTextViewScore){
//        _param.score = textView.text;
//    }else if(textView.tag == GHWEventParamTextViewFighting){
//        _param.fighting = textView.text;
//    }else if(textView.tag == GHWEventParamTextViewLevelInfo){
//        _param.levelInfo = textView.text;
//    }else if(textView.tag == GHWEventParamTextViewLevelType){
//        _param.levelType = textView.text;
//    }else if(textView.tag == GHWEventParamTextViewDesc){
//        _param.desc = textView.text;
//    }
    
    if (index == GHWEventParamTextViewEventName) {
        _param.eventName = textView.text;
    }else if(index == GHWEventParamTextViewValue){
        _param.value = textView.text;
    }else{
        index = index - GHWEventParamTextViewValue - 1;
        [_param.params enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == index) {
                WADemoEventParam* eventParam = obj;
                eventParam.paramDefValue = textView.text;
                *stop = YES;
            }
        }];
    }
    
    
    
    if (self.channel == GHWEventTableViewChannelAF) {
        self.eventView.afParam = _param;
    }else if (self.channel == GHWEventTableViewChannelFB) {
        self.eventView.fbParam = _param;
    }else if (self.channel == GHWEventTableViewChannelCB) {
        self.eventView.cbParam = _param;
    }else if (self.channel == GHWEventTableViewChannelGHW) {
        self.eventView.ghwParam = _param;
    }else if (self.channel == GHWEventTableViewChannelDEF) {
        self.eventView.defParam = _param;
    }else if (self.channel == GHWEventTableViewChannelFIREBASE) {
		self.eventView.firebaseParam = _param;
}
    
}
-(void)textFieldTextChange:(UITextField *)textField{
    NSLog(@"textField1 - 输入框内容改变,当前内容为: %@",textField.text);
}
-(void)layoutSubviews{
    [super layoutSubviews];
}

-(void)dealloc{
    [WADemoUtil removeOrientationNotification:self object:nil];
}

@end
