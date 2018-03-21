//
//  ViewController.m
//  ChatDemo
//
//  Created by WingKit Tung on 17/03/2018.
//  Copyright © 2018 WingKit. All rights reserved.
//

#import "ViewController.h"
#import "Message.h"
#import "MessageFrame.h"
#import "MessageCell.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *chatTableView;
@property (nonatomic, strong) NSMutableArray *messagesFrame;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController
//messages懒加载
- (NSArray *)messagesFrame{
    if (_messagesFrame == nil) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"chatMessage.plist" ofType:nil];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *tempArray = [NSMutableArray array];
        for(NSDictionary *dict in dictArray){
            Message *msg = [Message messageWithDict:dict];
            MessageFrame *msgF = [MessageFrame new];
            //判断是否要隐藏时间
            MessageFrame *lastMsgF = [tempArray lastObject];
            Message *lastMsg = lastMsgF.message;
            if ([lastMsg.date isEqualToString:msg.date]) {
                msg.hiddenTime = YES;
            }

            msgF.message = msg;
            [tempArray addObject:msgF];
        }
        _messagesFrame = tempArray;
    }
    return _messagesFrame;
}
//视图加载完成的操作
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.chatTableView.dataSource = self;//设置TableView数据源
    self.chatTableView.delegate = self;//设置TableView代理
    self.chatTableView.separatorStyle = UITableViewCellSeparatorStyleNone;//取消分隔线
    //设置背景颜色
    self.chatTableView.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1];
    self.chatTableView.allowsSelection = NO;//设置不能被选中
    //监听键盘弹出
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardFrameChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
    //设置textFiled代理
    self.textField.delegate = self;
}
#pragma 监听键盘的操作
- (void)keyboardFrameChanged:(NSNotification *)userInfo{
    NSDictionary *kbDict = userInfo.userInfo;
    //获取键盘变化后的Frame
    CGRect kbEndFrame = [kbDict[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    //获取变化值
    CGFloat ty = kbEndFrame.origin.y - [UIScreen mainScreen].bounds.size.height;
    //获取动画持续时间
    CGFloat duration = [kbDict[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, ty);
    }];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}


#pragma section数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma 返回section对应的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messagesFrame.count;
}

#pragma 返回对应行数的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //重用ID
    static NSString *ID = @"message";
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //若为空则新建一个,懒加载
    if (cell == nil) {
        cell = [[MessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    MessageFrame *msgF = self.messagesFrame[indexPath.row];
    cell.messageFrame = msgF;
    return cell;
}
//返回cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageFrame *msgF = self.messagesFrame[indexPath.row];
    return msgF.cellHeight;
}
//点击Send按钮事件
- (IBAction)sendBtnClick {
    NSString *text = self.textField.text;
    MessageType type = MessageTypeMe;
    [self sendWith:text andType:type];
    self.textField.text = nil;
}
#pragma 点击键盘return事件
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSString *text = self.textField.text;
    MessageType type = MessageTypeMe;
    [self sendWith:text andType:type];
    self.textField.text = nil;
    return YES;
}

- (void)sendWith:(NSString *)text andType:(MessageType)type{
    MessageFrame *msgF = [MessageFrame new];
    Message *msg = [Message new];
    //获取时间
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"今天 HH:mm";
    msg.date = [formatter stringFromDate:now];
    //设置type
    msg.type = type;
    //设置text
    msg.text = text;
    //判断是否与上一条时间相同
    MessageFrame *lastMsgF = [self.messagesFrame lastObject];
    Message *lastMsg = lastMsgF.message;
    if ([msg.date isEqualToString:lastMsg.date]) {
        msg.hiddenTime = YES;
    }
    //讲msg添加到Frame模型中
    msgF.message = msg;
    //添加到Array中
    [self.messagesFrame addObject:msgF];
    //刷新数据
    [self.chatTableView reloadData];
    //移动到最下面
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.messagesFrame.count - 1 inSection:0];
    [self.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}


@end
