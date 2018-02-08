//
//  SingleUser.m
//  accountProject
//
//  Created by 弘鼎 on 2018/1/29.
//  Copyright © 2018年 贺亚飞. All rights reserved.
//

#import "SingleUser.h"
static SingleUser *singleuser;
@implementation SingleUser
//+(instancetype)shareTools{
//    
//    //注意：这里建议使用self,而不是直接使用类名Tools（考虑继承）
//    return [[self alloc] init];
//    
//}
////避免alloc产生新对象，所以需要重写allocWithZone方法
//+(instancetype)allocWithZone:(struct _NSZone *)zone{
//    
//    /*
//     1、使用GCD
//     static dispatch_once_t onceToken;
//     
//     dispatch_once(&onceToken, ^{
//     
//     singTool = [super allocWithZone:zone];
//     
//     });
//     */
//    
//    //1、使用加锁的方式、保证只分配一次存储空间
//    @synchronized (self) {
//        
//        if (singleuser == nil) {
//            
//            singleuser = [super allocWithZone:zone];
//            
//        }
//    }
//    
//    return singleuser;
//    
//}
////copy 返回一个不可变对象
//-(id)copyWithZone:(NSZone *)zone{
//    
//    //若原对象是不可变对象，那么返回原对象，并将其引用计数加1；
//    //return [[self class] allocWithZone:zone];
//    //若原对象是可变对象，那么创建一个新的不可变对象，并初始化为原对象的值，新对象的引用计数为 1。
//    return singleuser;
//    
//}
////mutableCopy 创建一个新的可变对象，并初始化为原对象的值，新对象的引用计数为 1；
//-(id)mutableCopyWithZone:(NSZone *)zone{
//    
//    return singleuser;
//}
@end
