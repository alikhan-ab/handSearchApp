import cv2
import os
from pathlib import Path




def extract_frames(video_path, out_path):
	video_name = Path(video_path).stem

	i=0
	cap= cv2.VideoCapture(video_path)
	while(cap.isOpened()):
	    ret, frame = cap.read()
	    if ret == False:
	        break

	    cv2.imwrite(os.path.join(out_path, "{}frame{}.jpg".format(video_name, i)), frame)
	    i+=1

	cap.release()
	cv2.destroyAllWindows()
		

def main():	
	path = '/home/nurobot427/Documents/SeniorPorject/Videos'
	frames_path = '/media/nurobot427/Extra/Data/Frames'

	i = 0
	for entry in os.scandir(path):
		video_path = entry.path
		video_name = Path(video_path).stem
		out_path = os.path.join(frames_path, video_name)

		
		if not os.path.exists(out_path):
			os.makedirs(out_path)

		extract_frames(video_path, out_path)
		print(i)
		i+=1
		
if __name__=="__main__":
   main()
