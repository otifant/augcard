# This code is based from this tutorial: https://www.youtube.com/watch?v=NZde8Xt78Iw
# by Murtaza's Workshop - Robotics and AI

import cv2
import mediapipe as mp
import time


class HandDetector:
    def __init__(self, mode=False, maxHands=8, detectionConfidence=0.5, trackCon=0.5):
        self.mode = mode
        self.maxHands = maxHands
        self.detectionConfidence = detectionConfidence
        self.trackCon = trackCon
        self.mpHands = mp.solutions.hands
        self.hands = self.mpHands.Hands(
            self.mode, self.maxHands, self.detectionConfidence, self.trackCon)
        self.mpDraw = mp.solutions.drawing_utils

    def findHands(self, img, draw=True):
        imgRGB = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
        self.results = self.hands.process(imgRGB)

        if self.results.multi_hand_landmarks:
            for handLms in self.results.multi_hand_landmarks:
                if draw:
                    self.mpDraw.draw_landmarks(
                        img, handLms, self.mpHands.HAND_CONNECTIONS)
        return img

    def findPosition(self, img, handNo=0, draw=True):

        lmList = []
        if self.results.multi_hand_landmarks:
            myHand = self.results.multi_hand_landmarks[handNo]
            for id, lm in enumerate(myHand.landmark):
                h, w, c = img.shape
                cx, cy = int(lm.x * w), int(lm.y * h)
                if id == 8:
                    if draw:
                        cv2.circle(img, (cx, cy), 7, (255, 0, 0), cv2.FILLED)
                lmList.append([id, cx, cy])
        return lmList


def main():
    pTime = 0  # previous time
    cTime = 0  # current time
    cap = cv2.VideoCapture(2)
    # cap = cv2.VideoCapture('rtsp://root:uwenadat@192.168.88.250/axis-media/media.amp')

    detector = HandDetector()

    while True:
        success, img = cap.read()
        # img = img[0:-200, 500:-1]
        img = detector.findHands(img)
        lmList = detector.findPosition(img)
        # if len(lmList) != 0:
            # print(lmList[8])

        cTime = time.time()
        fps = 1 / (cTime - pTime)
        pTime = cTime
        # print(int(fps))

        cv2.putText(img, str(int(fps)), (10, 70),
                    cv2.FONT_HERSHEY_PLAIN, 6, (255, 0, 255), 3)
        cv2.imshow('Image', img)
        cv2.waitKey(1)


if __name__ == '__main__':
    main()
