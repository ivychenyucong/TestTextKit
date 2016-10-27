//
//  ViewController.m
//  TestTextView
//
//  Created by IvyChen on 7/7/16.
//  Copyright © 2016 IvyChen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self testSurround];
    
}

-(void ) testAttribute{
    
    NSString * str = @"三个月说一门流利外语没问题，只要你每天不断练习听力、不断模仿着说，尽量学一些贴近生活的句子，毕竟学语言的目的不仅仅是为了考试，更多运用到生活之中。语言学习需要一小时、一小时的积累，不是大家想象中那样几天就可以掌握一门外语。这一点我很赞同，当初自己在学德语时，也是花了一段时间才能够顺利开口说句子。毕竟，你得花时间去学音标、音素，还得花时间去背单词，才会有接下来的开口说.";
    
    
    NSString * str1 = @"培养自制力是一个漫长艰苦的过程。太多的诱惑随时可能让你功亏一篑。所谓的坚持，是心中纠结疑惑，还是继续在往前走，是自己战胜自己的过程。究竟怎样才能排除诸多干扰呢？其实关键就是要学会心理暗示，提前设想那些诱惑带来的种种负面影响，然后在心中一遍又一遍重复告诉自己。";
    
    NSTextStorage * textStorage = [[NSTextStorage alloc] initWithString:str];
    
    
    CGRect rect = CGRectInset(self.view.bounds, 10, 20);
    
    
    //这一段代码很好的诠释了三者的纠结关系,自己体会-----------
    NSLayoutManager * layoutManager = [[NSLayoutManager alloc] init];
    [textStorage addLayoutManager:layoutManager];
    NSTextContainer * textContainer = [[NSTextContainer alloc] initWithSize:rect.size];
    [layoutManager addTextContainer:textContainer];
    UITextView * textView = [[UITextView alloc] initWithFrame:rect textContainer:textContainer];
    //-----------
    
    [self.view addSubview:textView];
    
    
    //官网说这个必须写
    [textStorage beginEditing];
    
    //1. 通过AttributedString  设置attribute的属性 -- 这里最好写在textStorage初始化的时候,不然就赋值2次string了.是吧.而且实践得知,这样做显示出来非常慢,估计是因为替换了显示的文字的缘故
    
    //这句话给文字赋上了一种风格
    NSDictionary *attrsDic = @{NSTextEffectAttributeName: NSTextEffectLetterpressStyle};
    NSMutableAttributedString * attributeStr = [[NSMutableAttributedString alloc] initWithString:str1 attributes:attrsDic];
    [textStorage setAttributedString:attributeStr];

    
    //2. 通过对textStorage的addAttribute:value:range来后期设置属性
    // 这个让前三个字变红
    [textStorage addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
    
    [textStorage endEditing];
}


-(void ) testSurround{
    
    NSString * str = @"三个月说一门流利外语没问题，只要你每天不断练习听力、不断模仿着说，尽量学一些贴近生活的句子，毕竟学语言的目的不仅仅是为了考试，更多运用到生活之中。语言学习需要一小时、一小时的积累，不是大家想象中那样几天就可以掌握一门外语。这一点我很赞同，当初自己在学德语时，也是花了一段时间才能够顺利开口说句子。毕竟，你得花时间去学音标、音素，还得花时间去背单词，才会有接下来的开口说.清朝诗人王永彬曾说：身无饥寒，父母不曾亏我；人无长进，我以何对父母。努力，很多时候不是为了和别人竞争，只是因为我努力就会有收获，没有那么惊天动地，却可以给我带来更丰厚的一笔报酬，给老爸老妈买一件喜欢的衣服，世界那么大，我想带他们去看看。或许努力了依旧过不好自己的一生，改变不了这个社会，但至少，因为努力，我可以成为他们的依靠。或许这就是我们所有普通人努力的意义，为了更有尊严的活着，为了拥有更多选择的机会，为了遇见更好的自己，为了给爱我们的人一点回馈。";
    
    
    UIView* innerView = [[UIView alloc] initWithFrame:CGRectMake(100,100,100, 100)];
    
    [self.view addSubview:innerView];
    
    
    NSTextStorage * textStorage = [[NSTextStorage alloc] initWithString:str];
    
    
    CGRect rect = CGRectInset(self.view.bounds, 10, 20);
    
    
    //这一段代码很好的诠释了三者的纠结关系,自己体会-----------
    NSLayoutManager * layoutManager = [[NSLayoutManager alloc] init];
    [textStorage addLayoutManager:layoutManager];
    NSTextContainer * textContainer = [[NSTextContainer alloc] initWithSize:rect.size];
    [layoutManager addTextContainer:textContainer];

    //-----------
    

    UITextView* textView = [[UITextView alloc] initWithFrame:self.view.bounds textContainer:textContainer];
    
    [self.view insertSubview:textView belowSubview:innerView];
    
    //官网说这个必须写
    [textStorage beginEditing];
    
    //....
    
    [textStorage endEditing];
    
    CGRect relativeRect = [textView convertRect:innerView.frame fromView:self.view];
    UIBezierPath * path =  [UIBezierPath bezierPathWithRect:relativeRect];
    textView.textContainer.exclusionPaths = @[path];
    innerView.backgroundColor = [UIColor redColor];
}


-(void) countBounding{
    NSString * txt = @"大多来问我的朋友们其实都不是很清楚自己的定位，要么是简单的告诉我高考英语考了多少(亲爱的江苏卷的135和全国二卷的135并不是一个层次的好么)";
    
    
    CGSize size = CGSizeMake(100, 3000);
    // CGSize size = CGSizeMake(1000, 100);
    CGRect rect =  [txt boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    NSLog(@"rect:s%f, %f",rect.size.width, rect.size.height);
    
    UILabel * label = [[ UILabel alloc] initWithFrame:
                       CGRectMake (0, 0, ceil(rect.size.width) + 20, ceil(rect.size.height) + 20)];
    label.text = txt;
    label.backgroundColor = [UIColor redColor];
    label.lineBreakMode = NSLineBreakByClipping;
    label.numberOfLines = 0;
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
