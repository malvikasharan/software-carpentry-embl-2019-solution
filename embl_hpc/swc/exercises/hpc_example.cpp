
// C program to illustrate
// command line arguments
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <limits.h>
#include <time.h>
#include <iostream>       // std::cout, std::endl
#include <thread>         // std::this_thread::sleep_for
#include <chrono>         // std::chrono::seconds
#include <vector>
#include <sstream>

int main(int argc,char* argv[])
{

    std::vector <std::string> sources;
    int *a;
    size_t mem = 0;
    int waittime = 10;
    char hostname[HOST_NAME_MAX];
    time_t t1, t2;

    for (int i = 1; i < argc; ++i) {
        if (std::string(argv[i]) == "-t") {
            if (i + 1 < argc) { // Make sure we aren't at the end of argv!
                std::stringstream ss1(argv[++i]);
                if (!(ss1 >> waittime))
                  std::cerr << "Invalid number " << argv[i] << '\n';
            } else { // Uh-oh, there was no argument to the destination option.
                  std::cerr << "-t option requires one argument." << std::endl;
                return 1;
            }
        } else if (std::string(argv[i]) == "-m") {
            if (i + 1 < argc) { // Make sure we aren't at the end of argv!
                std::stringstream ss2(argv[++i]);
                if (!(ss2 >> mem))
                    std::cerr << "Invalid number " << argv[i] << '\n';
            } else { // Uh-oh, there was no argument to the destination option.
                  std::cerr << "-m option requires one argument." << std::endl;
                return 1;
            }
        } else {
            sources.push_back(argv[i]);
        }
    }

    time(&t1);

    int result = gethostname(hostname, HOST_NAME_MAX);
    std::string hostname2 = hostname;

    std::cout << "Current host is: " + hostname2 << std::endl;
    std::cout << "Wait time is: " << waittime << " seconds" << std::endl;
    std::cout << "Memory usage is: " << mem << "MB" << std::endl;

    long int l = mem * 1024 * 1024;

    a = (int*)calloc(mem, 1024 * 1024);
    memset(a, 0, mem * 1024 * 1024);
    std::this_thread::sleep_for (std::chrono::seconds(waittime));
    free(a);

    time(&t2);
    std::cout << "Actually running time: " << difftime(t2, t1) << " seconds" << std::endl;
    return 0;
}
