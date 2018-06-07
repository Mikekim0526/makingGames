/*
볼판 서버 연동시키기
2016-05-24
*/
#include "CurieIMU.h"

#include <Servo.h>
Servo servo1;  // 앞쪽 서보
Servo servo2;  // 왼쪽 서보
#define Servo1Pin 5	// 앞쪽 서보 모터 오렌지핀에 연결
#define Servo2Pin 6   // 왼쪽 서보 모터 오렌지핀에 연결  

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

	servo1.write(accX); // 변환된 X 값 서보에 적용 동작
	servo2.write(accY); // 변환된 X 값 서보에 적용 동작

	Serial.print(accX);
	Serial.print(" / ");
  Serial.print(accY);
  Serial.print(" / ");
	Serial.println(accZ);
	delay(25);
}

void setup() {
    Serial.begin(9600); // 시리얼 초기화
    CurieIMU.begin(); // 가속기 초기화
    CurieIMU.setAccelerometerRange(2); // 가속기 범위 설정
	CurieIMU.noAccelerometerOffset();
	CurieIMU.accelerometerOffsetEnabled();

    pinMode(Servo1Pin, OUTPUT); // 서버1 핀 출력설정
    pinMode(Servo2Pin, OUTPUT); // 서버2 핀 출력설정
	servo1.attach(Servo1Pin);  // 서버1 핀 연결설정
	servo2.attach(Servo2Pin);  // 서버2 핀 연결설정
}

void loop() {
	Accelerometer();
}
