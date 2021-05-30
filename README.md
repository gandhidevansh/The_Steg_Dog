# The Steg Dog

A simple image steganography flutter application based on RGB algorithm originally developed by [Pratik Mante](https://github.com/PratikMante/Image-Steganography-in-Python).

## Working

### Front-End
- Developed using flutter.
- Contains an Encoding and a Decoding button on home screen.
- Feature to select picture from gallery or click-on-the-go and encode.
- A text box to enter the secret message to hide inside the image.
- Image converted to bytes and sent to server.
- Save the image.

### Back-End
- Developed on Python3. (Steg-Dog-Server)
- The algorithm stores the image on system and then does the processing. (This can be eliminated from code if required)
- Sends back the image as image bytes.


## Usage

- Clone the repository.
- pip3 install pillow, textwrap
- Steg-Dog-Server has the server file for backend along with sample images. Example images after the processing are included inside the repository. (tron - original, encoded_image, decoded_image)
- Other files are for flutter application, run/edit inside android studio or ide of your choice. 
- First of all start the flask server.
- Head to the directory where the server.py file is saved. From there use the command 'python Server.py' in the CMD to start the flask server.
- Using Ngrok forward HTTP requests to the port on which your flask server is running. (Note: we had used Ngrok for testing, but its not mandatory any other thing can be used as per your choice)
- Replace the URL in the Main.dart file at 2 places. (one where the encode request is made and other where decode request is made)

## Improvements that can be done

- Introducing mechanism for key generation and sharing can make the steganography way more secure. (or simply use a password for decryption for each image, this will need lots of reforming in code)
- Improving the UI functionalities.
- This is simple demonstration with no regard to threadings. Making the algorithm multithreaded for multiple users.
- Including the algorithm as flutter code itself rather than using a backend if possible. This can reduce time.


## Screen Shots
<img width="188" alt="Pic1" src="https://user-images.githubusercontent.com/31349598/120108079-30e22100-c181-11eb-9563-45ad1ee6a63a.png">
Selecting an image along with setting the secret message for encoding

<img width="187" alt="Pic2" src="https://user-images.githubusercontent.com/31349598/120108120-64bd4680-c181-11eb-876f-636d1845b141.png">
Image Received after encoding 

<img width="184" alt="Pic3" src="https://user-images.githubusercontent.com/31349598/120108151-8ae2e680-c181-11eb-833d-16e2d140069d.png">
Decoded image with a secret message (The red line is made to indicate the secret message)

<img width="190" alt="Pic4" src="https://user-images.githubusercontent.com/31349598/120108183-b1a11d00-c181-11eb-8f30-b22a2501104a.png">
Downloading and saving the image in the local storage

![image](https://user-images.githubusercontent.com/31349598/120108350-6afff280-c182-11eb-95be-df6efe8806bc.png)
Decoded image (magnified for better understanding)


Feel free to use the code and improve it to next level :+1:
Happy Coding!
