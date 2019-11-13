import os
from pathlib import Path
from shutil import copyfile
import re
#  /media/nurobot427/Extra/SeniorProject/Hand-CNN-master/outputs/result_1000000frame77.jpg
# result_1000000frame77
# /media/nurobot427/Extra/SeniorProject/Hand-CNN-master/outputs/result_1000000frame77_134,89,180,126.jpg
# result_1000000frame77_134,89,180,126

def get_sign(file_name):
	p = re.compile("/result_(.+)frame\d+(_\d+,\d+,\d+,\d+)?.jpg")
	result = p.search(file_name)
	return result.group(1)


def main():	
	hands_path = '/media/nurobot427/Extra/SeniorProject/new_hands_dis'
	out_path = '/media/nurobot427/Extra/SeniorProject/new_hands'


	i = 0
	for entry in os.scandir(hands_path):
		if entry.path.endswith("jpg"):
			image_path = entry.path
			image_name = Path(image_path).stem + ".jpg"

			sign_name = get_sign(image_path)

			save_dir = os.path.join(out_path, sign_name)

			if not os.path.exists(save_dir):
				os.makedirs(save_dir)

			copyfile(image_path, os.path.join(save_dir, image_name))
			i+=1
			print(i)

	print(i)

		
if __name__=="__main__":
	main()




