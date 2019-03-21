//
//  JccLoadingView.m
//  ios-jucaicat
//
//  Created by 吴云海 on 16/7/10.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import "JccLoadingView.h"
#import "UIImage+GIF.h"
#import "JccLoadingIndicatorView.h"

@interface JccLoadingView ()

@property(nonatomic, weak) IBOutlet UIImageView *refImgView;

@property(nonatomic, weak) IBOutlet UIButton *btnRefresh;

@property(nonatomic, weak) IBOutlet UILabel *refLabel;

@property(nonatomic, weak) IBOutlet JccLoadingIndicatorView *loadingIndicatorView;


-(IBAction)btnRefreshExec:(id)sender;

@end

@implementation JccLoadingView

-(void)wj_loadSubViews {
    [super wj_loadSubViews];
    [self setBackgroundColor:APP_VIEW_CONTROLLER_VIEW_DEFAULT_COLOR];
    self.networkOffStateText = @"网络好像有点问题";
    self.networkOffStateImageName = @"loading-icon-not-network";
    self.emptyDataStateText = @"没有数据";
    self.emptyDataStateImageName = @"loading-icon-empty-data";
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [self.refLabel setNumberOfLines:0];
    [self refreshUI];
}

-(void) refreshUI {
    if (_state == WJLoadingStateFinished) {
        [_loadingIndicatorView stopAnimating];
        [self setHidden:YES];
        [self.superview sendSubviewToBack:self];
        return;
    } else {
        [self setHidden:NO];
        [self.superview bringSubviewToFront:self];
    }
    
    switch (_state) {
        case WJLoadingStateLoading:
        {
            [_loadingIndicatorView startAnimating];
            [_loadingIndicatorView setHidden:NO];
            [_refLabel setHidden:YES];
            [_refImgView setHidden:YES];
            [_btnRefresh setHidden:YES];
        }
            break;
        case WJLoadingStateEmptyData:
        {
            [_loadingIndicatorView stopAnimating];
            [_loadingIndicatorView setHidden:YES];
            [_refLabel setHidden:NO];
            [_refImgView setHidden:NO];
            [_btnRefresh setHidden:YES];
            [_refImgView setImage:[UIImage imageNamed:self.emptyDataStateImageName]];
            [_refLabel setText:self.emptyDataStateText];
        }
            break;
        default:
        {
            [_loadingIndicatorView stopAnimating];
            [_loadingIndicatorView setHidden:YES];
            [_refLabel setHidden:NO];
            [_refImgView setHidden:NO];
            [_btnRefresh setHidden:NO];
            [_refImgView setImage:[UIImage imageNamed:self.networkOffStateImageName]];
            [_refLabel setText:self.networkOffStateText];
        }
            break;
    }
}

-(void)btnRefreshExec:(id)sender {
    [_delegate loadingRefresh:self];
}

-(NSArray *)wj_observableKeypaths {
    return @[@"state"];
}

-(void)wj_changeForKeypath:(NSString *)keyPath {
    if (WJ_STRING_EQUAL(keyPath, @"state")) {
        [self refreshUI];
    }
}

-(void)dealloc {
    [self.loadingIndicatorView stopAnimating];
}

-(void)addStateUIConfigs:(NSDictionary *)stateUIConfigs {
}

@end
