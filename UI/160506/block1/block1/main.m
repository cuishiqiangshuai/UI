//
//  main.m
//  block1
//
//  Created by qingyun on 16/5/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
       int (^testBlock)(int)=^(int num){
                return num++;
        };
        NSLog(@"%d",testBlock(testBlock(testBlock(3))));
        }
}

