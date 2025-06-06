#pragma once

#include <iostream>
#include <sndfile.h>
#include <string>

class AudioConverter {
public:
  static bool convert(const std::string &inputPath,
                      const std::string &outputPath);
};
