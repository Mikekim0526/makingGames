#include "CurieIMU.h"

float convertRawAcceleration(int aRaw) {
  float a = (aRaw * 2.0) / 32768.0;
  return a;
}

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

	Serial.println(accX);
	//Serial.print(" / ");
  //Serial.println(accY);
	delay(125);
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
