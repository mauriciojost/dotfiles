# README

## Get started ultra quickly with simple example

Execute only once per environment:
```
sudo pip install -U platformio
git clone https://github.com/tensorflow/tensorflow.git ### pwd='/home/mjost/persospace/tensor-flow-esp32' 
git checkout master ### pwd='/home/mjost/persospace/tensor-flow-esp32/tensorflow' 
cd tensorflow/ ### pwd='/home/mjost/persospace/tensor-flow-esp32/tensorflow' 
```

Execute per project:
```
make -f tensorflow/lite/micro/tools/make/Makefile TARGET=esp generate_hello_world_esp_project ### pwd='/home/mjost/persospace/tensor-flow-esp32/tensorflow' 
cd tensorflow/lite/micro/tools/make/gen/esp_xtensa-esp32/prj/hello_world/esp-idf
vim platformio.ini # put content below
platformio run -e esp32dev
platformio run -e esp32dev -t upload
pio -f -c atom device monitor --raw --port /dev/ttyUSB0 -b 115200
```

Example of `platformio.ini`:
```
[platformio]
src_dir = main

[env:esp32dev]
platform = espressif32
framework = espidf
board = esp32dev

```

## Get started not so quickly

From [here](https://www.tensorflow.org/lite/microcontrollers/get_started).

## Get started with images

From [here](https://medium.com/analytics-vidhya/building-edge-ai-applications-using-tensorflow-lite-on-esp32-baf8534b176e).
