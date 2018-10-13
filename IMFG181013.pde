#include "CurieIMU.h"

float convertRawAcceleration(int aRaw) {
  float a = (aRaw * 2.0) / 32768.0;
  return a;
}
int UsualY = 85;
const int LL= 40;
const int L = 60;
const int R = 100;
const int RR = 120;

int UsualX = 140;
const int FF = 130;
const int F = 137;
const int B = 150;
const int BB = 160;

int ten, one;

void Accelerometer(){
  int accX, accY, accZ;
  float ax, ay, az;

  CurieIMU.readAccelerometer(accX, accY, accZ);

  ax = convertRawAcceleration(accX)*100;
  ay = convertRawAcceleration(accY)*100;
  az = convertRawAcceleration(accZ)*100;  

  // 가속기 최소 최대 범위 제한 설정
  if(ax > 100) ax=100;
  if(ax < -100) ax=-100;
  if(ay > 100) ay=100;
  if(ay < -100) ay=-100;

  // 가속기 최대 최소값을 0~179 범위내로 변환
  accX = map(ax, -100, 100, 0, 179);
  accY = map(ay, -100, 100, 0, 179);

  if(accY<LL){
    ten=1;
  } else if(accY<L){
    ten=2;
  } else if(accY<R){
    ten=3;
  } else if(accY<RR){
    ten=4;
  } else{
    ten=5;
  }

  if(accX<FF){
    one=1;
  } else if(accX<F){
    one=2;
  } else if(accX<B){
    one=3;
  } else if(accX<BB){
    one=4;
  } else{
    one=5;
  }

  //Serial.print(accX);
  //Serial.print("  ");
  //Serial.println(accY);
  Serial.print(ten);
  Serial.println(one);
  delay(50);
}

void setup() {
  Serial.begin(9600); // 시리얼 초기화
  CurieIMU.begin(); // 가속기 초기화
  CurieIMU.setAccelerometerRange(2); // 가속기 범위 설정
  CurieIMU.noAccelerometerOffset();
  CurieIMU.accelerometerOffsetEnabled();
}

void loop() {
  Accelerometer();
}
