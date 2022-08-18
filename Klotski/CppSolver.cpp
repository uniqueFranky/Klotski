//
//  CppSolver.cpp
//  Klotski
//
//  Created by 闫润邦 on 2022/8/18.
//

#include "CppSolver.hpp"
#include "rapidjson/document.h"
#include "rapidjson/writer.h"
#include "rapidjson/stringbuffer.h"
#include "rapidjson/ostreamwrapper.h"
#include <cstdio>
#include <iostream>
#include <cstring>
#include <queue>
#include <vector>
#include <unordered_map>
using namespace std;
using namespace rapidjson;




struct Position {
    int x, y;
    Position() {
        x = -1;
        y = -1;
    }
    Position(int x, int y) {
        this -> x = x;
        this -> y = y;
    }
    
    bool operator < (const Position &rhs) const {
        if(x == rhs.x)
            return y < rhs.y;
        return x < rhs.x;
    }
    
    bool operator == (const Position &rhs) const {
        return x == rhs.x && y == rhs.y;
    }
};

struct Size {
    int width, height;
    Size() {
        width = -1;
        height = -1;
    }
    Size(int w, int h) {
        width = w;
        height = h;
    }
    
    bool operator < (const Size &rhs) const {
        if(width == rhs.width)
            return height < rhs.height;
        return width < rhs.width;
    }
    
    bool operator == (const Size &rhs) const {
        return width == rhs.width && height == rhs.height;
    }
};

struct PersonStatus {
    string name;
    Position position;
    Size size;
    PersonStatus(const string &name, const Position &position, const Size &size) {
        this -> name = name;
        this -> position = position;
        this -> size = size;
    }
    
    PersonStatus() {
        
    }
    
    bool operator < (const PersonStatus &rhs) const {
        if(name == rhs.name) {
            if(position == rhs.position)
                return size < rhs.size;
            return position < rhs.position;
        }
        return name < rhs.name;
    }
    
    bool operator == (const PersonStatus &rhs) const {
        return name == rhs.name && position == rhs.position && size == rhs.size;
    }
};


namespace std {
template <>
struct hash<Position> {
    size_t  operator () (const Position &key) const {
        return (key.x << 3) | key.y;
    }
};

template <>
struct hash<Size> {
    size_t  operator () (const Size &key) const {
        return (key.width << 3) | key.height;
    }
};

template <>
struct hash<PersonStatus> {
    size_t  operator () (const PersonStatus &key) const {
        return ((hash<string>()(key.name)) | (hash<Position>()(key.position) << 3) | hash<Size>()(key.size));
    }
};
}  // namespace std


enum MoveDirection {
    up = 0,
    down,
    lef,
    rig
};

Position offsetForDirection(const MoveDirection &diretion) {
    switch (diretion) {
        case up:
            return Position(-1, 0);
            break;
        case down:
            return Position(1, 0);
            break;
        case lef:
            return Position(0, -1);
            break;
        case rig:
            return Position(0, 1);
            break;
    }
}

struct GameStatus {
    vector<PersonStatus> personStatuses;
    unordered_map<Position, bool> isOccupied;
    int stepUsed = 0;
    GameStatus() {
        personStatuses.clear();
        isOccupied.clear();
    }
    void appendPersonStatus(PersonStatus ps) {
        personStatuses.emplace_back(ps);
    }
    
    void setOccupyFor(const PersonStatus &ps, const bool &oc) {
        for(int i = ps.position.x; i < ps.position.x + ps.size.height; i++)
            for(int j = ps.position.y; j < ps.position.y + ps.size.width; j++) {
                isOccupied[Position(i, j)] = oc;
            }
    }
    
    
    bool canMove(const PersonStatus &ps, const MoveDirection &direction) {
        Position newPosition = Position(ps.position.x + offsetForDirection(direction).x,
                                        ps.position.y + offsetForDirection(direction).y);
        if(newPosition.x < 0 || newPosition.x > 4 || newPosition.y < 0 || newPosition.y > 3) {
            return false;
        }
        switch (direction) {
            case up:
                for(int i = ps.position.y; i < ps.position.y + ps.size.width; i++)
                    if(isOccupied[Position(newPosition.x, i)]) {
                        return false;
                    }
                break;
            case down:
                for(int i = ps.position.y; i < ps.position.y + ps.size.width; i++)
                    if(isOccupied[Position(newPosition.x + ps.size.height - 1, i)]) {
                        return false;
                    }
                break;
            case lef:
                for(int i = ps.position.x; i < ps.position.x + ps.size.height; i++)
                    if(isOccupied[Position(i, newPosition.y)]) {
                        return false;
                    }
                break;
            case rig:
                for(int i = ps.position.x; i < ps.position.x + ps.size.height; i++)
                    if(isOccupied[Position(i, newPosition.y + ps.size.width - 1)]) {
                        return false;
                    }
                break;
        }
        return true;
    }
    
