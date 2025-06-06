#include "converter.hpp"
#include <cstring>
#include <iostream>
#include <vector>

bool AudioConverter::convert(const std::string &inputPath,
                             const std::string &outputPath) {
  SF_INFO inInfo, outInfo;
  std::memset(&inInfo, 0, sizeof(inInfo));
  std::memset(&outInfo, 0, sizeof(outInfo));

  SNDFILE *inFile = sf_open(inputPath.c_str(), SFM_READ, &inInfo);
  if (!inFile) {
    std::cerr << "Error opening input file: " << sf_strerror(nullptr)
              << std::endl;
    return false;
  }

  outInfo.samplerate = inInfo.samplerate;
  outInfo.channels = inInfo.channels;
  outInfo.format = SF_FORMAT_WAV | SF_FORMAT_PCM_16;

  SNDFILE *outFile = sf_open(outputPath.c_str(), SFM_WRITE, &outInfo);
  if (!outFile) {
    std::cerr << "Error opening output file: " << sf_strerror(nullptr)
              << std::endl;
    sf_close(inFile);
    return false;
  }

  constexpr size_t BUFFER_SIZE = 4096;
  std::vector<short> buffer(BUFFER_SIZE * outInfo.channels);

  sf_count_t readCount;
    while((readCount = sf_readf_short(inFile, buffer.data(), BUFFER_SIZE)) {
    sf_writef_short(outFile, buffer.data(), readCount);
    }

    // Закрываем файлы
    sf_close(inFile);
    sf_close(outFile);

    return true;
}

int main(int argc, char **argv) {
  if (argc != 3) {
    std::cout << "Usage: " << argv[0] << " <input.mp3> <output.wav>\n";
    return 1;
  }

  return AudioConverter::convert(argv[1], argv[2]) ? 0 : 1;
}
