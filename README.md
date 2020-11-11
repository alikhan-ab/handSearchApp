# handSearchApp
 A group project for the Senior Project I and Senior Project II courses.
 handSearchApp is a reverse sign language app for iOS that allows searching for signs in Russian Sign language by demonstrating a handshape in front of a mobile phone’s camera. In addition, it is possible to fingerspell a word or translate regular Russian language words into Russian Sign Language.
 
- The Russian Sign language vocabulary was taken from [Spreadthesign website](https://www.spreadthesign.com). 
- CoreData was used for working with the vocabulary.
- Create ML was used to transform pre-trained models used for handshape recognition to CoreML.
- The models for handshape recognition were obtained by applying transfer learning to [Deep Hand](https://openaccess.thecvf.com/content_cvpr_2016/papers/Koller_Deep_Hand_How_CVPR_2016_paper.pdf) pre-trained model.
 
 ## Search by Handshapes
 The main functionally of the application is the ability to search for signs by the handshapes that are used to form them.
 
 ![](https://github.com/alikhan-ab/handSearchApp/tree/master/SmartFingers/media/handshape.gif)
 
 One of the drawbacks of the current implementations is that the application doesn't detect hand position and only classifies an area in the middle of the frame.
 

 
## Search by Fingerspelling
In addition, the user can fingerspell a word to search for its sign-in Russian Sign Language.
 
 ![](https://github.com/alikhan-ab/handSearchApp/tree/master/SmartFingers/media/fingerspelling.gif)
 
In one of the previous implementations, both models used in Search by Handshapes and Search by Fingerspelling were hosted on a server.

 ## Search by Words and Category
Finally, the application can be used as a regular Russian to Russian Sign Language dictionary. 

![](https://github.com/alikhan-ab/handSearchApp/tree/master/SmartFingers/media/words.gif)

## Important
This repo doesn't contain all videos from the Russian Sign Language, instead, it uses a placeholder video.
