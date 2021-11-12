//
//  LQAlertView.m
//  LQAlertViewKit_Example
//
//  Created by purang on 2021/11/10.
//  Copyright © 2021 qingqiusuomeng. All rights reserved.
//

#import "LQAlertView.h"
#import <SDAutoLayout/SDAutoLayout.h>
///alertView 宽
#define AlertW 280
#define AlertTitleH 30
#define AlertMessageH 50
#define AlertInputH 50
#define AlertHLineAndBtnH 45
///各个栏目之间的距离
#define XLSpace 10.0
@interface LQAlertView()
@property (nonatomic,strong)UIView *alertView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *messageLabel;
@property (nonatomic,strong) UIButton *leftBtn;
@property (nonatomic,strong) UIButton *rightBtn;
@property (nonatomic,strong) UIView *hLineView;
@property (nonatomic,strong) UIView *vLineView;
@property (strong, nonatomic) UITextField *inputText;

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSString *leftTitle;
@property (strong, nonatomic) NSString *rightTitle;

@end


@implementation LQAlertView



- (LQAlertView *)alertViewWithModel:(AlertViewModel *)model
{
    if (self == [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
        
        self.title = model.title;
        self.message = model.message;
        self.leftTitle = model.leftTitle;
        self.rightTitle = model.rightTitle;
        
        if (!model.title.length && !model.message.length && !model.leftTitle.length && !model.rightTitle.length) {//1.全部为空的情况
            [self createNullUI];
            
        }
        else if(model.title.length && !model.message.length && !model.leftTitle.length && !model.rightTitle.length){//2.title不空的情况
            [self createTitleUI];
        }
        else if(!model.title.length && model.message.length && !model.leftTitle.length && !model.rightTitle.length){//3.message不空的情况
            [self createMessageUI];
        }
        else if(!model.title.length && !model.message.length && model.leftTitle.length && !model.rightTitle.length){//4.leftTitle不空的情况
            [self createCancelUI];
            
        }
        else if(!model.title.length && !model.message.length && !model.leftTitle.length && model.rightTitle.length){//5.rightTitle不空的情况
            [self createSureUI];
        }
        else if(model.title.length && model.message.length && !model.leftTitle.length && !model.rightTitle.length){//6.Title和message不空的情况
            [self createTitleAndMessage];
        }
        else if(model.title.length && !model.message.length && model.leftTitle.length && !model.rightTitle.length){//7.Title和leftTitle不空的情况
            [self createTitleAndLeftTitle];
        }
        else if(model.title.length && !model.message.length && !model.leftTitle.length && model.rightTitle.length){//8.Title和rightTitle不空的情况
            [self createTitleAndRightTitle];
        }
        else if(!model.title.length && model.message.length && model.leftTitle.length && !model.rightTitle.length){//9.message和leftTitle不空的情况
            [self createMessageLableAndCancelBtn];
            
        }
        else if(!model.title.length && model.message.length && !model.leftTitle.length && model.rightTitle.length){//10.message和rightTitle不空的情况
            [self createMessageLableAndRightBtn];
        }
        
        else if(!model.title.length && !model.message.length && model.leftTitle.length && model.rightTitle.length){//11.leftTitle和rightTitle不空的情况
            [self createCancelBtnAndSureBtn];
        }
        
        else if(model.title.length && model.message.length && model.leftTitle.length && !model.rightTitle.length){//12.title、message和leftTitle不空的情况
            [self createTitleLabelAndMessageLabelAndCancelBtn];
        }
        
        else if(model.title.length && model.message.length && !model.leftTitle.length && model.rightTitle.length){//13.title、message和rightTitle不空的情况
            [self createTitleLabelAndMessageLabelAndSureBtn];
        }
        else if(model.title.length && !model.message.length && model.leftTitle.length && model.rightTitle.length){//14.title、leftTitle和rightTitle不空的情况
            [self createTitleLabelAndCancelAndSureBtn];
        }
        else if(!model.title.length && model.message.length && model.leftTitle.length && model.rightTitle.length){//15message、leftTitle和rightTitle不空的情况
            [self createMessageLabelAndCancelAndSureBtn];
        }
        
        else if(model.title.length && model.message.length && model.leftTitle.length && model.rightTitle.length){//16.title、message、leftTitle和rightTitle不空的情况
            [self createAllUI];
        }
        
        
    }
    return self;
}

- (instancetype)alertInputViewWithModel:(AlertViewModel *)model{
    if (self == [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
        //有input的情况就不考虑message
        
        if (!model.title.length && !model.leftTitle.length && !model.rightTitle.length) {//17.只有input的情况
            
            [self createInputText];
        }
        else if(model.title.length && !model.leftTitle.length && !model.rightTitle.length){// 18.只有title和input
            [self createTitleLabelAndInputText];
        }
        else if(!model.title.length && model.leftTitle.length && !model.rightTitle.length){// 19.只有取消和input
            [self createCancelBtnAndInputText];
        }
        else if(!model.title.length && !model.leftTitle.length && model.rightTitle.length){//20.只有确认和input
            [self createSureBtnAndInputText];
        }
        
        else if(model.title.length && model.leftTitle.length && !model.rightTitle.length){//21.只有title，input，取消
            [self createTitleLabelAndCancelBtnAndInputText];
        }
        
        else if(model.title.length  && !model.leftTitle.length && model.rightTitle.length){// 22.只有title，input，确认
            [self createTitleLabelAndSureBtnAndInputText];
        }
        
        else if(model.title.length && model.leftTitle.length && model.rightTitle.length){//23.title、leftTitle和rightTitle不空的情况
            [self createTitleLabelAndCancelAndSureBtn];
        }
        
        else if(!model.title.length && model.leftTitle.length && model.rightTitle.length){//24.intpu,leftTitle和rightTitle不空的情况
            [self createAllAndInputText];
        }
    }
    return self;
}
/**
 1.什么都没有的情况
 2.只有title情况
 3.只有message的情况
 4.只有取消按钮的情况（使用7布局）
 5.只有确认按钮的情况（使用8布局）
 6.只有title和message的情况
 7.只有title和取消按钮的情况
 8.只有title和确认按钮的情况
 9.只有message和取消按钮的情况
 10.只有message和确认按钮的情况
 11.只有取消按钮和确认按钮的情况（使用14布局）
 12.只有title、message、取消按钮的情况
 13.只有title、message、确认按钮的情况
 14.只有title、取消和确认按钮的情况
 15.只有message、取消和确认按钮的情况
 16.四个都有的情况
 17.只有input的情况
 18.只有title和input
 19.只有取消和input
 20.只有确认和input
 21.只有title，input，取消
 22.只有title，input，确认
 23.只有input，取消，确认
 24.只有title,input，取消，确认
 
 */

//什么都没有的情况
- (void)createNullUI{
    [self sd_addSubviews:@[self.alertView]];
    //空布局
    self.alertView.sd_layout
    .centerXEqualToView(self)
    .centerYEqualToView(self)
    .widthIs(AlertW)
    .heightIs(50);
    
}

- (void)createCommonAlertView{
    [self sd_addSubviews:@[self.alertView]];
    //AlertView局
    self.alertView.sd_layout
    .centerXEqualToView(self)
    .centerYEqualToView(self)
    .widthIs(AlertW)
    .autoHeightRatio(0);
}
//单个TitleLabel的布局
- (void)layoutSigleTitleLabel{
    self.titleLabel.sd_layout
    .topSpaceToView(self.alertView, XLSpace)
    .leftSpaceToView(self.alertView, XLSpace)
    .rightSpaceToView(self.alertView, XLSpace)
    .autoHeightRatio(0);
}

//单个MessageLabel的布局
- (void)layoutSigleMessageLabel{
    self.messageLabel.sd_layout
    .topSpaceToView(self.alertView, XLSpace)
    .leftSpaceToView(self.alertView, XLSpace)
    .rightSpaceToView(self.alertView, XLSpace)
    .autoHeightRatio(0);
}

//TitleLabel和MessageLabel的布局
- (void)layoutTitleLabelAndMessageLabel{
    //titleLabel的布局
    self.titleLabel.sd_layout
    .topSpaceToView(self.alertView, XLSpace)
    .leftSpaceToView(self.alertView, XLSpace)
    .rightSpaceToView(self.alertView, XLSpace)
    .autoHeightRatio(0);;
    
    self.messageLabel.sd_layout
    .topSpaceToView(self.titleLabel, 0)
    .leftSpaceToView(self.alertView, XLSpace)
    .rightSpaceToView(self.alertView, XLSpace)
    .autoHeightRatio(0);
}
//单个取消按钮的布局
- (void)layoutSigleCancelBtn{
    self.leftBtn.sd_layout
    .topSpaceToView(self.hLineView,0)
    .leftEqualToView(self.hLineView)
    .rightEqualToView(self.hLineView)
    .heightIs(44);
    
}
//单个确认按钮的布局
- (void)layoutSigleSureBtn{
    self.rightBtn.sd_layout
    .topSpaceToView(self.hLineView,0)
    .leftEqualToView(self.hLineView)
    .rightEqualToView(self.hLineView)
    .heightIs(44);
}

//取消和确认按钮的布局
- (void)layoutCancelBtnAndSureBtn{
    //VLineView的布局
    self.vLineView.sd_layout
    .topSpaceToView(self.hLineView,0)
    .centerXEqualToView(self.alertView)
    .widthIs(1)
    .heightIs(44);
    
    //leftBtn的布局
    self.leftBtn.sd_layout
    .topEqualToView(self.vLineView)
    .leftEqualToView(self.alertView)
    .rightSpaceToView(self.vLineView,0)
    
    .bottomEqualToView(self.vLineView);
    //
    //rightBtn的布局
    self.rightBtn.sd_layout
    .topEqualToView(self.leftBtn)
    .leftSpaceToView(self.vLineView,0)
    .rightEqualToView(self.alertView)
    .bottomEqualToView(self.leftBtn);
}



//只有title情况
- (void)createTitleUI{
    
    [self createCommonAlertView];
    [self.alertView sd_addSubviews:@[self.titleLabel]];//titleLabel的布局
    
    [self layoutSigleTitleLabel];
    [self.alertView setupAutoHeightWithBottomView:self.titleLabel bottomMargin:XLSpace];
    
}

//只有message的情况
- (void)createMessageUI{
    
    [self createCommonAlertView];
    [self.alertView sd_addSubviews:@[self.messageLabel]];
    [self layoutSigleMessageLabel];
    [self.alertView setupAutoHeightWithBottomView:self.messageLabel bottomMargin:XLSpace];
}

//只有取消按钮的情况
- (void)createCancelUI{
    
    [self createCommonAlertView];
    [self.alertView sd_addSubviews:@[self.hLineView]];
    self.hLineView.sd_layout
    .topSpaceToView(self.alertView, AlertTitleH+(2*XLSpace))
    .leftEqualToView(self.alertView)
    .rightEqualToView(self.alertView)
    .heightIs(1);
    
    [self.alertView sd_addSubviews:@[self.leftBtn]];
    //leftBtn的布局
    [self layoutSigleCancelBtn];
    
    [self.alertView setupAutoHeightWithBottomView:self.leftBtn bottomMargin:0];
    
}

//只有确认按钮的情况
- (void)createSureUI{
    
    [self createCommonAlertView];
    [self.alertView sd_addSubviews:@[self.hLineView]];
    self.hLineView.sd_layout
    .topSpaceToView(self.alertView, AlertTitleH+(2*XLSpace))
    .leftEqualToView(self.alertView)
    .rightEqualToView(self.alertView)
    .heightIs(1);
    
    [self.alertView sd_addSubviews:@[self.rightBtn]];
    //rightBtn的布局
    [self layoutSigleSureBtn];
    
    [self.alertView setupAutoHeightWithBottomView:self.rightBtn bottomMargin:0];
}



#pragma -----没有input的情况--有input的时候隐藏message--
//只有title和message的情况
- (void)createTitleAndMessage{
    
    [self createCommonAlertView];
    [self.alertView sd_addSubviews:@[self.titleLabel,self.messageLabel]];
    [self layoutTitleLabelAndMessageLabel];
    [self.alertView setupAutoHeightWithBottomView:self.messageLabel bottomMargin:XLSpace];
    
}
//只有title和取消按钮的情况，跟只有取消按钮布局一样
- (void)createTitleAndLeftTitle{
   
    [self createCommonAlertView];
    [self.alertView sd_addSubviews:@[self.titleLabel,self.hLineView,self.leftBtn]];
    //titleLabel的布局
   [self layoutSigleTitleLabel];
    
    self.hLineView.sd_layout
    .topSpaceToView(self.titleLabel,XLSpace)
    .leftEqualToView(self.alertView)
    .rightEqualToView(self.alertView)
    .heightIs(1);
    
    //leftBtn的布局
    [self layoutSigleCancelBtn];
    [self.alertView setupAutoHeightWithBottomView:self.leftBtn bottomMargin:0];
    
}
//只有title和确认按钮的情况，
- (void)createTitleAndRightTitle{
   
    [self createCommonAlertView];
    [self.alertView sd_addSubviews:@[self.titleLabel,self.hLineView,self.rightBtn]];
    //titleLabel的布局
    [self layoutSigleTitleLabel];
    
    self.hLineView.sd_layout
    .topSpaceToView(self.titleLabel,XLSpace)
    .leftEqualToView(self.alertView)
    .rightEqualToView(self.alertView)
    .heightIs(1);
    
    //rightBtn的布局
    [self layoutSigleSureBtn];
    [self.alertView setupAutoHeightWithBottomView:self.rightBtn bottomMargin:0];
}
//只有message和取消按钮的情况
- (void)createMessageLableAndCancelBtn{
  
    [self createCommonAlertView];
    [self.alertView sd_addSubviews:@[self.messageLabel,self.hLineView,self.leftBtn]];
    //messageLabel的布局
    [self layoutSigleMessageLabel];
    
    self.hLineView.sd_layout
    .topSpaceToView(self.messageLabel,XLSpace)
    .leftEqualToView(self.alertView)
    .rightEqualToView(self.alertView)
    .heightIs(1);
    
    //leftBtn的布局
    [self layoutSigleCancelBtn];
    [self.alertView setupAutoHeightWithBottomView:self.leftBtn bottomMargin:0];
}

//只有message和确认按钮的情况
- (void)createMessageLableAndRightBtn{
    
    [self createCommonAlertView];
    [self.alertView sd_addSubviews:@[self.messageLabel,self.hLineView,self.rightBtn]];
    //messageLabel的布局
    [self layoutSigleMessageLabel];
    
    self.hLineView.sd_layout
    .topSpaceToView(self.messageLabel,XLSpace)
    .leftEqualToView(self.alertView)
    .rightEqualToView(self.alertView)
    .heightIs(1);
    
    //rightBtn的布局
    [self layoutSigleSureBtn];
    [self.alertView setupAutoHeightWithBottomView:self.rightBtn bottomMargin:0];
}

//只有取消按钮和确认按钮的情况
- (void)createCancelBtnAndSureBtn{

    [self createCommonAlertView];
    [self.alertView sd_addSubviews:@[self.hLineView, self.vLineView,self.leftBtn,self.rightBtn]];
    self.hLineView.sd_layout
    .topSpaceToView(self.alertView, AlertTitleH+(2*XLSpace))
    .leftEqualToView(self.alertView)
    .rightEqualToView(self.alertView)
    .heightIs(1);
    [self layoutCancelBtnAndSureBtn];
    
    [self.alertView setupAutoHeightWithBottomView:self.vLineView bottomMargin:0];
    
}

//只有title、message、取消按钮的情况
- (void)createTitleLabelAndMessageLabelAndCancelBtn{

    [self createCommonAlertView];
    [self.alertView sd_addSubviews:@[self.titleLabel,self.messageLabel,self.hLineView,self.leftBtn]];
    //titleLabel和message组合的布局
    [self layoutTitleLabelAndMessageLabel];
    
    self.hLineView.sd_layout
    .topSpaceToView(self.messageLabel,XLSpace)
    .leftEqualToView(self.alertView)
    .rightEqualToView(self.alertView)
    .heightIs(1);
    
    //leftBtn的布局
    [self layoutSigleCancelBtn];
    [self.alertView setupAutoHeightWithBottomView:self.leftBtn bottomMargin:0];
    
}
//只有title、message、确认按钮的情况
- (void)createTitleLabelAndMessageLabelAndSureBtn{
    
    [self createCommonAlertView];
    [self.alertView sd_addSubviews:@[self.titleLabel,self.messageLabel,self.hLineView,self.rightBtn]];
    //titleLabel和message组合的布局
    [self layoutTitleLabelAndMessageLabel];
    
    self.hLineView.sd_layout
    .topSpaceToView(self.messageLabel,XLSpace)
    .leftEqualToView(self.alertView)
    .rightEqualToView(self.alertView)
    .heightIs(1);
    
    //rightBtn的布局
    [self layoutSigleSureBtn];
    [self.alertView setupAutoHeightWithBottomView:self.rightBtn bottomMargin:0];
  
}
//只有title、取消和确认按钮的情况,这个布局跟只有取消和确认按钮一样
- (void)createTitleLabelAndCancelAndSureBtn{
   
    [self createCommonAlertView];
    [self.alertView sd_addSubviews:@[self.titleLabel,self.hLineView, self.vLineView,self.leftBtn,self.rightBtn]];
    
    [self layoutSigleTitleLabel];
    
    self.hLineView.sd_layout
    .topSpaceToView(self.titleLabel, XLSpace)
    .leftEqualToView(self.alertView)
    .rightEqualToView(self.alertView)
    .heightIs(1);
    
    //VLineView\leftBtn\rightBtn的布局
    [self layoutCancelBtnAndSureBtn];
    [self.alertView setupAutoHeightWithBottomView:self.vLineView bottomMargin:0];
}
//只有message、取消和确认按钮的情况
- (void)createMessageLabelAndCancelAndSureBtn{
  
    [self createCommonAlertView];
    [self.alertView sd_addSubviews:@[self.messageLabel,self.hLineView, self.vLineView,self.leftBtn,self.rightBtn]];
    
    [self layoutSigleMessageLabel];
    
    self.hLineView.sd_layout
    .topSpaceToView(self.messageLabel, XLSpace)
    .leftEqualToView(self.alertView)
    .rightEqualToView(self.alertView)
    .heightIs(1);
    
    //VLineView\leftBtn\rightBtn的布局
    [self layoutCancelBtnAndSureBtn];
    [self.alertView setupAutoHeightWithBottomView:self.vLineView bottomMargin:0];
    
}
//四个都有的情况
- (void)createAllUI{

    [self createCommonAlertView];
    [self.alertView sd_addSubviews:@[self.titleLabel,self.messageLabel,self.hLineView, self.vLineView,self.leftBtn,self.rightBtn]];
    
    //titleLabel和message组合的布局
    [self layoutTitleLabelAndMessageLabel];
    
    self.hLineView.sd_layout
    .topSpaceToView(self.messageLabel, XLSpace)
    .leftEqualToView(self.alertView)
    .rightEqualToView(self.alertView)
    .heightIs(1);
    
    //VLineView\leftBtn\rightBtn的布局
    [self layoutCancelBtnAndSureBtn];
    [self.alertView setupAutoHeightWithBottomView:self.vLineView bottomMargin:0];
}


//17.只有input的情况
- (void)createInputText{
    
    [self createCommonAlertView];
   
    [self.alertView sd_addSubviews:@[self.inputText]];
    self.inputText.sd_layout
    .topSpaceToView(self.alertView, XLSpace)
    .leftSpaceToView(self.alertView, XLSpace)
    .rightSpaceToView(self.alertView, XLSpace)
    .minHeightIs(30);
    self.inputText.text = @"sknkdsngksgn放放风说拜拜 的毕恭毕敬司法鉴定是否收到就不是v继续进行";
    [self.alertView setupAutoHeightWithBottomView:self.inputText bottomMargin:XLSpace];
}
//18.只有title和input
- (void)createTitleLabelAndInputText{
    
    [self createCommonAlertView];
    [self.alertView sd_addSubviews:@[self.titleLabel,self.inputText]];
    //titleLabel的布局
    [self layoutSigleTitleLabel];
    
    self.inputText.sd_layout
    .topSpaceToView(self.titleLabel, 0)
    .leftSpaceToView(self.alertView, XLSpace)
    .rightSpaceToView(self.alertView, XLSpace)
    .minHeightIs(30);
    [self.alertView setupAutoHeightWithBottomView:self.inputText bottomMargin:XLSpace];
}
//19.只有取消和input
- (void)createCancelBtnAndInputText{

    [self createCommonAlertView];
    [self.alertView sd_addSubviews:@[self.inputText,self.hLineView,self.leftBtn]];
    //inputText的布局
    self.inputText.sd_layout
    .topSpaceToView(self.alertView, XLSpace)
    .leftSpaceToView(self.alertView, XLSpace)
    .rightSpaceToView(self.alertView, XLSpace)
    .minHeightIs(30);
    
    self.hLineView.sd_layout
    .topSpaceToView(self.inputText,XLSpace)
    .leftEqualToView(self.alertView)
    .rightEqualToView(self.alertView)
    .heightIs(1);
    
    //leftBtn的布局
    [self layoutSigleCancelBtn];
    [self.alertView setupAutoHeightWithBottomView:self.leftBtn bottomMargin:0];
}
//20.只有确认和input
- (void)createSureBtnAndInputText{
   
    [self createCommonAlertView];
    [self.alertView sd_addSubviews:@[self.inputText,self.hLineView,self.rightBtn]];
    //inputText的布局
    self.inputText.sd_layout
    .topSpaceToView(self.alertView, XLSpace)
    .leftSpaceToView(self.alertView, XLSpace)
    .rightSpaceToView(self.alertView, XLSpace)
    .minHeightIs(30);
    
    self.hLineView.sd_layout
    .topSpaceToView(self.inputText,XLSpace)
    .leftEqualToView(self.alertView)
    .rightEqualToView(self.alertView)
    .heightIs(1);
    
    //rightBtn的布局
    [self layoutSigleSureBtn];
    [self.alertView setupAutoHeightWithBottomView:self.rightBtn bottomMargin:0];
}
//21.只有title，input，取消
- (void)createTitleLabelAndCancelBtnAndInputText{
    
    [self createCommonAlertView];
    [self.alertView sd_addSubviews:@[self.titleLabel,self.inputText,self.hLineView,self.leftBtn]];
    //titleLabel的布局
    [self layoutSigleTitleLabel];
    //inputText的布局
    self.inputText.sd_layout
    .topSpaceToView(self.titleLabel, XLSpace)
    .leftSpaceToView(self.alertView, XLSpace)
    .rightSpaceToView(self.alertView, XLSpace)
    .minHeightIs(30);
    
    self.hLineView.sd_layout
    .topSpaceToView(self.inputText,XLSpace)
    .leftEqualToView(self.alertView)
    .rightEqualToView(self.alertView)
    .heightIs(1);
    
    //leftBtn的布局
    [self layoutSigleCancelBtn];
    [self.alertView setupAutoHeightWithBottomView:self.leftBtn bottomMargin:0];
}
//22.只有title，input，确认
- (void)createTitleLabelAndSureBtnAndInputText{
   
    [self createCommonAlertView];
    [self.alertView sd_addSubviews:@[self.titleLabel,self.inputText,self.hLineView,self.rightBtn]];
    //titleLabel的布局
    [self layoutSigleTitleLabel];
    //inputText的布局
    self.inputText.sd_layout
    .topSpaceToView(self.titleLabel, XLSpace)
    .leftSpaceToView(self.alertView, XLSpace)
    .rightSpaceToView(self.alertView, XLSpace)
    .minHeightIs(30);
    
    self.hLineView.sd_layout
    .topSpaceToView(self.inputText,XLSpace)
    .leftEqualToView(self.alertView)
    .rightEqualToView(self.alertView)
    .heightIs(1);
    
    //rightBtn的布局
    [self layoutSigleSureBtn];
    [self.alertView setupAutoHeightWithBottomView:self.rightBtn bottomMargin:0];
}
//23.只有input，取消，确认
- (void)createCancelBtnAndSureBtnAndInputText{
   
    [self createCommonAlertView];
    [self.alertView sd_addSubviews:@[self.inputText,self.hLineView, self.vLineView,self.leftBtn,self.rightBtn]];
    
    self.inputText.sd_layout
    .topSpaceToView(self.alertView, XLSpace)
    .leftEqualToView(self.alertView)
    .rightEqualToView(self.alertView)
    .minHeightIs(30);
    
    self.hLineView.sd_layout
    .topSpaceToView(self.messageLabel, XLSpace)
    .leftEqualToView(self.alertView)
    .rightEqualToView(self.alertView)
    .heightIs(1);
    
    //VLineView的布局
    [self layoutCancelBtnAndSureBtn];
    [self.alertView setupAutoHeightWithBottomView:self.vLineView bottomMargin:0];
}

//24.只有title,input，取消，确认
- (void)createAllAndInputText{
    
    [self createCommonAlertView];
    [self.alertView sd_addSubviews:@[self.titleLabel,self.inputText,self.hLineView, self.vLineView,self.leftBtn,self.rightBtn]];
    
    [self layoutSigleTitleLabel];
    
    self.inputText.sd_layout
    .topSpaceToView(self.titleLabel, XLSpace)
    .leftEqualToView(self.alertView)
    .rightEqualToView(self.alertView)
    .minHeightIs(30);
    
    self.hLineView.sd_layout
    .topSpaceToView(self.messageLabel, XLSpace)
    .leftEqualToView(self.alertView)
    .rightEqualToView(self.alertView)
    .heightIs(1);
    
    [self layoutCancelBtnAndSureBtn];
    [self.alertView setupAutoHeightWithBottomView:self.vLineView bottomMargin:0];
}


-(UIView *)alertView{
    if (!_alertView) {
        _alertView = [[UIView alloc]init];
        _alertView.layer.position = self.center;
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.cornerRadius = 14;
        _alertView.layer.masksToBounds = YES;
    }
    return _alertView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = self.title;
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16.0];
    }
    return _titleLabel;
}

