import cv2
import mediapipe as mp
import time

cap = cv2.VideoCapture(0)

mpHands = mp.solutions.hands
hands = mpHands.Hands(max_num_hands=8)
mpDraw = mp.solutions.drawing_utils



pTime = 0 # previous time
cTime = 0 # current time

while True:
    success, img = cap.read()

    imgRGB = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
    results = hands.process(imgRGB)

    # print(results.multi_hand_landmarks)

    if results.multi_hand_landmarks:
        for handLms in results.multi_hand_landmarks:
            for id, lm in enumerate(handLms.landmark):
                h, w, c = img.shape
                cx, cy = int(lm.x * w), int(lm.y * h)
                if id==4:
                    cv2.circle(img, (cx, cy), 15, (255, 0, 255), cv2.FILLED)
                    print((lm.z + 1)/2*100)
            mpDraw.draw_landmarks(img, handLms, mpHands.HAND_CONNECTIONS)

    
    cTime = time.time()
    fps = 1 / (cTime - pTime)
    pTime = cTime

    x = str(int(fps))

    cv2.putText(img, str(int(fps)), (10, 70), cv2.FONT_HERSHEY_PLAIN, 6, (255, 0, 255), 3)
    cv2.imshow('Image', img)
    cv2.waitKey(1)