#include <iostream>
#include <unordered_map>
#include <list>

class LRUCache {
private:
    int capacity;
    std::list<std::pair<std::string, std::string>> cacheList;
    std::unordered_map<std::string, std::list<std::pair<std::string, std::string>>::iterator> cacheMap;

public:
    LRUCache(int cap) : capacity(cap) {}

    std::string get(const std::string &key) {
        if (cacheMap.find(key) == cacheMap.end()) {
            return "Cache Miss";
        }
        cacheList.splice(cacheList.begin(), cacheList, cacheMap[key]);
        return cacheMap[key]->second;
    }

    void put(const std::string &key, const std::string &value) {
        if (cacheMap.find(key) != cacheMap.end()) {
            cacheList.erase(cacheMap[key]);
        } else if (cacheList.size() >= capacity) {
            auto lru = cacheList.back();
            cacheMap.erase(lru.first);
            cacheList.pop_back();
        }
        cacheList.push_front({key, value});
        cacheMap[key] = cacheList.begin();
    }
};

int main() {
    LRUCache cache(3);
    cache.put("index.html", "Homepage Content");
    std::cout << "Fetching index.html: " << cache.get("index.html") << std::endl;
    return 0;
}