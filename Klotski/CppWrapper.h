//
//  CppWrapper.h
//  Klotski
//
//  Created by 闫润邦 on 2022/8/18.
//

#ifndef CppWrapper_h
#define CppWrapper_h

#import <Foundation/Foundation.h>
struct CppStruct;
@interface CppWrapper: NSObject
- (int) getNum_Wrapped: (int) x;
- (char *) solveGame_Wrapped: (NSString *) gameString;
@end
#endif /* CppWrapper_h */
