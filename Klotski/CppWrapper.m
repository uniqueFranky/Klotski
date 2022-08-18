//
//  CppWrapper.m
//  Klotski
//
//  Created by 闫润邦 on 2022/8/18.
//

#import <Foundation/Foundation.h>
#import "CppWrapper.h"
#import "CppSolver.hpp"

@implementation CppWrapper

- (int) getNum_Wrapped: (int)x {
//    struct CppStruct *cs = CppStruct(1, 2);
    return getNum(x);
}

- (char *) solveGame_Wrapped: (NSString *) gameString {
    return solveGame([gameString UTF8String]);
}

@end
