이 Docker 이미지는 YOLOv7을 활용한 신호등 인지 모델이다. ROS2 통신을 활용하여 결과토픽을 전달한다.

# 이미지 환경 (Jetson Orin에서도 사용 가능)
Ubuntu 20.04 (amd,arm 둘 다 사용 가능)
CUDA 11.3.1
python 3.8
torch 1.10.1
torchvision 0.11.2
torchaudio 0.10.1

-best.pt
640 x 640 --> input 이미지는 반드시 학습 모델 이미지 사이즈와 동일해야 한다.




- 이미지 빌드 (현재 폴더 내에 있는 ros2_yolov7 폴더를 컨터이너 내부의 /home/docker_ws로 복사하여 이미지 빌드)
docker build -t chulwoo1011/yolov7:v7 .


- 이미지 빌드 후 다음 명령어를 이용해 컨테이너 빌드 ( 컨테이너 명 : yolov7 )
- /home/shared_ws 를 컨테이너 내부 폴더에 공유폴더를 지정하였으므로 공유폴더 사용 시 -v ~~/~~/~:/home/shared_ws 명령어 추가
- amd 버전
docker run -d -it --runtime --name yolov7 --ipc=host chulwoo1011/yolov7:v7
- arm 버전
docker run -d -it --runtime --name yolov7 --ipc=host chulwoo1011/yolov7:v7


# 모델 실행 방법
1. 반드시 가중치 파일이 있는 경로에서 수행해야 한다.
=> 컨테이너 빌드 후 object_detection 폴더 내에 있는 best.pt 파일을 /home/docker_ws 에 복사
2. /home/docker_ws 경로에서 colcon build 입력한다.
3. . install/setup.bash 입력한다.
4. ros2 launch object_detection object_detection.xml 을 입력하면 실행된다.

- 토픽 확인
현재 신호 상태
/state
