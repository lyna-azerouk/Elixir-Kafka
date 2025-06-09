# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file LICENSE.rst or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION ${CMAKE_VERSION}) # this file comes with cmake

# If CMAKE_DISABLE_SOURCE_CHANGES is set to true and the source directory is an
# existing directory in our source tree, calling file(MAKE_DIRECTORY) on it
# would cause a fatal error, even though it would be a no-op.
if(NOT EXISTS "/Users/smart-it/linaazerouk/Elixir-Kafka/kafka_x_elixir/deps/crc32cer/c_build/external/crc32c")
  file(MAKE_DIRECTORY "/Users/smart-it/linaazerouk/Elixir-Kafka/kafka_x_elixir/deps/crc32cer/c_build/external/crc32c")
endif()
file(MAKE_DIRECTORY
  "/Users/smart-it/linaazerouk/Elixir-Kafka/kafka_x_elixir/deps/crc32cer/c_build/external/src/google-crc32c-build"
  "/Users/smart-it/linaazerouk/Elixir-Kafka/kafka_x_elixir/deps/crc32cer/c_build/external"
  "/Users/smart-it/linaazerouk/Elixir-Kafka/kafka_x_elixir/deps/crc32cer/c_build/external/tmp"
  "/Users/smart-it/linaazerouk/Elixir-Kafka/kafka_x_elixir/deps/crc32cer/c_build/external/src/google-crc32c-stamp"
  "/Users/smart-it/linaazerouk/Elixir-Kafka/kafka_x_elixir/deps/crc32cer/c_build/external/src"
  "/Users/smart-it/linaazerouk/Elixir-Kafka/kafka_x_elixir/deps/crc32cer/c_build/external/src/google-crc32c-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/Users/smart-it/linaazerouk/Elixir-Kafka/kafka_x_elixir/deps/crc32cer/c_build/external/src/google-crc32c-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "/Users/smart-it/linaazerouk/Elixir-Kafka/kafka_x_elixir/deps/crc32cer/c_build/external/src/google-crc32c-stamp${cfgdir}") # cfgdir has leading slash
endif()
