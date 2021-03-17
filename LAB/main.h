#ifndef MAIN_HPP
#define MAIN_HPP

#include <iostream>//使用C++库
#include <string>
#include <stdio.h>//printf和FILE要用的

using namespace std;

struct Type//通常这里面每个成员，每次只会使用其中一个，一般是定义成union以节省空间(但这里用了string等复杂类型造成不可以)
{
     int number;
     string  str;
};

#define YYSTYPE Type
#endif
