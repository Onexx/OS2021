#include <algorithm>
#include <cstring>
#include <fstream>
#include <iostream>
#include <iterator>
#include <queue>
#include <string>
#include <vector>

namespace {

template<class C>
void print_out(std::ostream &strm, const C &c) {
    std::ostream_iterator<typename C::value_type> out(strm, "\n");
    std::copy(c.begin(), c.end(), out);
}

void process_stream(std::istream &input, const int num_lines) {

    std::deque<std::string> lines;
    std::string line;
    while (std::getline(input, line)) {
        if (lines.size() == abs(num_lines)) {
            if (num_lines < 0) {
                lines.push_back(line);
                lines.pop_front();
            }
        } else {
            lines.push_back(line);
        }
    }

    print_out(std::cout, lines);
}

}// anonymous namespace

int main(int argc, char **argv) {
    int lines = -10;
    std::vector<const char *> input_names;
    for (int i = 1; i < argc; ++i) {
        if (argv[i][0] == '-') {
            if (argv[i][1] != '-') {
                const size_t len = std::strlen(argv[i]);
                for (size_t j = 1; j < len; ++j) {
                    switch (argv[i][j]) {
                        case 'n':
                            if (argv[i + 1][0] != '+' && argv[i + 1][0] != '-') {
                                lines = -std::stoi(argv[++i]);
                            } else {
                                lines = std::stoi(argv[++i]);
                            }
                            break;
                    }
                }
            }
        } else {
            input_names.push_back(argv[i]);
        }
    }
    if (!input_names.empty()) {
        for (auto input_name : input_names) {
            std::ifstream f(input_name);
            process_stream(f, lines);
        }
    } else {
        process_stream(std::cin, lines);
    }
}