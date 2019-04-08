//
//  ViewController.m
//  LVThemeKit
//
//  Created by lvpengwei on 2019/3/30.
//  Copyright © 2019 lvpengwei. All rights reserved.
//

#import "ViewController.h"
#import "UIView+LVThemeKit.h"
#import "UILabel+LVThemeKit.h"
#import "UIButton+LVThemeKit.h"
#import "ReaderThemeManager.h"
#import "AppThemeManager.h"
#import "QDThemeManager.h"
#import "LVThemeColor+Demo.h"
#import "LVThemeString+Demo.h"
#import "LVThemeKit+Demo.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *readerThemeButton;
@property (weak, nonatomic) IBOutlet UILabel *readerThemeLabel;
@property (weak, nonatomic) IBOutlet UIButton *appThemeButton;
@property (weak, nonatomic) IBOutlet UILabel *appThemeLabel;
@property (weak, nonatomic) IBOutlet UIButton *qdThemeButton;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.readerThemeButton.buttonTK.reader setTitleColor:[LVThemeColor readerThemeFont] forState:UIControlStateNormal];
    self.readerThemeLabel.labelTK.reader.textColor = [LVThemeColor readerThemeFont];
    self.readerThemeLabel.viewTK.reader.backgroundColor = [LVThemeColor readerThemeBackground];
    self.readerThemeLabel.labelTK.qd.textColor = [LVThemeColor qdThemeFont];
    self.readerThemeLabel.viewTK.qd.backgroundColor = [LVThemeColor qdThemeBackground];
    [self.appThemeButton.buttonTK.app setTitleColor:[LVThemeColor appThemeFont] forState:UIControlStateNormal];
    self.appThemeLabel.labelTK.app.textColor = [LVThemeColor appThemeFont];
    self.appThemeLabel.viewTK.app.backgroundColor = [LVThemeColor appThemeBackground];
    self.appThemeLabel.labelTK.qd.textColor = [LVThemeColor qdThemeFont];
    self.appThemeLabel.viewTK.qd.backgroundColor = [LVThemeColor qdThemeBackground];
    self.qdThemeButton.viewTK.qd.backgroundColor = [LVThemeColor qdThemeBackground];
    [self.qdThemeButton.buttonTK.qd setTitleColor:[LVThemeColor qdThemeFont] forState:UIControlStateNormal];
    [self.qdThemeButton.buttonTK.qd setTitle:[LVThemeString qdThemeString] forState:UIControlStateNormal];
}
- (IBAction)readerThemeAction:(id)sender {
    [[ReaderThemeManager share] switchTheme];
}
- (IBAction)appThemeAction:(id)sender {
    [[AppThemeManager share] switchTheme];
}
- (IBAction)qdThemeAction:(id)sender {
    [QDThemeManager share].type = [QDThemeManager share].isNight ? QDThemeDay : QDThemeNight;
}
- (IBAction)openNewPage:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController * vc = (ViewController *)[sb instantiateViewControllerWithIdentifier:@"ViewController"];
    [self.navigationController pushViewController:vc animated:true];
}
@end
