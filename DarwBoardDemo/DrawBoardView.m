//
//  DrawBoardView.m
//  darwboard
//
//  Created by 彭平军 on 2017/5/31.
//  Copyright © 2017年 彭平军. All rights reserved.
//

#import "DrawBoardView.h"

@implementation DrawBoardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.totalPathPoints = [NSMutableArray array];
        self.backgroundColor = [UIColor whiteColor];
        UIButton *retractButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 100, 50)];
        [retractButton setTitle:@"retract" forState:UIControlStateNormal];
        retractButton.tintColor = [UIColor whiteColor];
        retractButton.backgroundColor = [UIColor redColor];
        [retractButton addTarget:self action:@selector(retract) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:retractButton];
        
        UIButton *clearButton = [[UIButton alloc] initWithFrame:CGRectMake(180, 50, 100, 50)];
        [clearButton setTitle:@"clear" forState:UIControlStateNormal];
        clearButton.tintColor = [UIColor whiteColor];
        clearButton.backgroundColor = [UIColor blackColor];
        [clearButton addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:clearButton];
    }
    return self;
}

- (void)retract {
    if (self.totalPathPoints.lastObject) {
        [self.totalPathPoints removeObject:self.totalPathPoints.lastObject];
        [self setNeedsDisplay];
        NSLog(@"撤销成功");
    } else {
        NSLog(@"无可撤销的操作");
    }
}

- (void)clear {
    if (self.totalPathPoints.count != 0) {
        [self.totalPathPoints removeAllObjects];
        [self setNeedsDisplay];
        NSLog(@"画板清空成功");
    } else {
        NSLog(@"画板已清空");
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, [touch locationInView:self].x, [touch locationInView:self].y);
    [self.totalPathPoints addObject:(__bridge_transfer id)path];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self drawLineWithTouches:touches];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self drawLineWithTouches:touches];
}

- (void)drawLineWithTouches:(NSSet<UITouch *> *)touches {
    UITouch *touch = [touches anyObject];
    CGMutablePathRef path = (__bridge_retained CGMutablePathRef)self.totalPathPoints.lastObject;
    CGPathAddLineToPoint(path, nil, [touch locationInView:self].x, [touch locationInView:self].y);
    [self setNeedsDisplay];
}

// setNeedsDisplay会自动调用这个方法，手动调用无效
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (id path in self.totalPathPoints) {
        CGMutablePathRef ref = (__bridge_retained CGMutablePathRef)path;
        CGContextAddPath(context, ref);
    }
    // 画笔宽度设置
    CGContextSetLineWidth(context, 5.0);
    // 画笔颜色和样式，线条圆角，交汇点圆角
    [[UIColor blackColor] setStroke];
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    // 开始画图
    CGContextStrokePath(context);
}


@end