    GameStatus getStatusAfterMoving(const PersonStatus &ps, MoveDirection direction) {
        GameStatus newGs;
        newGs.personStatuses = personStatuses;
        newGs.isOccupied = isOccupied;
        newGs.stepUsed = stepUsed + 1;
        for(auto it = newGs.personStatuses.begin(); it != newGs.personStatuses.end(); it++) {
            if(*it == ps) {
                newGs.setOccupyFor(ps, false);
                it -> position.x += offsetForDirection(direction).x;
                it -> position.y += offsetForDirection(direction).y;
                newGs.setOccupyFor(*it, true);
                break;
            }
        }
        return newGs;
    }
    
    PersonStatus &findPersonStatusByName(const string &name) {
        for(auto it = personStatuses.begin(); it != personStatuses.end(); it++) {
            if(it -> name == name)
                return *it;
        }
        PersonStatus emptyPs;
        return emptyPs;
    }
    
    bool operator < (const GameStatus &rhs) const {
        size_t sz = personStatuses.size();
        for(int i = 0; i < sz; i++) {
            if(personStatuses[i] == rhs.personStatuses[i])
                continue;
            return personStatuses[i] < rhs.personStatuses[i];
        }
        return true;
    }
    
    bool operator == (const GameStatus &rhs) const {
        size_t sz = personStatuses.size();
        for(int i = 0; i < sz; i++) {
            if((personStatuses[i] == rhs.personStatuses[i]) == false)
                return false;
        }
        return true;
    }
    
    bool hasEnd() {
        PersonStatus ps = findPersonStatusByName("caoCao");
        return ps.position == Position(3, 1);
    }
};

namespace std {
template <>
struct hash<GameStatus> {
    size_t operator () (const GameStatus &key) const {
        size_t sz = key.personStatuses.size();
        size_t ret = 0;
        for(int i = 0; i < sz; i++) {
            ret <<= 3;
            ret |= (hash<PersonStatus>()(key.personStatuses[i]));
        }
        return ret;
    }
};
}

int getNum(int x) {
    
    return 1;
}

char *solveGame(char* gameString) {
    Document gameStatusDoc;
    GameStatus gs;
    gameStatusDoc.Parse(gameString);
    auto psArray = gameStatusDoc["personStatuses"].GetArray();
    for(auto it = psArray.Begin(); it != psArray.End(); it++) {
        PersonStatus ps;
        ps.name = (*it)["name"].GetString();
        ps.size = Size((*it)["size"]["width"].GetInt(), (*it)["size"]["height"].GetInt());
        ps.position = Position((*it)["position"]["x"].GetInt(), (*it)["position"]["y"].GetInt());
        gs.appendPersonStatus(ps);
        gs.setOccupyFor(ps, true);
    }
    
    queue<GameStatus> q;
    unordered_map<GameStatus, bool> vis;
    q.push(gs);
    int cnt = 0;
    
    while(!q.empty()) {
        GameStatus nowGameStatus = q.front();
        q.pop();
        cout << ++cnt << endl;
        cout << nowGameStatus.stepUsed << endl;
        size_t sz = nowGameStatus.personStatuses.size();
        for(int i = 0; i < sz; i++) {
            for(int j = 0; j < 4; j++) {
                MoveDirection d = (MoveDirection)j;
                if(nowGameStatus.canMove(nowGameStatus.personStatuses[i], d)) {
                    GameStatus newGameStatus =
                    nowGameStatus.getStatusAfterMoving(nowGameStatus.personStatuses[i], d);
                    if(!vis[newGameStatus]) {
//                        cout << nowGameStatus.personStatuses[i].name << " " << d << endl;
                        vis[newGameStatus] = true;
                        q.push(newGameStatus);
                        if(newGameStatus.hasEnd()) {
                            cout << "FOUND" << endl;
                            return "hahahah";
                        }
                    }
                }
            }
        }

    }
    return "123";
}