-(UILabel *)messageLabel{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.numberOfLines = 0;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.text = self.message;
        _messageLabel.layer.borderColor = [UIColor colorWithRed:125/255.0 green:125/255.0 blue:128/255.0 alpha:1].CGColor;
        _messageLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14.0];
    }
    return _messageLabel;
}

- (UITextField *)inputText{
    if (!_inputText) {
        _inputText = [[UITextField alloc]init];
        _inputText.layer.cornerRadius = 3;
        _inputText.layer.borderColor = [UIColor colorWithRed:125/255.0 green:125/255.0 blue:128/255.0 alpha:1].CGColor;
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14.0];
        _inputText.layer.borderWidth = 1;
        _inputText.layer.masksToBounds = YES;
        _inputText.enabled = YES;
        [_inputText becomeFirstResponder];
    }
    return _inputText;
}

-(UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setTitle:self.leftTitle forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _leftBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14.0];
        [_leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

-(UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setTitle:self.rightTitle forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14.0];
        [_rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _rightBtn;
}

-(UIView *)hLineView{
    if (!_hLineView) {
        _hLineView = [[UIView alloc]init];
        _hLineView.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:235/255.0 alpha:1];
    }
    return _hLineView;
}

-(UIView *)vLineView{
    if (!_vLineView) {
        _vLineView = [[UIView alloc]init];
        _vLineView.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:235/255.0 alpha:1];
    }
    return _vLineView;
}

