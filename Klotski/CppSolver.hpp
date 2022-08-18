//
//  CppSolver.hpp
//  Klotski
//
//  Created by 闫润邦 on 2022/8/18.
//

#ifndef CppSolver_hpp
#define CppSolver_hpp

#include <stdio.h>
#include <string.h>
#ifdef __cplusplus
extern "C" {
#endif
    int getNum(int x);
    char *solveGame(char *gameString);
#ifdef __cplusplus
}
#endif

#endif /* CppSolver_hpp */
