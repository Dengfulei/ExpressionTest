//
//  ViewController.m
//  ExpressionTest
//
//  Created by 杭州移领 on 17/4/5.
//  Copyright © 2017年 DFL. All rights reserved.
//

#import "ViewController.h"
#import "MLLinkLabel.h"
#import "MLEmojiLabel.h"
#import "NSString+MLExpression.h"
#import "ExpressionViewController.h"
@interface ViewController ()<MLLinkLabelDelegate>
@property (nonatomic, strong) MLLinkLabel *label;
//@property (nonatomic, strong) MLEmojiLabel *label;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    CGFloat w = self.view.frame.size.width;

    self.label = [MLLinkLabel new];
    self.label.delegate = self;
    self.label.frame = CGRectMake(10, 80, 0, 0);
    self.label.backgroundColor = [UIColor yellowColor];
    self.label.textColor = [UIColor redColor];
    self.label.font = [UIFont systemFontOfSize:14.0f];
    self.label.numberOfLines = 0;
    self.label.textAlignment = NSTextAlignmentLeft;
    MLExpression *exp = [MLExpression expressionWithRegex:@"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]" plistName:@"Expression" bundleName:@"ClippedExpression"];
    NSString *text = @"你好，[得意]我是杭州海硕网络科技的工作人员,人生若只如初见，何事秋风悲画扇。等闲变却故人心";
    self.label.attributedText = [text expressionAttributedStringWithExpression:exp];
    self.label.linkTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor]};
    self.label.activeLinkTextAttributes = @{NSForegroundColorAttributeName:[UIColor blueColor]};
    [self.label addLinkWithType:MLLinkTypeURL value:@"nihao" range:NSMakeRange(0, 2)];
    CGSize size =  [self.label preferredSizeWithMaxWidth: w - 10];
    CGRect frame = self.label.frame;
    frame.size = size;
    self.label.frame = frame;
    [self.view addSubview:self.label];
    
  
    NSMutableDictionary *linkAttributes = [NSMutableDictionary dictionary];
    if ([NSMutableParagraphStyle class]) {
        [linkAttributes setObject:[UIColor blackColor] forKey:(NSString *)kCTForegroundColorAttributeName];
        
    } else {
        [linkAttributes setObject:(__bridge id)[[UIColor blackColor] CGColor] forKey:(NSString *)kCTForegroundColorAttributeName];
    }
//    self.label = [MLEmojiLabel new];
//    self.label.delegate = self;
//    self.label.frame = CGRectMake(10, 80, w - 20, 0);
//    self.label.backgroundColor = [UIColor yellowColor];
//    self.label.textColor = [UIColor redColor];
//    self.label.font = [UIFont systemFontOfSize:14.0f];
//    self.label.numberOfLines = 0;
//    self.label.textInsets = UIEdgeInsetsMake(5, 5, 5, 5);
//    self.label.lineSpacing = 0.0f;
//    self.label.linkAttributes = linkAttributes;
//    self.label.textAlignment = NSTextAlignmentLeft;
//    NSString *text = @"你好，我是杭州海硕网络科技的工作人员,人生若只如初见，何事秋风悲画扇。等闲变却故人心你好，我是杭州海硕网络科技的工作人员,人生若只如初见，何事秋风悲画扇。等闲变却故人心";
//    self.label.text = text;
//    [self.label addLinkToURL:[NSURL URLWithString:@"http://www.com"] withRange:NSMakeRange(0, 2)];
//    self.label.lineHeightMultiple = 1.0f;
//    CGSize size =  [self.label preferredSizeWithMaxWidth: w - 20];
//    CGRect frame = self.label.frame;
//    frame.size.height = size.height;
//    self.label.frame = frame;
//    [self.label sizeToFit];
//    
//    [self.view addSubview:self.label];
}


/**
 MLEmojiLabel 表情Label执行的方法
 */
- (void)attributedLabel:(TTTAttributedLabel *)label
   didSelectLinkWithURL:(NSURL *)url {
    NSLog(@"-----%@",url);
}

- (void)didClickLink:(MLLink *)link linkText:(NSString *)linkText linkLabel:(MLLinkLabel *)linkLabel {
    NSLog(@"111link=%@,linktext=%@",link.linkValue,linkText);
    ExpressionViewController *expressionVC = [ExpressionViewController new];
    expressionVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:expressionVC animated:YES];
}


- (void)didLongPressLink:(MLLink *)link linkText:(NSString *)linkText linkLabel:(MLLinkLabel *)linkLabel {
      NSLog(@"222link=%@,linktext=%@",link,linkText);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