- (void)setTitleColor:(UIColor *)color{
    _titleLabel.textColor = color;
}
- (void)setMessageColor:(UIColor *)color{
    _messageLabel.textColor = color;
}
- (void)setCancelColor:(UIColor *)color{
    [_leftBtn setTitleColor:color forState:UIControlStateNormal];
}
- (void)setSureColor:(UIColor *)color{
    [_rightBtn setTitleColor:color forState:UIControlStateNormal];
}
- (void)setHLineColor:(UIColor *)color{
    _hLineView.backgroundColor = color;
}
- (void)setVLineColor:(UIColor *)color{
    _vLineView.backgroundColor = color;
}
- (void)setInputTextColor:(UIColor *)color{
    _inputText.textColor = color;
}
- (void)setInputBorderColor:(UIColor *)color{
    _inputText.layer.borderColor = color.CGColor;
}


- (void)setTitleFont:(UIFont *)font{
    _titleLabel.font = font;
}
- (void)setMessageFont:(UIFont *)font{
    _messageLabel.font = font;
}
- (void)setCancelFont:(UIFont *)font{
    _leftBtn.titleLabel.font = font;
}
- (void)setSureFont:(UIFont *)font{
    _rightBtn.titleLabel.font = font;
}
- (void)setInputTextFont:(UIFont *)font{
    _inputText.font = font;
}

- (void)leftBtnAction{
    if (self.alertLeftBtnBlock) {
        self.alertLeftBtnBlock();
    }
    [self hiddenAlertView];
}

- (void)rightBtnAction{
    if ([self.inputText.text length]) {
        if (self.alertRightBtnContentBlock) {
            self.alertRightBtnContentBlock(self.inputText.text);
        }
    }else{
        if (self.alertRightBtnBlock) {
            self.alertRightBtnBlock();
        }
    }
    [self hiddenAlertView];
}
- (void)showAlertView {
    UIWindow *currentWindow = [UIApplication sharedApplication].keyWindow;
    [currentWindow addSubview:self];
}

- (void)hiddenAlertView {
    UIWindow *currentWindow = [UIApplication sharedApplication].keyWindow;
    [currentWindow removeFromSuperview];
  //  self = nil;
}
@end
